const admin = require('firebase-admin');
const serviceAccount = require('./admin_panel/firebase-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const auth = admin.auth();
const db = admin.firestore();

async function createAdmin() {
  const email = 'admin@servenow.com';
  const password = 'Admin@123';
  const name = 'Super Admin';

  try {
    let userRecord;
    try {
      userRecord = await auth.getUserByEmail(email);
      console.log('User already exists in Firebase Auth.');
    } catch (error) {
      if (error.code === 'auth/user-not-found') {
        userRecord = await auth.createUser({
          email: email,
          password: password,
          displayName: name,
        });
        console.log('Successfully created new user in Firebase Auth.');
      } else {
        throw error;
      }
    }

    // Add/Update in Firestore admins collection
    await db.collection('admins').doc(userRecord.uid).set({
      id: userRecord.uid,
      name: name,
      email: email,
      role: 'superadmin',
      isActive: true,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    });

    console.log(`Admin document created/updated in Firestore for UID: ${userRecord.uid}`);
    console.log('Login Credentials:');
    console.log(`Email: ${email}`);
    console.log(`Password: ${password}`);

  } catch (error) {
    console.error('Error creating admin:', error);
  } finally {
    process.exit();
  }
}

createAdmin();
