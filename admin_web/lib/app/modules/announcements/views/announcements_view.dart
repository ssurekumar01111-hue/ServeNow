import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/announcements/controllers/announcements_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementsView extends GetView<AnnouncementsController> {
  const AnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Announcements',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 1, child: _buildSendForm()),
          const SizedBox(width: 24),
          Expanded(flex: 1, child: _buildHistoryTable()),
        ],
      ),
    );
  }

  Widget _buildSendForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Send Push Notification', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const Text('Target Audience', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Obx(() => DropdownButtonFormField<String>(
            value: controller.targetAudience.value,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'all', child: Text('All Users')),
              DropdownMenuItem(value: 'customers', child: Text('Customers Only')),
              DropdownMenuItem(value: 'providers', child: Text('Providers Only')),
              DropdownMenuItem(value: 'handymen', child: Text('Handymen Only')),
            ],
            onChanged: (val) => controller.targetAudience.value = val!,
          )),
          const SizedBox(height: 16),
          TextField(
            controller: controller.titleController,
            decoration: const InputDecoration(labelText: 'Title (max 50 chars)', border: OutlineInputBorder()),
            maxLength: 50,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.bodyController,
            decoration: const InputDecoration(labelText: 'Message (max 200 chars)', border: OutlineInputBorder()),
            maxLines: 4,
            maxLength: 200,
          ),
          const SizedBox(height: 24),
          _buildPreviewCard(),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Obx(() => ElevatedButton(
              onPressed: controller.isSending.value ? null : controller.sendAnnouncement,
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
              child: controller.isSending.value 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                  : const Text('Send Notification'),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Preview', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.notifications_active, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnimatedBuilder(
                  animation: Listenable.merge([controller.titleController, controller.bodyController]),
                  builder: (context, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.titleController.text.isEmpty ? 'Notification Title' : controller.titleController.text, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(controller.bodyController.text.isEmpty ? 'This is how your message will look on the user\'s device.' : controller.bodyController.text, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTable() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Announcement History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (controller.announcements.isEmpty) {
                return const Center(child: Text('No announcements found.', style: TextStyle(color: AppColors.textSecondary)));
              }
              return ListView.separated(
                itemCount: controller.announcements.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final ann = controller.announcements[index];
                  final date = ann['createdAt'] != null ? DateFormat('dd MMM yyyy, HH:mm').format((ann['createdAt'] as Timestamp).toDate()) : 'Unknown';
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(ann['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(ann['body'] ?? '', style: const TextStyle(fontSize: 13)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.backgroundDark.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                              child: Text((ann['target'] ?? '').toString().toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 8),
                            Text(date, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
