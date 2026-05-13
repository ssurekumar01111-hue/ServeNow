import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/features/services/presentation/providers/services_providers.dart';

class MyServicesScreen extends ConsumerWidget {
  const MyServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(providerServicesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Services')),
      body: servicesAsync.when(
        data: (services) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return Card(
              child: ListTile(
                title: Text(service.name),
                subtitle: Text('₹${service.basePrice}'),
                trailing: Switch(
                  value: service.isActive,
                  onChanged: (v) => ref.read(providerServicesProvider.notifier).toggleStatus(service.id, v),
                ),
                onTap: () => context.push('/services/edit/${service.id}'),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/services/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
