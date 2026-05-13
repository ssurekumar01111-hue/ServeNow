import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/core/widgets/shimmer_loader.dart';
import 'package:provider/features/handymen/presentation/providers/handymen_providers.dart';

class MyHandymenScreen extends ConsumerWidget {
  const MyHandymenScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handymenAsync = ref.watch(myHandymenProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Handymen')),
      body: handymenAsync.when(
        data: (handymen) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: handymen.length,
          itemBuilder: (context, index) {
            final h = handymen[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(h.photoUrl)),
                title: Text(h.name),
                subtitle: Text(h.skills.join(', ')),
                trailing: Icon(
                  Icons.circle,
                  color: h.isOnline ? Colors.green : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  size: 12,
                ),
              ),
            );
          },
        ),
        loading: () => const ShimmerLoader(),
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Something went wrong: $e', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(myHandymenProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/handymen/add'),
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
