# ServeNow — Firestore Indexes & Rules Deployment

## Prerequisites
- Firebase CLI installed: npm install -g firebase-tools
- Logged in: firebase login
- Firebase project created and linked: firebase use YOUR_PROJECT_ID

## Deploy Instructions

### Windows:
Double-click deploy_indexes.bat OR run in terminal:
firebase deploy --only firestore:indexes,firestore:rules,storage

### Mac/Linux:
chmod +x deploy_indexes.sh
./deploy_indexes.sh

## What Gets Deployed
- firestore.indexes.json — All composite indexes required for app queries
- firestore.rules — Security rules for all collections
- storage.rules — Firebase Storage access rules

## Index Build Time
Indexes take 2-5 minutes to build after deployment.
The app will work immediately but some queries may be slower until indexes are ready.
You can monitor index build status at:
Firebase Console → Firestore → Indexes
