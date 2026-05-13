import 'package:customer/features/booking/presentation/providers/booking_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CouponScreen extends ConsumerWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coupons = ref.watch(availableCouponsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Coupons')),
      body: coupons.when(
        data: (items) {
          final validCoupons = items.where((c) => c.expiresAt.isAfter(DateTime.now())).toList();
          
          if (validCoupons.isEmpty) {
            return const Center(
              child: Text('No coupons available', style: TextStyle(color: Colors.grey)),
            );
          }

          return ListView.builder(
            itemCount: validCoupons.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final coupon = validCoupons[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(coupon.code, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '${coupon.type == 'flat' ? '₹' : ''}${coupon.discount.toInt()}${coupon.type == 'flat' ? ' OFF' : '% OFF'} - Min order ₹${coupon.minOrder.toInt()}',
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      ref.read(createBookingProvider.notifier).applyCoupon(coupon);
                      context.pop();
                    },
                    child: const Text('Apply'),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => const Center(
          child: Text('Could not load coupons', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
    );
  }
}
