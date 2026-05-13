const admin = require('firebase-admin');
const serviceAccount = require('../firebase-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function fixServices() {
  const snapshot = await db.collection('services').get();
  const batch = db.batch();
  let updatedCount = 0;
  
  snapshot.docs.forEach((doc) => {
    const data = doc.data();
    if (data.bookingCount === undefined || data.bookingCount === null) {
      batch.update(doc.ref, { bookingCount: 0 });
      updatedCount++;
    }
  });

  if (updatedCount > 0) {
    await batch.commit();
  }
  console.log(`Updated ${updatedCount} service documents with bookingCount: 0`);
}

fixServices().catch(console.error);
