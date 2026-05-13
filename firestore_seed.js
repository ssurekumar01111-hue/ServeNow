const admin = require('firebase-admin');
const serviceAccount = require('./admin_panel/firebase-service-account.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

const categories = [
  { name: 'Cleaning', iconName: 'cleaning_services', color: '#4CAF50', isActive: true },
  { name: 'AC Repair', iconName: 'ac_unit', color: '#2196F3', isActive: true },
  { name: 'Plumbing', iconName: 'plumbing', color: '#FF9800', isActive: true },
  { name: 'Electrical', iconName: 'electrical_services', color: '#F44336', isActive: true },
  { name: 'Beauty & Salon', iconName: 'content_cut', color: '#E91E63', isActive: true }
];

const services = [
  // Cleaning
  { name: 'Full House Cleaning', description: 'Deep cleaning of the entire house.', basePrice: 2000, duration: 240, categoryName: 'Cleaning', imageUrl: 'https://placeholder.com/cleaning1', isActive: true },
  { name: 'Kitchen Cleaning', description: 'Deep cleaning of kitchen and appliances.', basePrice: 800, duration: 120, categoryName: 'Cleaning', imageUrl: 'https://placeholder.com/cleaning2', isActive: true },
  { name: 'Bathroom Cleaning', description: 'Sanitization and cleaning of bathrooms.', basePrice: 500, duration: 60, categoryName: 'Cleaning', imageUrl: 'https://placeholder.com/cleaning3', isActive: true },
  // AC Repair
  { name: 'AC Service', description: 'Standard AC filter cleaning and checkup.', basePrice: 500, duration: 45, categoryName: 'AC Repair', imageUrl: 'https://placeholder.com/ac1', isActive: true },
  { name: 'Gas Charging', description: 'Refilling AC refrigerant gas.', basePrice: 2500, duration: 90, categoryName: 'AC Repair', imageUrl: 'https://placeholder.com/ac2', isActive: true },
  { name: 'Installation', description: 'New AC unit installation.', basePrice: 1500, duration: 120, categoryName: 'AC Repair', imageUrl: 'https://placeholder.com/ac3', isActive: true },
  // Plumbing
  { name: 'Tap Repair', description: 'Fixing leaking taps and faucets.', basePrice: 200, duration: 30, categoryName: 'Plumbing', imageUrl: 'https://placeholder.com/plumbing1', isActive: true },
  { name: 'Drainage Unblocking', description: 'Clearing clogged pipes and drains.', basePrice: 600, duration: 60, categoryName: 'Plumbing', imageUrl: 'https://placeholder.com/plumbing2', isActive: true },
  { name: 'Water Tank Cleaning', description: 'Deep cleaning of overhead water tanks.', basePrice: 1200, duration: 180, categoryName: 'Plumbing', imageUrl: 'https://placeholder.com/plumbing3', isActive: true },
  // Electrical
  { name: 'Fan Repair', description: 'Repairing or installing ceiling fans.', basePrice: 300, duration: 45, categoryName: 'Electrical', imageUrl: 'https://placeholder.com/elec1', isActive: true },
  { name: 'Switchboard Fixing', description: 'Installing or repairing electrical switches.', basePrice: 150, duration: 30, categoryName: 'Electrical', imageUrl: 'https://placeholder.com/elec2', isActive: true },
  { name: 'Short Circuit Fix', description: 'Troubleshooting and fixing short circuits.', basePrice: 800, duration: 90, categoryName: 'Electrical', imageUrl: 'https://placeholder.com/elec3', isActive: true },
  // Beauty & Salon
  { name: 'Haircut', description: 'Professional haircut and styling.', basePrice: 400, duration: 45, categoryName: 'Beauty & Salon', imageUrl: 'https://placeholder.com/beauty1', isActive: true },
  { name: 'Facial', description: 'Skin rejuvenation and cleansing facial.', basePrice: 1200, duration: 60, categoryName: 'Beauty & Salon', imageUrl: 'https://placeholder.com/beauty2', isActive: true },
  { name: 'Manicure & Pedicure', description: 'Complete hand and nail care.', basePrice: 1000, duration: 90, categoryName: 'Beauty & Salon', imageUrl: 'https://placeholder.com/beauty3', isActive: true }
];

async function seed() {
  console.log('Starting seed...');

  // Seed App Config
  await db.collection('app_config').doc('settings').set({
    commissionRate: 20,
    referralBonus: 50,
    minimumWithdrawal: 500,
    currency: 'INR'
  });
  console.log('App config seeded.');

  // Seed Categories
  const categoryIdMap = {
    'Cleaning': 'cleaning',
    'AC Repair': 'ac_repair',
    'Plumbing': 'plumbing',
    'Electrical': 'electrical',
    'Beauty & Salon': 'beauty'
  };

  for (const cat of categories) {
    const id = categoryIdMap[cat.name];
    await db.collection('categories').doc(id).set(cat);
    console.log(`Category ${cat.name} seeded with ID: ${id}`);
  }

  // Seed demo provider
  await db.collection('providers').doc('demo_provider').set({
    uid: 'demo_provider',
    businessName: 'ServeNow Demo Services',
    isApproved: true,
    isActive: true,
    rating: 4.5,
    reviewCount: 100,
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });
  console.log('Demo provider seeded.');

  // Seed services
  for (const service of services) {
    const categoryId = categoryIdMap[service.categoryName];
    const { categoryName, ...serviceData } = service;
    await db.collection('services').add({
      ...serviceData,
      categoryId,
      providerId: 'demo_provider',
      rating: 4.5,
      reviewCount: 10,
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });
    console.log(`Service ${service.name} seeded.`);
  }

  // Seed coupons
  const coupons = [
    { code: 'FIRST50', discount: 50, type: 'flat', minOrder: 200, maxDiscount: 50, usageLimit: 1000, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '₹50 off on your first booking' },
    { code: 'SAVE20', discount: 20, type: 'percentage', minOrder: 300, maxDiscount: 100, usageLimit: 500, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '20% off up to ₹100' },
    { code: 'WELCOME100', discount: 100, type: 'flat', minOrder: 500, maxDiscount: 100, usageLimit: 100, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '₹100 off for new users' },
    { code: 'CLEAN30', discount: 30, type: 'percentage', minOrder: 400, maxDiscount: 150, usageLimit: 200, usageCount: 0, isActive: true, expiresAt: admin.firestore.Timestamp.fromDate(new Date('2027-12-31')), description: '30% off on cleaning services' },
  ];
  for (const coupon of coupons) {
    await db.collection('coupons').doc(coupon.code).set(coupon);
    console.log(`Coupon ${coupon.code} seeded`);
  }

  console.log('Seed completed successfully!');
  process.exit(0);
  }

seed().catch(err => {
  console.error('Seed failed:', err);
  process.exit(1);
});
