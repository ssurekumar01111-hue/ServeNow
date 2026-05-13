const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

console.log('---------------------------------------------------------');
console.log('ServeNow — Demo Database Seed Script');
console.log('---------------------------------------------------------');
console.log('Place your firebase-service-account.json in this folder then run: node seed_all.js');
console.log('---------------------------------------------------------');

const serviceAccountPath = path.join(__dirname, 'firebase-service-account.json');

if (!fs.existsSync(serviceAccountPath)) {
  console.error('Error: firebase-service-account.json not found!');
  process.exit(1);
}

const serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const categories = [
  { id: 'cleaning', name: 'Cleaning', iconName: 'cleaning_services', color: '#4A6CF7', isActive: true, sortOrder: 1 },
  { id: 'ac_repair', name: 'AC Repair', iconName: 'ac_unit', color: '#10B981', isActive: true, sortOrder: 2 },
  { id: 'plumbing', name: 'Plumbing', iconName: 'plumbing', color: '#3B82F6', isActive: true, sortOrder: 3 },
  { id: 'electrical', name: 'Electrical', iconName: 'electrical_services', color: '#F59E0B', isActive: true, sortOrder: 4 },
  { id: 'beauty', name: 'Beauty & Salon', iconName: 'face_retouching_natural', color: '#EC4899', isActive: true, sortOrder: 5 },
];

const services = [
  // Cleaning
  { id: 'svc_cleaning_1', name: 'Full House Cleaning', description: 'Complete deep cleaning of your entire home by trained professionals. Includes all rooms, kitchen, and bathrooms.', categoryId: 'cleaning', categoryName: 'Cleaning', basePrice: 799, discountPrice: 599, duration: 180, rating: 4.8, reviewCount: 124, bookingCount: 124, isActive: true, imageUrl: '' },
  { id: 'svc_cleaning_2', name: 'Kitchen Deep Clean', description: 'Thorough cleaning of kitchen including appliances, cabinets, countertops and floor.', categoryId: 'cleaning', categoryName: 'Cleaning', basePrice: 499, discountPrice: 399, duration: 120, rating: 4.6, reviewCount: 89, bookingCount: 89, isActive: true, imageUrl: '' },
  { id: 'svc_cleaning_3', name: 'Bathroom Sanitization', description: 'Professional bathroom cleaning and sanitization. Removes stains, mold and bacteria.', categoryId: 'cleaning', categoryName: 'Cleaning', basePrice: 299, discountPrice: 249, duration: 60, rating: 4.7, reviewCount: 67, bookingCount: 67, isActive: true, imageUrl: '' },
  // AC Repair
  { id: 'svc_ac_1', name: 'AC Service & Gas Refill', description: 'Complete AC servicing including cleaning, gas top-up and performance check.', categoryId: 'ac_repair', categoryName: 'AC Repair', basePrice: 599, discountPrice: 399, duration: 90, rating: 4.6, reviewCount: 89, bookingCount: 89, isActive: true, imageUrl: '' },
  { id: 'svc_ac_2', name: 'AC Installation', description: 'Professional installation of split or window AC units. Includes bracket fitting and testing.', categoryId: 'ac_repair', categoryName: 'AC Repair', basePrice: 999, discountPrice: 799, duration: 120, rating: 4.8, reviewCount: 45, bookingCount: 45, isActive: true, imageUrl: '' },
  { id: 'svc_ac_3', name: 'AC Repair & Diagnosis', description: 'Expert diagnosis and repair of AC cooling issues, noise problems and water leakage.', categoryId: 'ac_repair', categoryName: 'AC Repair', basePrice: 449, discountPrice: 349, duration: 60, rating: 4.5, reviewCount: 112, bookingCount: 112, isActive: true, imageUrl: '' },
  // Plumbing
  { id: 'svc_plumbing_1', name: 'Tap & Pipe Repair', description: 'Fix leaking taps, pipes, and connections quickly. Same day service available.', categoryId: 'plumbing', categoryName: 'Plumbing', basePrice: 349, discountPrice: 249, duration: 60, rating: 4.7, reviewCount: 67, bookingCount: 67, isActive: true, imageUrl: '' },
  { id: 'svc_plumbing_2', name: 'Drainage Unblocking', description: 'Clear blocked drains, pipes and sewage lines using professional equipment.', categoryId: 'plumbing', categoryName: 'Plumbing', basePrice: 499, discountPrice: 399, duration: 90, rating: 4.4, reviewCount: 98, bookingCount: 98, isActive: true, imageUrl: '' },
  { id: 'svc_plumbing_3', name: 'Water Tank Cleaning', description: 'Professional cleaning and disinfection of overhead or underground water tanks.', categoryId: 'plumbing', categoryName: 'Plumbing', basePrice: 699, discountPrice: 549, duration: 120, rating: 4.6, reviewCount: 56, bookingCount: 56, isActive: true, imageUrl: '' },
  // Electrical
  { id: 'svc_electrical_1', name: 'Switchboard & Wiring Fix', description: 'Safe repair of switchboards, loose wiring, short circuits and electrical faults.', categoryId: 'electrical', categoryName: 'Electrical', basePrice: 299, discountPrice: 199, duration: 45, rating: 4.9, reviewCount: 203, bookingCount: 203, isActive: true, imageUrl: '' },
  { id: 'svc_electrical_2', name: 'Fan Installation & Repair', description: 'Install new ceiling fans or repair existing ones. Includes speed regulator setup.', categoryId: 'electrical', categoryName: 'Electrical', basePrice: 249, discountPrice: 199, duration: 45, rating: 4.7, reviewCount: 134, bookingCount: 134, isActive: true, imageUrl: '' },
  { id: 'svc_electrical_3', name: 'Home Wiring & Inspection', description: 'Complete home electrical inspection and wiring work by certified electricians.', categoryId: 'electrical', categoryName: 'Electrical', basePrice: 799, discountPrice: 649, duration: 180, rating: 4.8, reviewCount: 78, bookingCount: 78, isActive: true, imageUrl: '' },
  // Beauty
  { id: 'svc_beauty_1', name: 'Haircut & Styling', description: 'Professional haircut and styling at your doorstep by experienced stylists.', categoryId: 'beauty', categoryName: 'Beauty & Salon', basePrice: 399, discountPrice: 299, duration: 60, rating: 4.5, reviewCount: 156, bookingCount: 156, isActive: true, imageUrl: '' },
  { id: 'svc_beauty_2', name: 'Facial & Cleanup', description: 'Relaxing facial treatment with cleanup, toning and moisturizing. Use premium products.', categoryId: 'beauty', categoryName: 'Beauty & Salon', basePrice: 599, discountPrice: 449, duration: 90, rating: 4.6, reviewCount: 92, bookingCount: 92, isActive: true, imageUrl: '' },
  { id: 'svc_beauty_3', name: 'Manicure & Pedicure', description: 'Complete hand and foot care treatment including scrub, massage, and nail polish.', categoryId: 'beauty', categoryName: 'Beauty & Salon', basePrice: 499, discountPrice: 399, duration: 75, rating: 4.7, reviewCount: 118, bookingCount: 118, isActive: true, imageUrl: '' },
];

const banners = [
  { id: 'banner_1', title: 'Book Home Services Instantly', subtitle: 'Trusted professionals at your doorstep', imageUrl: '', actionType: 'none', actionValue: '', isActive: true, sortOrder: 1 },
  { id: 'banner_2', title: 'Get ₹50 Off Your First Booking', subtitle: 'Use code FIRST50 at checkout', imageUrl: '', actionType: 'none', actionValue: '', isActive: true, sortOrder: 2 },
  { id: 'banner_3', title: 'Verified & Trained Professionals', subtitle: 'All providers are background checked', imageUrl: '', actionType: 'none', actionValue: '', isActive: true, sortOrder: 3 },
];

const coupons = [
  { code: 'FIRST50', discount: 50, type: 'flat', minOrder: 200, maxDiscount: 50, usageLimit: 1000, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '₹50 off on your first booking' },
  { code: 'SAVE20', discount: 20, type: 'percentage', minOrder: 300, maxDiscount: 100, usageLimit: 500, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '20% off up to ₹100' },
  { code: 'WELCOME100', discount: 100, type: 'flat', minOrder: 500, maxDiscount: 100, usageLimit: 100, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '₹100 off for new users' },
  { code: 'CLEAN30', discount: 30, type: 'percentage', minOrder: 400, maxDiscount: 150, usageLimit: 200, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '30% off on cleaning services' },
];

const appConfig = {
  commissionRate: 20,
  referralBonus: 50,
  minimumWithdrawal: 500,
  currency: 'INR',
  currencySymbol: '₹',
  minimumAppVersion: '1.0.0',
  maintenanceMode: false,
  defaultRadiusKm: 20,
  maxRadiusKm: 50,
  serviceCities: ['Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Chennai', 'Pune', 'Kolkata', 'Jaipur'],
  supportEmail: 'support@servenow.com',
  supportPhone: '+91-0000000000',
};

async function seedData() {
  try {
    console.log('Seeding categories...');
    for (const cat of categories) {
      const { id, ...data } = cat;
      await db.collection('categories').doc(id).set(data);
    }
    console.log(`Successfully seeded ${categories.length} categories.`);

    console.log('Seeding services...');
    for (const svc of services) {
      const { id, ...data } = svc;
      await db.collection('services').doc(id).set(data);
    }
    console.log(`Successfully seeded ${services.length} services.`);

    console.log('Seeding banners...');
    for (const banner of banners) {
      const { id, ...data } = banner;
      await db.collection('banners').doc(id).set(data);
    }
    console.log(`Successfully seeded ${banners.length} banners.`);

    console.log('Seeding coupons...');
    for (const cp of coupons) {
      const { code, ...data } = cp;
      await db.collection('coupons').doc(code).set(data);
    }
    console.log(`Successfully seeded ${coupons.length} coupons.`);

    console.log('Seeding app configuration...');
    await db.collection('app_config').doc('settings').set(appConfig);
    console.log('Successfully seeded app configuration.');

    console.log('---------------------------------------------------------');
    console.log('Demo database seeding completed successfully!');
    console.log('---------------------------------------------------------');
    process.exit(0);
  } catch (error) {
    console.error('Error seeding data:', error);
    process.exit(1);
  }
}

seedData();
