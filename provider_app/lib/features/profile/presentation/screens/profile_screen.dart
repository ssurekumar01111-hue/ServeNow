import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/core/router/app_routes.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/profile/presentation/providers/profile_providers.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authNotifierProvider).value;
    if (user != null) {
      _nameController.text = user.name ?? '';
      _emailController.text = user.email ?? '';
    }
  }

  Future<void> _pickAndUploadImage() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    
    if (image != null) {
      setState(() => _isLoading = true);
      try {
        final refStorage = FirebaseStorage.instance.ref().child('users/${user.uid}/profile/photo.jpg');
        await refStorage.putFile(File(image.path));
        final url = await refStorage.getDownloadURL();
        
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'photoUrl': url});
        ref.invalidate(authNotifierProvider);
        
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile photo updated')));
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating photo: $e')));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    final user = ref.read(authNotifierProvider).value;
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
      });
      ref.invalidate(authNotifierProvider);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved successfully')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving profile: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(authNotifierProvider);
    final profileAsync = ref.watch(providerProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) return const Center(child: Text('Not logged in'));
          final profile = profileAsync.value;
          final rating = profile?.rating ?? 0.0;
          final totalRatings = profile?.totalRatings ?? 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickAndUploadImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
                              child: user.photoUrl == null ? const Icon(Icons.person, size: 50) : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 24),
                          const SizedBox(width: 4),
                          Text(
                            rating.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' ($totalRatings ratings)',
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Account Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Business Name', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                TextField(
                  enabled: false,
                  controller: TextEditingController(text: user.phone),
                  decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                  child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save Changes'),
                ),
                
                const SizedBox(height: 40),
                const Text('Recent Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildReviewsList(user.uid),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildReviewsList(String providerId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ratings')
          .where('providerId', isEqualTo: providerId)
          .where('isVisible', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: Text('No reviews yet', style: TextStyle(color: Colors.grey))),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
            final createdAt = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
            
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((data['customerName'] as String?) ?? 'Customer', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${createdAt.day}/${createdAt.month}/${createdAt.year}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (starIndex) => Icon(
                        starIndex < ((data['providerRating'] as num?) ?? 0).toDouble() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      )),
                    ),
                    if (data['review'] != null && data['review'].toString().isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(data['review'] as String, style: const TextStyle(fontSize: 14)),
                    ],
                    if (data['images'] != null && (data['images'] as List).isNotEmpty) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (data['images'] as List).length,
                          itemBuilder: (context, imgIndex) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                (data['images'] as List)[imgIndex] as String,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
