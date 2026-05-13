'use strict';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
// const Razorpay = require('razorpay');

admin.initializeApp();

const REGION = 'asia-south1';
const db = admin.firestore();
const regionalFunctions = functions.region(REGION);

// TODO(buyer): Add your Razorpay Key ID and Key Secret here
// Get your keys from: https://dashboard.razorpay.com/app/keys
// const razorpay = new Razorpay({
//   key_id: 'rzp_test_YOUR_KEY_ID',
//   key_secret: 'rzp_test_YOUR_KEY_SECRET',
// });

// ─── HELPER FUNCTIONS ──────────────────────────────

function formatDateTime(timestamp) {
  if (!timestamp) return 'the scheduled time';
  try {
    const date = timestamp.toDate
      ? timestamp.toDate()
      : new Date((timestamp._seconds || timestamp.seconds) * 1000);
    return date.toLocaleDateString('en-IN', {
      day: 'numeric',
      month: 'short',
      year: 'numeric',
    }) + ' at ' + date.toLocaleTimeString('en-IN', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true,
    });
  } catch (e) {
    return 'the scheduled time';
  }
}

function getDistanceMetres(lat1, lng1, lat2, lng2) {
  const R = 6371000;
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLng = (lng2 - lng1) * Math.PI / 180;
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(lat1 * Math.PI / 180) *
    Math.cos(lat2 * Math.PI / 180) *
    Math.sin(dLng / 2) * Math.sin(dLng / 2);
  return R * 2 * Math.atan2(
    Math.sqrt(a), Math.sqrt(1 - a));
}

async function sendFCM(token, title, body, data = {}) {
  if (!token) return;
  try {
    await admin.messaging().send({
      token,
      notification: { title, body },
      // FIX: Ensure all data values are strings (fixes processFCMQueue-style calls too)
      data: Object.fromEntries(
        Object.entries(data).map(
          ([k, v]) => [k, String(v)])),
      android: {
        notification: {
          sound: 'default',
          priority: 'high',
        },
      },
      apns: {
        payload: {
          aps: { sound: 'default' },
        },
      },
    });
    console.log(`FCM sent to token: ${token.substring(0, 20)}...`);
  } catch (e) {
    console.error('FCM send error:', e.message);
  }
}

async function creditEarnings(bookingId, bookingData) {
  try {
    const amount = bookingData.amount || 0;
    const providerId = bookingData.providerId;
    const handymanId = bookingData.assignedHandymanId;

    // 1. Fetch Provider Data for commissionRate
    let providerCommissionRate = 10;
    if (providerId) {
      const providerSnap = await db.collection('providers').doc(providerId).get();
      if (providerSnap.exists) {
        providerCommissionRate = providerSnap.data().commissionRate || 10;
      }
    }

    // 2. Calculate Platform Commission
    const platformCommission = (amount * providerCommissionRate) / 100;
    const remaining = amount - platformCommission;

    // 3. Fetch Handyman Data for commissionRate
    let handymanEarning = 0;
    let handymanCommissionRate = 0;
    if (handymanId) {
      const handymanSnap = await db.collection('handymen').doc(handymanId).get();
      if (handymanSnap.exists) {
        handymanCommissionRate = handymanSnap.data().commissionRate || 0;
        handymanEarning = (remaining * handymanCommissionRate) / 100;
      }
    }

    const providerEarning = remaining - handymanEarning;
    const commission = platformCommission;

    console.log(`Crediting earnings: amount=${amount} commission=${commission} providerEarning=${providerEarning} handymanEarning=${handymanEarning} handymanId=${handymanId} providerId=${providerId}`);

    // 4. Update Booking Document with all four values
    const bookingRef = db.collection('bookings').doc(bookingId);
    await bookingRef.update({
      commission: platformCommission,
      providerEarning: providerEarning,
      handymanEarning: handymanEarning,
      handymanCommissionRate: handymanCommissionRate,
    });

    const batch = db.batch();

    // Credit PROVIDER wallet
    if (providerId) {
      const provRef = db.collection('providers').doc(providerId);
      const provWalletRef = provRef.collection('wallet').doc('info');
      const provTransRef = provRef.collection('transactions').doc();

      batch.set(provWalletRef, {
        balance: admin.firestore.FieldValue.increment(providerEarning),
        totalEarned: admin.firestore.FieldValue.increment(providerEarning),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      }, { merge: true });

      batch.set(provTransRef, {
        type: 'earning',
        amount: providerEarning,
        bookingId,
        serviceName: bookingData.serviceName || '',
        status: 'completed',
        createdAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      batch.update(provRef, {
        totalEarnings: admin.firestore.FieldValue.increment(providerEarning),
        walletBalance: admin.firestore.FieldValue.increment(providerEarning),
        totalBookings: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // Credit HANDYMAN wallet
    if (handymanId) {
      const handymanRef = db.collection('handymen').doc(handymanId);
      const handymanTransRef = handymanRef.collection('transactions').doc();

      if (handymanEarning > 0) {
        batch.set(handymanTransRef, {
          type: 'earning',
          amount: handymanEarning,
          bookingId,
          serviceName: bookingData.serviceName || '',
          status: 'completed',
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });
      }

      batch.update(handymanRef, {
        totalEarnings: admin.firestore.FieldValue.increment(handymanEarning),
        walletBalance: admin.firestore.FieldValue.increment(handymanEarning),
        completedJobs: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    // Platform earns commission
    const revenueRef = db.collection('platform_revenue').doc();
    batch.set(revenueRef, {
      bookingId,
      commission,
      providerId,
      handymanId,
      serviceName: bookingData.serviceName || '',
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    await batch.commit();
    console.log('Earnings credited successfully');

  } catch (e) {
    console.error('Error crediting earnings:', e);
  }
}

// ─── FUNCTION 1: NEW BOOKING ALERT TO PROVIDER ─────

exports.onNewBooking = regionalFunctions
  .firestore
  .document('bookings/{bookingId}')
  .onCreate(async (snap, context) => {
    const data = snap.data();
    const bookingId = context.params.bookingId;

    console.log('New booking created:', bookingId);

    // Increment bookingCount for the service
    if (data.serviceId) {
      await db.collection('services').doc(data.serviceId).update({
        bookingCount: admin.firestore.FieldValue.increment(1),
      });
    }

    // FIX: If providerId is missing (e.g. from Admin-created global services), 
    // notify all approved providers in this category.
    if (!data.providerId) {
      console.warn(`Booking ${bookingId} has no providerId — attempting to notify category providers`);
      
      try {
        // 1. Get service category from the service record
        const serviceDoc = await db.collection('services').doc(data.serviceId).get();
        const categoryId = serviceDoc.exists ? serviceDoc.data().categoryId : null;

        if (categoryId) {
          // 2. Find all approved & active providers in this category
          const providers = await db.collection('providers')
            .where('categories', 'array-contains', categoryId)
            .where('onboardingStatus', '==', 'approved')
            .where('isActive', '==', true)
            .get();

          console.log(`Found ${providers.size} providers to notify for category: ${categoryId}`);

          const fcmPromises = providers.docs
            .filter(doc => doc.data().fcmToken)
            .map(doc => sendFCM(
              doc.data().fcmToken,
              'New Open Job Request!',
              `${data.customerName} needs ${data.serviceName}. Claim this job now!`,
              { type: 'new_booking', bookingId }
            ));

          await Promise.all(fcmPromises);
        } else {
          console.warn(`Could not determine category for service ${data.serviceId} — no providers notified`);
        }
      } catch (err) {
        console.error('Failed to notify category providers:', err);
      }
      return null;
    }

    const providerDoc = await db
      .collection('providers')
      .doc(data.providerId)
      .get();

    if (providerDoc.exists) {
      const provider = providerDoc.data();
      await sendFCM(
        provider.fcmToken,
        'New Booking Request!',
        `${data.customerName} has requested`
          + ` ${data.serviceName}`
          + ` on ${formatDateTime(data.scheduledDate)}`
          + `. Accept now!`,
        { type: 'new_booking', bookingId }
      );
    }
    return null;
  });

// ─── FUNCTION 2: BOOKING STATUS CHANGES ────────────

exports.onBookingStatusChanged = regionalFunctions
  .firestore
  .document('bookings/{bookingId}')
  .onUpdate(async (change, context) => {
    const newData = change.after.data();
    const oldData = change.before.data();
    const bookingId = context.params.bookingId;

    if (oldData.status === newData.status) return null;

    console.log(`Booking ${bookingId} status: ${oldData.status} → ${newData.status}`);

    const scheduledStr = formatDateTime(newData.scheduledDate);
    const service = newData.serviceName || 'service';
    const handyman = newData.assignedHandymanName || 'Your handyman';
    const provider = newData.providerName || 'Your provider';

    // FIX: Guard each .doc() call against undefined/empty IDs —
    // was crashing with "Path must be a non-empty string" for
    // bookings missing customerId, providerId, or assignedHandymanId
    const customerToken = newData.customerId
      ? ((await db.collection('customers').doc(newData.customerId).get()).data()?.fcmToken ?? null)
      : null;

    const providerToken = newData.providerId
      ? ((await db.collection('providers').doc(newData.providerId).get()).data()?.fcmToken ?? null)
      : null;

    let handymanToken = null;
    if (newData.assignedHandymanId) {
      const handymanDoc = await db.collection('handymen').doc(newData.assignedHandymanId).get();
      handymanToken = handymanDoc.exists ? handymanDoc.data().fcmToken : null;
    }

    const bookingData = {
      type: 'booking_update',
      bookingId,
      status: newData.status,
    };

    switch (newData.status) {
      case 'confirmed':
        await sendFCM(customerToken, 'Booking Confirmed!', `${provider} confirmed your ${service} on ${scheduledStr}.`, bookingData);
        break;

      case 'assigned':
        if (newData.assignedHandymanId) {
          await db.collection('handymen').doc(newData.assignedHandymanId).update({
            assignedJobs: admin.firestore.FieldValue.increment(1),
          });
        }
        await sendFCM(customerToken, 'Handyman Assigned!', `${handyman} will handle your ${service}. Share your OTP when they arrive.`, bookingData);
        await sendFCM(handymanToken, 'New Job Assigned!', `New job: ${service} at ${newData.customerArea || 'your area'} on ${scheduledStr}.`, { ...bookingData, type: 'booking_assigned' });
        break;

      case 'en_route':
        await sendFCM(customerToken, 'Handyman On The Way!', `${handyman} is heading to your location.`, bookingData);
        break;

      case 'arrived':
        await sendFCM(customerToken, 'Handyman Arrived!', `${handyman} has arrived. Share your 4-digit OTP to start.`, bookingData);
        break;

      case 'in_progress':
        await sendFCM(customerToken, 'Job Started', `Your ${service} job has started.`, bookingData);
        break;

      case 'completed':
        await creditEarnings(bookingId, newData);
        await sendFCM(customerToken, 'Job Completed!', `Your ${service} is done. Rate your experience!`, bookingData);
        break;

      case 'cancelled':
        if (newData.cancelledBy === 'provider') {
          await sendFCM(customerToken, 'Booking Cancelled', `Your ${service} booking was cancelled by the provider.`, bookingData);
        } else if (newData.cancelledBy === 'customer') {
          await sendFCM(providerToken, 'Booking Cancelled', `${newData.customerName} cancelled their ${service} booking.`, bookingData);
        } else if (newData.cancelledBy === 'admin') {
          await sendFCM(customerToken, 'Booking Cancelled', `Your ${service} booking was cancelled by admin.`, bookingData);
          await sendFCM(providerToken, 'Booking Cancelled', `A ${service} booking was cancelled by admin.`, bookingData);
        }
        break;
    }
    return null;
  });

// ─── FUNCTION 3: AUTO ASSIGN HANDYMAN ──────────────

exports.autoAssignHandyman = regionalFunctions
  .runWith({ timeoutSeconds: 300, memory: '256MB' })
  .firestore
  .document('bookings/{bookingId}')
  .onUpdate(async (change, context) => {
    const newData = change.after.data();
    const oldData = change.before.data();
    const bookingId = context.params.bookingId;

    if (oldData.status === newData.status) return null;
    if (newData.status !== 'confirmed') return null;
    if (newData.assignedHandymanId) return null;

    console.log(`Booking confirmed: ${bookingId} — waiting 3 min for auto-assignment`);

    await new Promise(r => setTimeout(r, 180000));

    const fresh = await db.collection('bookings').doc(bookingId).get();
    if (!fresh.exists) return null;
    const current = fresh.data();

    if (current.assignedHandymanId || current.status !== 'confirmed') return null;

    console.log('Searching for online handymen...');
    const snap = await db.collection('handymen').where('isOnline', '==', true).where('isApproved', '==', true).get();

    if (snap.empty) {
      if (current.providerId) {
        const provDoc = await db.collection('providers').doc(current.providerId).get();
        if (provDoc.exists && provDoc.data().fcmToken) {
          await sendFCM(provDoc.data().fcmToken, 'No Handymen Available', `No handymen available for ${current.serviceName}. We will retry automatically.`, { type: 'no_handyman_available', bookingId });
        }
      }
      return null;
    }

    const handymen = snap.docs.map(d => ({ id: d.id, ...d.data() }));
    const customerLat = current.customerLat;
    const customerLng = current.customerLng;
    let selected;

    if (customerLat && customerLng) {
      const withDist = handymen.map(h => {
        const hLat = h.location?.lat ?? h.lat ?? h.latitude;
        const hLng = h.location?.lng ?? h.lng ?? h.longitude;
        const dist = (hLat && hLng)
          ? getDistanceMetres(customerLat, customerLng, hLat, hLng)
          : 999999;
        return { ...h, dist };
      });
      withDist.sort((a, b) => a.dist - b.dist);

      for (const h of withDist) {
        const activeJobs = await db.collection('bookings')
          .where('assignedHandymanId', '==', h.id)
          .where('status', 'in', ['assigned', 'en_route', 'arrived', 'in_progress'])
          .get();
        if (activeJobs.size < 2) {
          selected = h;
          break;
        }
      }
      if (!selected) selected = withDist[0];
    } else {
      const withJobs = await Promise.all(handymen.map(async h => {
        const jobs = await db.collection('bookings')
          .where('assignedHandymanId', '==', h.id)
          .where('status', 'in', ['assigned', 'en_route', 'arrived', 'in_progress'])
          .get();
        return { ...h, jobCount: jobs.size };
      }));
      withJobs.sort((a, b) => a.jobCount - b.jobCount);
      selected = withJobs[0];
    }

    if (!selected) return null;

    const handymanName = selected.name || selected.fullName || selected.displayName || 'Handyman';

    // FIX: Removed duplicate sendFCM calls that were here before.
    // Writing status='assigned' triggers onBookingStatusChanged which
    // already sends FCM to both customer and handyman — sending here
    // too was causing every auto-assignment to send 2x notifications.
    await db.collection('bookings').doc(bookingId).update({
      assignedHandymanId: selected.id,
      assignedHandymanName: handymanName,
      status: 'assigned',
      autoAssigned: true,
      autoAssignedAt: admin.firestore.FieldValue.serverTimestamp(),
      updatedAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    return null;
  });

// ─── FUNCTION 4: RATING AVERAGE UPDATE ─────────────

exports.onRatingCreated = regionalFunctions
  .firestore
  .document('ratings/{ratingId}')
  .onCreate(async (snap, context) => {
    const data = snap.data();

    // FIX: New rating may not have isVisible:true at creation time,
    // causing it to be excluded from the average it's supposed to update.
    // Mark it visible first, then compute the average.

    // Update provider rating
    if (data.providerId) {
      // Ensure the new rating is marked visible before computing average
      if (!data.isVisible) {
        await snap.ref.update({ isVisible: true });
      }

      const ratingsSnap = await db
        .collection('ratings')
        .where('providerId', '==', data.providerId)
        .where('isVisible', '==', true)
        .get();

      const ratings = ratingsSnap.docs
        .map(d => d.data().providerRating || 0);
      const avg = ratings.length > 0
        ? ratings.reduce((a, b) => a + b, 0) / ratings.length
        : 0;

      await db.collection('providers')
        .doc(data.providerId)
        .update({
          rating: Math.round(avg * 10) / 10,
          totalRatings: ratings.length,
        });
    }

    // Update handyman rating
    if (data.handymanId) {
      const ratingsSnap = await db
        .collection('ratings')
        .where('handymanId', '==', data.handymanId)
        .where('isVisible', '==', true)
        .get();

      const ratings = ratingsSnap.docs
        .map(d => d.data().handymanRating || 0);
      const avg = ratings.length > 0
        ? ratings.reduce((a, b) => a + b, 0) / ratings.length
        : 0;

      await db.collection('handymen')
        .doc(data.handymanId)
        .update({
          rating: Math.round(avg * 10) / 10,
          totalRatings: ratings.length,
        });
    }

    return null;
  });

// ─── FUNCTION 5: PROVIDER APPROVAL ──────────────────

exports.onProviderApproved = regionalFunctions
  .firestore
  .document('providers/{providerId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.onboardingStatus !== 'approved' && after.onboardingStatus === 'approved') {
      const providerToken = after.fcmToken;
      if (providerToken) {
        await sendFCM(providerToken, 'Account Approved!', 'You can now start accepting bookings.');
      }
    }
    return null;
  });

// ─── FUNCTION 5.1: HANDYMAN APPROVAL ────────────────

exports.onHandymanApproved = regionalFunctions
  .firestore
  .document('handymen/{uid}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();

    if (before.onboardingStatus === after.onboardingStatus) return null;

    const fcmToken = after.fcmToken;
    if (!fcmToken) return null;

    let title, body;
    if (after.onboardingStatus === 'approved') {
      title = 'Application Approved!';
      body = 'Welcome to ServeNow! You can now start accepting jobs.';
    } else if (after.onboardingStatus === 'rejected') {
      title = 'Application Update';
      body = 'Your application was not approved. Please contact support.';
    } else {
      return null;
    }

    await sendFCM(fcmToken, title, body, { type: 'handyman_approval', status: after.onboardingStatus });
    return null;
  });

// ─── FUNCTION 6: BOOKING REMINDERS ──────────────────

exports.sendBookingReminders = regionalFunctions
  .pubsub
  .schedule('every 60 minutes')
  .onRun(async (context) => {
    try {
      const now = new Date();
      const oneHourLater = new Date(now.getTime() + 60 * 60 * 1000);
      const twoHoursLater = new Date(now.getTime() + 2 * 60 * 60 * 1000);

      const bookingsSnapshot = await db.collection('bookings')
        .where('status', 'in', ['confirmed', 'assigned'])
        // FIX: Added reminderSent filter to avoid sending duplicate reminders
        // on consecutive hourly runs for the same booking.
        // A booking at T+90min matched BOTH the run at T and T+60 previously.
        .where('reminderSent', '==', false)
        .get();

      const promises = [];
      bookingsSnapshot.forEach(doc => {
        const booking = doc.data();
        const bookingId = doc.id;

        if (booking.scheduledDate) {
          const scheduledAt = booking.scheduledDate.toDate
            ? booking.scheduledDate.toDate()
            : new Date((booking.scheduledDate._seconds || booking.scheduledDate.seconds) * 1000);

          // FIX: Window now matches the schedule interval (next 60–120 min)
          // instead of a 2-hour window, preventing duplicate sends across runs.
          if (scheduledAt > oneHourLater && scheduledAt <= twoHoursLater) {
            promises.push((async () => {
              if (!booking.customerId) return;
              const customerDoc = await db.collection('customers').doc(booking.customerId).get();
              const token = customerDoc.exists ? customerDoc.data().fcmToken : null;
              if (token) {
                await sendFCM(token, 'Booking Reminder!', `Your booking for ${booking.serviceName} is in about 2 hours!`);
                // Mark as sent so the next hourly run skips this booking
                await doc.ref.update({ reminderSent: true });
              }
            })());
          }
        }
      });

      await Promise.all(promises);
    } catch (error) {
      console.error('sendBookingReminders Error:', error);
    }
    return null;
  });

// ─── FUNCTION 7: PROCESS FCM QUEUE ──────────────────

exports.processFCMQueue = regionalFunctions
  .firestore
  .document('fcm_queue/{docId}')
  .onCreate(async (snap, context) => {
    const data = snap.data();
    if (data.sent) return null;

    try {
      await admin.messaging().send({
        token: data.token,
        notification: {
          title: data.title,
          body: data.body,
        },
        // FIX: FCM requires all data values to be strings.
        // Was passing raw data.data object which could contain non-strings.
        data: Object.fromEntries(
          Object.entries(data.data || {}).map(([k, v]) => [k, String(v)])
        ),
      });

      await snap.ref.update({ sent: true });
      console.log('FCM sent via queue');
    } catch (e) {
      console.error('FCM queue error:', e);
      await snap.ref.update({
        sent: false,
        error: e.message,
      });
    }
    return null;
  });

// ─── FUNCTION 8: CREATE RAZORPAY ORDER ──────────────

exports.createRazorpayOrder = functions
  .region('asia-south1')
  .https.onCall(async (data, context) => {
    // TODO(buyer): Add your Razorpay Key ID and Key Secret here
    // See documentation: Firebase Setup Guide → Razorpay Integration
    throw new functions.https.HttpsError(
      'unimplemented',
      'Razorpay is not configured. Please add your API keys. See setup documentation.'
    );
  });