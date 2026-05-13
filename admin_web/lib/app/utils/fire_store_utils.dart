import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin_web/app/models/admin_model.dart';
import 'package:admin_web/app/models/booking_model.dart';
import 'package:admin_web/app/models/customer_model.dart';
import 'package:admin_web/app/models/provider_model.dart';
import 'package:admin_web/app/models/handyman_model.dart';
import 'package:admin_web/app/models/service_model.dart';
import 'package:admin_web/app/models/category_model.dart';
import 'package:admin_web/app/models/coupon_model.dart';
import 'package:admin_web/app/models/rating_model.dart';
import 'package:admin_web/app/constants/collection_name.dart';

class FireStoreUtils {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // AUTH
  static Future<bool> isLogin() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  static Future<AdminModel?> getAdminProfile(String uid) async {
    final doc = await _firestore.collection(CollectionName.admins).doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return AdminModel.fromJson(doc.data()!);
    }
    return null;
  }

  static Future<bool> adminExistsInFirestore(String uid) async {
    final doc = await _firestore.collection(CollectionName.admins).doc(uid).get();
    return doc.exists;
  }

  // DASHBOARD STATS
  static Future<int> countBookings() async {
    final snapshot = await _firestore.collection(CollectionName.bookings).count().get();
    return snapshot.count ?? 0;
  }

  static Future<int> countPendingBookings() async {
    final snapshot = await _firestore
        .collection(CollectionName.bookings)
        .where('status', isEqualTo: 'pending')
        .count()
        .get();
    return snapshot.count ?? 0;
  }

  static Future<int> countTodayCompletedBookings() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final snapshot = await _firestore
        .collection(CollectionName.bookings)
        .where('status', isEqualTo: 'completed')
        .where('completedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .count()
        .get();
    return snapshot.count ?? 0;
  }

  static Future<double> getTodayRevenue() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final snapshot = await _firestore
        .collection(CollectionName.bookings)
        .where('status', isEqualTo: 'completed')
        .where('completedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .get();
    
    double revenue = 0.0;
    for (var doc in snapshot.docs) {
      revenue += (doc.data()['amount'] ?? 0.0).toDouble();
    }
    return revenue;
  }

  static Future<int> countActiveBookings() async {
    final snapshot = await _firestore
        .collection(CollectionName.bookings)
        .where('status', whereNotIn: ['completed', 'cancelled'])
        .count()
        .get();
    return snapshot.count ?? 0;
  }

  static Future<int> countCustomers() async {
    final snapshot = await _firestore.collection(CollectionName.customers).count().get();
    return snapshot.count ?? 0;
  }

  static Future<int> countProviders() async {
    final snapshot = await _firestore.collection(CollectionName.providers).count().get();
    return snapshot.count ?? 0;
  }

  static Future<int> countHandymen() async {
    final snapshot = await _firestore.collection(CollectionName.handymen).count().get();
    return snapshot.count ?? 0;
  }

  // BOOKINGS
  static Stream<QuerySnapshot> getBookingsStream() {
    return _firestore.collection(CollectionName.bookings).snapshots();
  }

  static Future<void> updateBookingStatus(String id, String status, {String? note}) async {
    final Map<String, dynamic> data = {
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (note != null && note.isNotEmpty) {
      data['adminNote'] = note;
    }
    await _firestore.collection(CollectionName.bookings).doc(id).update(data);
  }

  static Future<void> cancelBooking(String id, String reason, String cancelledBy) async {
    await _firestore.collection(CollectionName.bookings).doc(id).update({
      'status': 'cancelled',
      'cancellationReason': reason,
      'cancelledBy': cancelledBy,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> overrideBookingAmount(String id, double amount, String reason) async {
    await _firestore.collection(CollectionName.bookings).doc(id).update({
      'amount': amount,
      'adminNote': reason,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> reassignBooking(String id, String providerId, String providerName) async {
    await _firestore.collection(CollectionName.bookings).doc(id).update({
      'providerId': providerId,
      'providerName': providerName,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> addAdminNote(String id, String note) async {
    await _firestore.collection(CollectionName.bookings).doc(id).update({
      'adminNote': note,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // CUSTOMERS
  static Stream<QuerySnapshot> getCustomersStream() {
    return _firestore.collection(CollectionName.customers).snapshots();
  }

  static Future<void> blockCustomer(String id, bool block) async {
    await _firestore.collection(CollectionName.customers).doc(id).update({'isBlocked': block});
  }

  static Future<void> deleteCustomer(String id) async {
    await _firestore.collection(CollectionName.customers).doc(id).update({'isDeleted': true});
  }

  // PROVIDERS
  static Stream<QuerySnapshot> getProvidersStream() {
    return _firestore.collection(CollectionName.providers).snapshots();
  }

  static Stream<QuerySnapshot> getPendingProvidersStream() {
    return _firestore
        .collection(CollectionName.providers)
        .where('onboardingStatus', isEqualTo: 'pending_approval')
        .snapshots();
  }

  static Stream<QuerySnapshot> getAllPendingProvidersStream() {
    return _firestore
        .collection(CollectionName.providers)
        .where('onboardingStatus', whereIn: ['pending_approval', 'pending_profile'])
        .snapshots();
  }

  static Future<void> approveProvider(
      String providerId, String adminUid) async {
    // providerId must be the Firestore document ID
    // which equals the provider's Firebase Auth uid
    print('Approving provider: $providerId');
    
    final docRef = _firestore
      .collection(CollectionName.providers)
      .doc(providerId);
      
    final doc = await docRef.get();
    if (!doc.exists) {
      throw Exception(
        'Provider document not found: $providerId');
    }
    
    await docRef.update({
      'onboardingStatus': 'approved',
      'isActive': true,
      'approvedAt': FieldValue.serverTimestamp(),
      'approvedBy': adminUid,
      'updatedAt': FieldValue.serverTimestamp(),
      'commissionRate': 10.0,
    });
    
    print('Provider approved successfully: $providerId');
  }

  static Future<void> rejectProvider(String id, String reason) async {
    await _firestore.collection(CollectionName.providers).doc(id).update({
      'onboardingStatus': 'rejected',
      'rejectionReason': reason,
      'isActive': false,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> toggleProviderActive(String id, bool isActive) async {
    await _firestore.collection(CollectionName.providers).doc(id).update({
      'isActive': isActive,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateProviderCommission(String id, double rate) async {
    await _firestore.collection(CollectionName.providers).doc(id).update({
      'commissionRate': rate,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> fixProviderStatuses() async {
    final snapshot = await _firestore
        .collection(CollectionName.providers)
        .where('onboardingStatus', whereIn: ['completed', 'active'])
        .get();

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {
        'onboardingStatus': 'pending_approval',
        'isActive': false,
      });
    }
    if (snapshot.docs.isNotEmpty) {
      await batch.commit();
      print('Fixed ${snapshot.docs.length} providers');
    }
  }

  // HANDYMEN
  static Stream<QuerySnapshot> getHandymenStream() {
    return _firestore.collection(CollectionName.handymen).snapshots();
  }

  static Future<void> approveHandyman(String handymanId, String adminUid) async {
    await _firestore.collection(CollectionName.handymen).doc(handymanId).update({
      'onboardingStatus': 'approved',
      'isApproved': true,
      'isActive': true,
      'commissionRate': 20, // default commission rate on approval
      'approvedAt': FieldValue.serverTimestamp(),
      'approvedBy': adminUid,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> rejectHandyman(String handymanId, String adminUid, String reason) async {
    await _firestore.collection(CollectionName.handymen).doc(handymanId).update({
      'onboardingStatus': 'rejected',
      'isApproved': false,
      'isActive': false,
      'rejectedAt': FieldValue.serverTimestamp(),
      'rejectedBy': adminUid,
      'rejectionReason': reason,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateHandymanCommission(String id, int rate) async {
    await _firestore.collection(CollectionName.handymen).doc(id).update({
      'commissionRate': rate,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> toggleHandymanActive(String id, bool isActive) async {
    await _firestore.collection(CollectionName.handymen).doc(id).update({
      'isActive': isActive,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> reassignHandyman(String id, String providerId) async {
    await _firestore.collection(CollectionName.handymen).doc(id).update({'providerId': providerId});
  }

  // SERVICES
  static Stream<QuerySnapshot> getServicesStream() {
    return _firestore.collection(CollectionName.services).snapshots();
  }

  static Future<void> addService(ServiceModel service) async {
    await _firestore.collection(CollectionName.services).doc(service.id).set(service.toJson());
  }

  static Future<void> updateService(String id, Map<String, dynamic> data) async {
    await _firestore.collection(CollectionName.services).doc(id).update(data);
  }

  static Future<void> deleteService(String id) async {
    await _firestore.collection(CollectionName.services).doc(id).delete();
  }

  static Future<void> toggleService(String id, bool isActive) async {
    await _firestore.collection(CollectionName.services).doc(id).update({'isActive': isActive});
  }

  // CATEGORIES
  static Stream<QuerySnapshot> getCategoriesStream() {
    return _firestore.collection(CollectionName.serviceCategories).snapshots();
  }

  static Future<void> addCategory(CategoryModel cat) async {
    await _firestore.collection(CollectionName.serviceCategories).doc(cat.id).set(cat.toJson());
  }

  static Future<void> updateCategory(String id, Map<String, dynamic> data) async {
    await _firestore.collection(CollectionName.serviceCategories).doc(id).update(data);
  }

  static Future<void> deleteCategory(String id) async {
    await _firestore.collection(CollectionName.serviceCategories).doc(id).delete();
  }

  static Future<void> updateCategoryOrder(String id, int order) async {
    await _firestore.collection(CollectionName.serviceCategories).doc(id).update({'sortOrder': order});
  }

  static Future<void> seedDefaultCategories() async {
    final categoriesRef = _firestore.collection(CollectionName.serviceCategories);

    final existing = await categoriesRef.limit(1).get();
    if (existing.docs.isNotEmpty) return;

    final categories = [
      {'name': 'Plumbing', 'isActive': true, 'sortOrder': 1, 'iconUrl': '', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Electrical', 'isActive': true, 'sortOrder': 2, 'iconUrl': '', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Cleaning', 'isActive': true, 'sortOrder': 3, 'iconUrl': '', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Carpentry', 'isActive': true, 'sortOrder': 4, 'iconUrl': '', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Painting', 'isActive': true, 'sortOrder': 5, 'iconUrl': '', 'createdAt': FieldValue.serverTimestamp()},
      {
        'name': 'Appliance Repair',
        'isActive': true,
        'sortOrder': 6,
        'iconUrl': '',
        'createdAt': FieldValue.serverTimestamp()
      },
      {'name': 'Pest Control', 'isActive': true, 'sortOrder': 7, 'iconUrl': '', 'createdAt': FieldValue.serverTimestamp()},
      {'name': 'Home Shifting', 'isActive': true, 'sortOrder': 8, 'iconUrl': '', 'createdAt': FieldValue.serverTimestamp()},
    ];

    final batch = _firestore.batch();
    for (final cat in categories) {
      final ref = categoriesRef.doc();
      batch.set(ref, cat);
    }
    await batch.commit();
  }

  // COUPONS
  static Stream<QuerySnapshot> getCouponsStream() {
    return _firestore.collection(CollectionName.coupons).snapshots();
  }

  static Future<void> addCoupon(CouponModel coupon) async {
    await _firestore.collection(CollectionName.coupons).doc(coupon.id).set(coupon.toJson());
  }

  static Future<void> updateCoupon(String id, Map<String, dynamic> data) async {
    await _firestore.collection(CollectionName.coupons).doc(id).update(data);
  }

  static Future<void> deleteCoupon(String id) async {
    await _firestore.collection(CollectionName.coupons).doc(id).delete();
  }

  static Future<void> toggleCoupon(String id, bool isActive) async {
    await _firestore.collection(CollectionName.coupons).doc(id).update({'isActive': isActive});
  }

  // RATINGS
  static Stream<QuerySnapshot> getRatingsStream() {
    return _firestore.collection(CollectionName.ratings).snapshots();
  }

  static Future<void> toggleRatingVisibility(String id, bool isVisible) async {
    await _firestore.collection(CollectionName.ratings).doc(id).update({'isVisible': isVisible});
  }

  // WITHDRAWALS
  static Stream<QuerySnapshot> getWithdrawalsStream() {
    return _firestore.collection(CollectionName.transactions).where('type', isEqualTo: 'withdrawal').snapshots();
  }

  static Future<void> approveWithdrawal(String id, String adminNote) async {
    await _firestore.collection(CollectionName.transactions).doc(id).update({
      'status': 'approved',
      'note': adminNote,
      'processedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> rejectWithdrawal(String id, String reason) async {
    await _firestore.collection(CollectionName.transactions).doc(id).update({
      'status': 'rejected',
      'rejectionReason': reason,
      'processedAt': FieldValue.serverTimestamp(),
    });
  }

  // ANALYTICS
  static Future<List<Map<String, dynamic>>> getDailyRevenue(DateTime start, DateTime end) async {
    final snapshot = await _firestore
        .collection(CollectionName.bookings)
        .where('status', isEqualTo: 'completed')
        .where('completedAt', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('completedAt', isLessThanOrEqualTo: Timestamp.fromDate(end))
        .get();

    Map<String, double> dailyMap = {};
    for (var doc in snapshot.docs) {
      final date = (doc.data()['completedAt'] as Timestamp).toDate();
      final dateStr = '${date.year}-${date.month}-${date.day}';
      dailyMap[dateStr] = (dailyMap[dateStr] ?? 0.0) + (doc.data()['amount'] ?? 0.0).toDouble();
    }

    return dailyMap.entries.map((e) => {'date': e.key, 'revenue': e.value}).toList();
  }

  static Future<Map<String, double>> getRevenueByCategory() async {
    final snapshot = await _firestore
        .collection(CollectionName.bookings)
        .where('status', isEqualTo: 'completed')
        .get();

    Map<String, double> catMap = {};
    for (var doc in snapshot.docs) {
      final cat = doc.data()['serviceCategory'] ?? 'Unknown';
      catMap[cat] = (catMap[cat] ?? 0.0) + (doc.data()['amount'] ?? 0.0).toDouble();
    }
    return catMap;
  }

  static Future<List<Map<String, dynamic>>> getTopProviders() async {
    final snapshot = await _firestore
        .collection(CollectionName.providers)
        .limit(5)
        .get();
    
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // ANNOUNCEMENTS
  static Future<void> sendAnnouncement(String target, String title, String body) async {
    await _firestore.collection(CollectionName.announcements).add({
      'target': target,
      'title': title,
      'body': body,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Stream<QuerySnapshot> getAnnouncementsStream() {
    return _firestore.collection(CollectionName.announcements).snapshots();
  }

  // SETTINGS
  static Future<Map<String, dynamic>?> getPlatformSettings() async {
    final doc = await _firestore.collection(CollectionName.appSettings).doc('general').get();
    return doc.data();
  }

  static Future<void> updatePlatformSettings(Map<String, dynamic> data) async {
    await _firestore.collection(CollectionName.appSettings).doc('general').set(data, SetOptions(merge: true));
  }

  // ADMIN NOTIFICATIONS
  static Stream<QuerySnapshot> getUnreadNotificationsStream() {
    return _firestore
        .collection(CollectionName.adminNotifications)
        .where('isRead', isEqualTo: false)
        .snapshots();
  }

  static Future<void> markNotificationRead(String id) async {
    await _firestore.collection(CollectionName.adminNotifications).doc(id).update({'isRead': true});
  }

  // ADMIN USERS
  static Stream<QuerySnapshot> getAdminsStream() {
    return _firestore.collection(CollectionName.admins).snapshots();
  }

  static Future<void> addAdmin(AdminModel admin) async {
    await _firestore.collection(CollectionName.admins).doc(admin.id).set(admin.toJson());
  }

  static Future<void> toggleAdmin(String id, bool isActive) async {
    await _firestore.collection(CollectionName.admins).doc(id).update({'isActive': isActive});
  }

  static Future<void> updateAdminRole(String id, String role) async {
    await _firestore.collection(CollectionName.admins).doc(id).update({'role': role});
  }

  static Future<void> sendFCMToToken({
    required String token,
    required String title,
    required String body,
    Map<String, String> data = const {},
  }) async {
    // Write to fcm_queue collection
    // Cloud Function picks this up and sends FCM
    await _firestore.collection('fcm_queue').add({
      'token': token,
      'title': title,
      'body': body,
      'data': data,
      'createdAt': FieldValue.serverTimestamp(),
      'sent': false,
    });
  }
}
