import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/features/services/presentation/providers/services_providers.dart';
import 'package:provider/features/services/domain/entities/service_entity.dart';

class AddServiceScreen extends ConsumerStatefulWidget {
  const AddServiceScreen({this.serviceId, super.key});
  final String? serviceId;

  @override
  ConsumerState<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends ConsumerState<AddServiceScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.serviceId == null ? 'Add Service' : 'Edit Service')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Service Name')),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 3),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Base Price'), keyboardType: TextInputType.number),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final service = ServiceEntity(
                  id: widget.serviceId ?? '',
                  name: _nameController.text,
                  description: _descController.text,
                  basePrice: double.parse(_priceController.text),
                  categoryId: 'cleaning',
                  isActive: true,
                  workingHours: {},
                  estimatedDuration: 60,
                );
                ref.read(providerServicesProvider.notifier).addService(service);
                Navigator.pop(context);
              },
              child: const Text('Save Service'),
            ),
          ],
        ),
      ),
    );
  }
}
