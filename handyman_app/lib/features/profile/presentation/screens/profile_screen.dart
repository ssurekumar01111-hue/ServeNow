import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:handyman/core/router/app_routes.dart';
import 'package:handyman/core/theme/app_colors.dart';
import 'package:handyman/features/auth/presentation/providers/auth_provider.dart';
import 'package:handyman/features/profile/domain/entities/handyman_profile_entity.dart';
import 'package:handyman/features/profile/presentation/providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(handymanProfileProvider);

    // Redirect if profile is empty
    profileAsync.whenData((p) {
      if (p != null && p.name.isEmpty) {
        Future.microtask(() {
          if (context.mounted) context.go(AppRoutes.signUp);
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, profileAsync),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(child: _buildInfoCard(profileAsync)),
                  const SizedBox(height: 24),
                  FadeInUp(delay: const Duration(milliseconds: 100), child: _buildSkillsCard(profileAsync)),
                  const SizedBox(height: 24),
                  
                  const Text('Recent Reviews', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                  const SizedBox(height: 16),
                  profileAsync.when(
                    data: (p) => p != null ? _buildReviewsList(p.id) : const SizedBox.shrink(),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const Text('Error loading reviews'),
                  ),
                  
                  const SizedBox(height: 24),
                  FadeInUp(delay: const Duration(milliseconds: 200), child: _buildMenuCard(context, ref)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, AsyncValue<HandymanProfileEntity?> profileAsync) {
    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.primaryGradient,
            ),
          ),
          child: profileAsync.when(
            data: (p) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: p?.photoUrl != null ? NetworkImage(p!.photoUrl) : null,
                        child: p?.photoUrl == null ? const Icon(Icons.person, size: 50, color: Colors.grey) : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  p?.name ?? 'Partner',
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${p?.rating.toStringAsFixed(1) ?? "0.0"} (${p?.totalRatings ?? 0} ratings)',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
            error: (e, st) => const Center(child: Icon(Icons.error, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(AsyncValue<HandymanProfileEntity?> profileAsync) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: profileAsync.when(
          data: (p) => Column(
            children: [
              _buildInfoRow(Icons.email_outlined, 'Email', p?.email != null && p!.email.isNotEmpty ? p.email : 'partner@servenow.com'),
              const Divider(height: 32),
              _buildInfoRow(Icons.phone_outlined, 'Phone', p?.phone ?? ''),
              const Divider(height: 32),
              _buildInfoRow(Icons.location_on_outlined, 'Service Area', p?.serviceArea ?? 'Not specified'),
              const Divider(height: 32),
              _buildInfoRow(Icons.percent, 'Commission Rate', '${p?.commissionRate ?? 0}%'),
              const Divider(height: 32),
              _buildInfoRow(Icons.verified_user_outlined, 'Status', 'Verified Partner', color: AppColors.success),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Text('Error loading info'),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? color}) {
    return Row(
      children: [
        Icon(icon, color: color ?? AppColors.primary, size: 22),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Poppins')),
            Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Poppins')),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillsCard(AsyncValue<HandymanProfileEntity?> profileAsync) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Professional Skills', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
            const SizedBox(height: 16),
            profileAsync.when(
              data: (p) {
                if (p == null || p.skills.isEmpty) {
                  return const Text('No skills added', style: TextStyle(color: Colors.grey));
                }
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: p.skills
                      .map((skill) => Chip(
                            label: Text(skill),
                            backgroundColor: AppColors.primary.withOpacity(0.1),
                            labelStyle: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold),
                            side: BorderSide.none,
                          ))
                      .toList(),
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('No skills added', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsList(String handymanId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('ratings')
          .where('handymanId', isEqualTo: handymanId)
          .where('isVisible', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const SizedBox.shrink();
        
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(20),
            child: Text('No reviews yet', style: TextStyle(color: Colors.grey)),
          ));
        }

        return Column(
          children: snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final createdAt = (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now();
            return Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Colors.grey.shade200)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data['customerName'] as String? ?? 'Customer', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${createdAt.day}/${createdAt.month}/${createdAt.year}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) => Icon(
                        index < (data['handymanRating'] as num? ?? 0) ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      )),
                    ),
                    if (data['review'] != null) ...[
                      const SizedBox(height: 8),
                      Text(data['review'] as String, style: const TextStyle(fontSize: 14)),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildMenuCard(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide(color: Colors.grey.shade200)),
      child: Column(
        children: [
          _buildMenuItem(Icons.settings_outlined, 'Settings', () => context.push(AppRoutes.settings)),
          const Divider(height: 1),
          _buildMenuItem(Icons.logout, 'Logout', () {
            ref.read(authNotifierProvider.notifier).signOut();
          }, color: AppColors.error),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primary),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500, fontFamily: 'Poppins')),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
