# ServeNow — Demo Database Seed Script

## What This Seeds
- 5 service categories → `categories` collection
- 15 services (3 per category) with prices, ratings, bookingCount, categoryName
- 3 banners for home screen carousel → `banners` collection
- 4 discount coupons
- App configuration

## Setup Instructions

### Step 1 — Get your Firebase Service Account key
1. Go to Firebase Console → Project Settings → Service Accounts
2. Click "Generate new private key"
3. Rename the downloaded file to: firebase-service-account.json
4. Place it in this folder (same folder as seed_all.js)

### Step 2 — Install dependencies
npm install

### Step 3 — Run the seed script
node seed_all.js

### Step 4 — Verify in Firebase Console
Go to Firebase Console → Firestore → Data
You should see:
- categories: 5 documents
- services: 15 documents
- banners: 3 documents
- coupons: 4 documents
- app_config: 1 document

## Notes
- Safe to run multiple times — uses set() so it overwrites without duplicating
- Does NOT seed users, bookings, or providers — those are created by the app
- To add more categories or services, edit seed_all.js and re-run

## Coupon Codes for Testing
| Code | Discount | Min Order |
|------|----------|-----------|
| FIRST50 | ₹50 flat | ₹200 |
| SAVE20 | 20% off | ₹300 |
| WELCOME100 | ₹100 flat | ₹500 |
| CLEAN30 | 30% off | ₹400 |
