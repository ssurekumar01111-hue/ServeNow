import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/features/handymen/presentation/providers/handymen_providers.dart';
import 'package:provider/features/handymen/domain/entities/handyman_entity.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';

class AddHandymanScreen extends ConsumerStatefulWidget {
  const AddHandymanScreen({super.key});

  @override
  ConsumerState<AddHandymanScreen> createState() => _AddHandymanScreenState();
}

class _AddHandymanScreenState extends ConsumerState<AddHandymanScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Handyman')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone'), keyboardType: TextInputType.phone),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final user = ref.read(authNotifierProvider).value!;
                final handyman = HandymanEntity(
                  id: '',
                  providerId: user.uid,
                  name: _nameController.text,
                  phone: _phoneController.text,
                  skills: [],
                  photoUrl: '',
                  idProofUrl: '',
                );
                ref.read(myHandymenProvider.notifier).addHandyman(handyman);
                Navigator.pop(context);
              },
              child: const Text('Add Handyman'),
            ),
          ],
        ),
      ),
    );
  }
}
