import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/router/app_routes.dart';
import 'package:customer/core/theme/app_colors.dart';
import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SavedAddressesScreen extends ConsumerWidget {
  const SavedAddressesScreen({super.key});

  Future<void> _deleteAddress(BuildContext context, String uid, String addressId, bool wasDefault) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      final addressRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(uid)
          .collection('addresses')
          .doc(addressId);
      
      batch.delete(addressRef);

      if (wasDefault) {
        batch.update(FirebaseFirestore.instance.collection('customers').doc(uid), {
          'defaultAddressId': null,
        });
      }

      await batch.commit();
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _setDefault(BuildContext context, String uid, String addressId) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      final addressesRef = FirebaseFirestore.instance
          .collection('customers')
          .doc(uid)
          .collection('addresses');

      // Unset old default
      final oldDefaults = await addressesRef.where('isDefault', isEqualTo: true).get();
      for (var doc in oldDefaults.docs) {
        batch.update(doc.reference, {'isDefault': false});
      }

      // Set new default
      batch.update(addressesRef.doc(addressId), {'isDefault': true});
      batch.update(FirebaseFirestore.instance.collection('customers').doc(uid), {
        'defaultAddressId': addressId,
      });

      await batch.commit();
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authNotifierProvider).value;
    if (user == null) return const Scaffold(body: Center(child: Text('Not logged in')));

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Addresses')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('customers')
            .doc(user.uid)
            .collection('addresses')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_off_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('No saved addresses yet', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.addAddress),
                    child: const Text('Add New Address'),
                  ),
                ],
              ),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final id = docs[index].id;
              final isDefault = data['isDefault'] as bool? ?? false;

              return Dismissible(
                key: Key(id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => _deleteAddress(context, user.uid, id, isDefault),
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isDefault ? AppColors.primary : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    onTap: () => _setDefault(context, user.uid, id),
                    leading: CircleAvatar(
                      backgroundColor: isDefault ? AppColors.primary : Colors.grey.shade100,
                      child: Icon(
                        _getIconForLabel(data['label'] as String?),
                        color: isDefault ? Colors.white : Colors.grey,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(data['label'] as String? ?? 'Home', style: const TextStyle(fontWeight: FontWeight.bold)),
                        if (isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'DEFAULT',
                              style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(data['fullAddress'] as String? ?? '', style: const TextStyle(color: Colors.black87)),
                        Text('${data['area'] as String? ?? ''}, ${data['city'] as String? ?? ''} - ${data['pincode'] as String? ?? ''}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.addAddress),
        label: const Text('Add Address'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  IconData _getIconForLabel(String? label) {
    switch (label?.toLowerCase()) {
      case 'home': return Icons.home_outlined;
      case 'work': return Icons.work_outline;
      default: return Icons.location_on_outlined;
    }
  }
}
