import 'package:customer/core/constants/booking_status.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/features/booking/presentation/providers/booking_form_state.dart';
import 'package:customer/features/booking/presentation/providers/booking_providers.dart';
import 'package:customer/features/services/domain/entities/service_entity.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/services/razorpay_service.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({
    this.bookingData,
    this.service,
    super.key,
  });

  final BookingFormState? bookingData;
  final ServiceEntity? service;

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  PaymentMethod _paymentMethod = PaymentMethod.cod;
  bool _isLoading = false;
  
  final TextEditingController _couponController = TextEditingController();
  String? _couponError;
  bool _isValidatingCoupon = false;

  final RazorpayService _razorpayService = RazorpayService();
  
  late ServiceEntity _currentService;
  late BookingFormState _currentBooking;
  late double _currentFinalAmount;
  late double _currentDiscount;

  @override
  void initState() {
    super.initState();
    if (widget.bookingData?.paymentMethod != null) {
      _paymentMethod = widget.bookingData!.paymentMethod;
    }
    _razorpayService.init(
      onSuccess: _handlePaymentSuccess,
      onFailure: _handlePaymentFailure,
      onWallet: (response) {},
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    _razorpayService.dispose();
    super.dispose();
  }

  Future<void> _validateCoupon(double serviceAmount) async {
    final code = _couponController.text.trim().toUpperCase();
    if (code.isEmpty) return;

    setState(() {
      _isValidatingCoupon = true;
      _couponError = null;
    });

    try {
      final snap = await FirebaseFirestore.instance
          .collection('coupons')
          .doc(code)
          .get();

      if (!snap.exists) {
        setState(() => _couponError = 'Invalid coupon code');
        return;
      }

      final data = snap.data()!;
      // Using mapping similar to CouponModel.fromFirestore
      final coupon = CouponEntity(
        code: code,
        discount: ((data['discountValue'] ?? data['discount'] ?? 0.0) as num).toDouble(),
        type: (data['discountType'] ?? data['type'] ?? 'flat').toString(),
        minOrder: ((data['minOrderAmount'] ?? data['minOrder'] ?? 0.0) as num).toDouble(),
        maxDiscount: data['maxDiscount'] != null ? (data['maxDiscount'] as num).toDouble() : null,
        expiresAt: (data['expiryDate'] as Timestamp? ?? data['expiresAt'] as Timestamp? ?? Timestamp.now()).toDate(),
        isActive: data['isActive'] as bool? ?? true,
      );

      if (!coupon.isActive!) {
        setState(() => _couponError = 'This coupon is no longer active');
        return;
      }

      if (DateTime.now().isAfter(coupon.expiresAt)) {
        setState(() => _couponError = 'This coupon has expired');
        return;
      }

      if (serviceAmount < coupon.minOrder) {
        setState(() => _couponError = 'Minimum order amount ₹${coupon.minOrder.toStringAsFixed(0)} required');
        return;
      }

      ref.read(createBookingProvider.notifier).applyCoupon(coupon);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Coupon "$code" applied!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() => _couponError = 'Error validating coupon');
    } finally {
      if (mounted) {
        setState(() => _isValidatingCoupon = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bookingData == null || widget.service == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: const Center(child: Text('Invalid booking data')),
      );
    }

    final user = ref.watch(authNotifierProvider).value;
    final booking = ref.watch(createBookingProvider);
    final service = widget.service!;
    
    final double serviceAmount = service.basePrice;
    double discount = 0.0;
    
    if (booking.appliedCoupon != null) {
      final coupon = booking.appliedCoupon!;
      if (coupon.type == 'percentage') {
        discount = serviceAmount * (coupon.discount / 100);
        if (coupon.maxDiscount != null && discount > coupon.maxDiscount!) {
          discount = coupon.maxDiscount!;
        }
      } else {
        discount = coupon.discount;
      }
      discount = discount.clamp(0, serviceAmount);
    }
    
    final double finalAmount = serviceAmount - discount;

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Service Summary'),
            _buildSummaryCard(booking.providerName ?? 'Provider', service.name, serviceAmount),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Schedule'),
            _buildInfoCard(Icons.calendar_today, '${booking.selectedDate != null ? DateFormat('dd MMM yyyy').format(booking.selectedDate!) : 'No date'} at ${booking.selectedTime != null ? DateFormat('HH:mm').format(booking.selectedTime!) : 'No time'}'),
            const SizedBox(height: 24),

            _buildSectionTitle('Address'),
            _buildInfoCard(Icons.location_on, booking.address?.fullAddress ?? 'No address selected'),
            const SizedBox(height: 24),

            _buildSectionTitle('Payment Method'),
            Row(
              children: [
                Expanded(child: _buildPaymentCard(PaymentMethod.cod, 'Cash on Delivery', Icons.payments)),
                const SizedBox(width: 12),
                Expanded(child: _buildPaymentCard(PaymentMethod.online, 'Pay Online', Icons.account_balance_wallet)),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Provider'),
            _buildProviderSummary(booking),
            const SizedBox(height: 24),

            _buildSectionTitle('Available Coupons'),
            _buildCouponSection(booking, serviceAmount),
            const SizedBox(height: 24),

            if (booking.notes != null && booking.notes!.isNotEmpty) ...[
              _buildSectionTitle('Notes'),
              _buildInfoCard(Icons.note_alt_outlined, booking.notes!),
              const SizedBox(height: 24),
            ],
            
            _buildTotalCard(serviceAmount, discount, finalAmount),
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _onPlaceBooking(service, booking, serviceAmount, discount, finalAmount),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white) 
                  : const Text('Place Booking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponSection(BookingFormState booking, double serviceAmount) {
    final couponsState = ref.watch(availableCouponsProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _couponController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                    hintText: 'Enter coupon code',
                    prefixIcon: const Icon(Icons.local_offer, color: AppColors.primary),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (_isValidatingCoupon)
                const SizedBox(width: 48, height: 48, child: Center(child: CircularProgressIndicator(strokeWidth: 2)))
              else if (booking.appliedCoupon != null)
                IconButton(
                  onPressed: () {
                    ref.read(createBookingProvider.notifier).applyCoupon(null as dynamic); // Reset coupon
                    _couponController.clear();
                    setState(() => _couponError = null);
                  },
                  icon: const Icon(Icons.close, color: Colors.red),
                )
              else
                ElevatedButton(
                  onPressed: () => _validateCoupon(serviceAmount),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: const Text('Apply', style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
          if (_couponError != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(_couponError!, style: const TextStyle(color: Colors.red, fontSize: 12)),
            ),
          const SizedBox(height: 16),
          const Text('Or select from available coupons:', style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          couponsState.when(
            data: (items) {
              final validCoupons = items.where((c) => c.expiresAt.isAfter(DateTime.now())).toList();
              if (validCoupons.isEmpty) {
                return const Text('No coupons available', style: TextStyle(color: Colors.grey, fontSize: 12));
              }
              return SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: validCoupons.length,
                  itemBuilder: (context, index) {
                    final coupon = validCoupons[index];
                    final isApplied = booking.appliedCoupon?.code == coupon.code;
                    return GestureDetector(
                      onTap: () {
                        if (serviceAmount >= coupon.minOrder) {
                          ref.read(createBookingProvider.notifier).applyCoupon(coupon);
                          _couponController.text = coupon.code;
                          setState(() => _couponError = null);
                        } else {
                          setState(() => _couponError = 'Min order ₹${coupon.minOrder.toInt()} required');
                        }
                      },
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isApplied ? AppColors.primary.withOpacity(0.1) : Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isApplied ? AppColors.primary : Colors.grey.shade300),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(coupon.code, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(
                              '${coupon.type == 'flat' ? '₹' : ''}${coupon.discount.toInt()}${coupon.type == 'flat' ? ' OFF' : '% OFF'}',
                              style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600),
                            ),
                            Text('Min ₹${coupon.minOrder.toInt()}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: LinearProgressIndicator()),
            error: (e, _) => const Text('Could not load coupons', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          if (booking.appliedCoupon != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Coupon "${booking.appliedCoupon!.code}" applied!',
                    style: const TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSummaryCard(String provider, String service, double price) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const CircleAvatar(child: Icon(Icons.handyman)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(provider, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            Text('₹$price', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String text) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(text),
      ),
    );
  }

  Widget _buildProviderSummary(BookingFormState booking) {
    if (booking.providerId == null || booking.providerId!.isEmpty) {
      return const Card(
        child: ListTile(
          leading: CircleAvatar(child: Icon(Icons.person_search)),
          title: Text('Any available provider'),
          subtitle: Text('We will assign the best match for your service'),
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('providers').doc(booking.providerId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: LinearProgressIndicator());
        }
        
        final data = snapshot.data?.data() as Map<String, dynamic>?;
        if (data == null) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(booking.providerName ?? 'Selected Provider'),
            ),
          );
        }

        final photoUrl = data['photoUrl'] as String? ?? '';
        final businessName = data['businessName'] as String? ?? 'Business Name';
        final serviceArea = data['serviceArea'] as String? ?? 'Service area not specified';

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                  child: photoUrl.isEmpty ? const Icon(Icons.person) : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(businessName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              serviceArea,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentCard(PaymentMethod method, String label, IconData icon) {
    final isSelected = _paymentMethod == method;
    return InkWell(
      onTap: () => setState(() => _paymentMethod = method),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.black87,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (method == PaymentMethod.online) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D81F7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'razorpay',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 9),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTotalCard(double original, double discount, double total) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (discount > 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Service Amount', style: TextStyle(fontSize: 14)),
                  Text('₹$original', style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Coupon Discount', style: TextStyle(fontSize: 14, color: Colors.green)),
                  Text('-₹${discount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 14, color: Colors.green)),
                ],
              ),
              const Divider(height: 24),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Amount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('₹${total.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentSuccess(dynamic response) async {
    // Stubbed for Codester release
  }

  void _handlePaymentFailure(dynamic response) {
    // Stubbed for Codester release
  }

  Future<void> _initiateRazorpayPayment(ServiceEntity service, BookingFormState booking, double finalAmount) async {
    setState(() => _isLoading = false);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF2D81F7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'razorpay',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(child: Text('Setup Required', style: TextStyle(fontSize: 18))),
          ],
        ),
        content: const Text(
          'Online payment is not configured yet.\n\n'
          'To enable Razorpay:\n'
          '1. Create account at razorpay.com\n'
          '2. Get your Key ID & Key Secret\n'
          '3. Add keys to functions/index.js\n'
          '4. Update Key ID in razorpay_service.dart\n\n'
          'See the Firebase Setup Guide included in the package.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _createBookingInFirestore(
    ServiceEntity service, 
    BookingFormState booking, 
    double finalAmount, 
    double discount,
    {
      required PaymentMethod paymentMethod,
      required PaymentStatus paymentStatus,
      String? razorpayOrderId,
      String? razorpayPaymentId,
    }
  ) async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    String categoryName = '';
    String categoryId = service.categoryId;

    // Try service.categoryName first
    if (service.categoryName != null && service.categoryName!.isNotEmpty) {
      categoryName = service.categoryName!;
    }

    // If categoryName is still empty or we want to ensure we have the latest from Firestore
    if (categoryId.isNotEmpty) {
      try {
        final categoryDoc = await FirebaseFirestore.instance
            .collection('categories')
            .doc(categoryId)
            .get();
        if (categoryDoc.exists) {
          categoryName = categoryDoc.data()?['name'] as String? ?? categoryName;
        } else {
          // Doc not found by ID — try querying by name field (in case categoryId is actually a name)
          final categoryQuery = await FirebaseFirestore.instance
              .collection('categories')
              .where('name', isEqualTo: categoryId)
              .limit(1)
              .get();
          if (categoryQuery.docs.isNotEmpty) {
            categoryName = categoryQuery.docs.first.data()['name'] as String? ?? categoryName;
            categoryId = categoryQuery.docs.first.id; // fix the ID too
          }
        }
      } catch (e) {
        debugPrint('Category fetch failed: $e');
      }
    }

    // Get effective provider info
    String providerId = booking.providerId ?? "";
    String providerName = booking.providerName ?? 'Any available provider';

    if (providerId.isNotEmpty) {
      final providerDoc = await FirebaseFirestore.instance.collection('providers').doc(providerId).get();
      if (providerDoc.exists) {
        providerName = providerDoc.data()?['businessName'] as String? ?? providerName;
      }
    }

    final scheduledTimeStr = booking.selectedTime != null ? DateFormat('HH:mm').format(booking.selectedTime!) : '00:00';

    final commissionRate = 10.0;
    final commission = finalAmount * commissionRate / 100;
    final providerEarning = finalAmount - commission;

    final bookingEntity = BookingEntity(
      id: '',
      customerId: user.uid,
      customerName: user.fullName ?? 'Customer',
      customerPhone: user.phone ?? '',
      customerAddress: booking.address?.fullAddress ?? '',
      customerArea: booking.address?.area ?? '',
      providerId: providerId,
      providerName: providerName,
      serviceId: service.id,
      serviceName: service.name,
      serviceCategory: categoryName,
      serviceCategoryId: categoryId,
      scheduledDate: booking.selectedDate ?? DateTime.now(),
      scheduledTime: scheduledTimeStr,
      status: BookingStatuses.pending,
      otp: (1000 + (DateTime.now().millisecond % 9000)).toString(),
      amount: finalAmount,
      commission: commission,
      providerEarning: providerEarning,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      razorpayOrderId: razorpayOrderId,
      razorpayPaymentId: razorpayPaymentId,
      notes: booking.notes,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      discountAmount: discount,
      couponCode: booking.appliedCoupon?.code,
      customerLat: booking.address?.lat,
      customerLng: booking.address?.lng,
    );

    await ref.read(bookingRepositoryProvider).createBooking(bookingEntity);
  }

  void _onPlaceBooking(ServiceEntity service, BookingFormState booking, double originalAmount, double discount, double finalAmount) async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    setState(() => _isLoading = true);
    
    _currentService = service;
    _currentBooking = booking;
    _currentFinalAmount = finalAmount;
    _currentDiscount = discount;

    if (_paymentMethod == PaymentMethod.online) {
      await _initiateRazorpayPayment(service, booking, finalAmount);
    } else {
      try {
        await _createBookingInFirestore(
          service, 
          booking, 
          finalAmount, 
          discount,
          paymentMethod: PaymentMethod.cod,
          paymentStatus: PaymentStatus.pending,
        );
        if (mounted) {
          context.go(AppRoutes.bookingConfirmation);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }
}
