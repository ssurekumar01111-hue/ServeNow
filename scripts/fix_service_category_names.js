const admin = require('firebase-admin');
const serviceAccount = require('../firebase-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

async function fixServiceCategories() {
  const categories = {};
  
  console.log('Fetching categories...');
  // Load all categories into a map
  const catSnap = await db.collection('categories').get();
  catSnap.docs.forEach(doc => {
    categories[doc.id] = doc.data().name;
  });
  
  console.log('Categories found:', Object.keys(categories).length);
  
  // Update all service docs
  console.log('Fetching services...');
  const serviceSnap = await db.collection('services').get();
  const batch = db.batch();
  let count = 0;
  
  serviceSnap.docs.forEach(doc => {
    const data = doc.data();
    let catId = data.categoryId;
    let catName = categories[catId];
    
    // Check if categoryId is actually a name (case-insensitive)
    if (!catName) {
      const foundCatId = Object.keys(categories).find(id => categories[id].toLowerCase() === catId.toLowerCase());
      if (foundCatId) {
        catId = foundCatId;
        catName = categories[catId];
        console.log(`Mismatch found (case-insensitive)! Updating service ${doc.id}: categoryId = ${catId}, categoryName = ${catName}`);
        batch.update(doc.ref, { categoryId: catId, categoryName: catName });
        count++;
      } else {
        console.log(`WARNING: No category found for service ${doc.id} with categoryId: ${catId}`);
      }
    } else if (!data.categoryName || data.categoryName === '') {
      console.log(`Updating service ${doc.id}: categoryName = ${catName}`);
      batch.update(doc.ref, { categoryName: catName });
      count++;
    }
  });
  
  if (count > 0) {
    await batch.commit();
    console.log(`Successfully updated ${count} services.`);
  } else {
    console.log('No services needed updating.');
  }
  console.log('Done!');
}

fixServiceCategories().catch(console.error);
