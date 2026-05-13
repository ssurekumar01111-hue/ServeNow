import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/support/controllers/support_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SupportView extends GetView<SupportController> {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Support Chats',
      child: Container(
        height: MediaQuery.of(context).size.height - 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            _buildChatList(),
            const VerticalDivider(width: 1),
            _buildChatViewer(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList() {
    return SizedBox(
      width: 320,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search chats...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.chats.isEmpty) {
                return const Center(child: Text('No chats found', style: TextStyle(color: AppColors.textSecondary)));
              }
              return ListView.separated(
                itemCount: controller.chats.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final chat = controller.chats[index];
                  final isSelected = controller.selectedChatId.value == chat['id'];
                  final time = chat['lastMessageAt'] != null ? DateFormat('HH:mm').format((chat['lastMessageAt'] as Timestamp).toDate()) : '';
                  
                  return ListTile(
                    selected: isSelected,
                    selectedTileColor: AppColors.primaryLight,
                    leading: CircleAvatar(
                      backgroundColor: AppColors.backgroundDark,
                      child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 18),
                    ),
                    title: Text('${chat['customerName']} & ${chat['handymanName']}', style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(chat['lastMessage'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                    trailing: Text(time, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                    onTap: () => controller.openChat(chat['id']),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildChatViewer() {
    return Expanded(
      child: Obx(() {
        if (controller.selectedChatId.value.isEmpty) {
          return const Center(child: Text('Select a chat to view messages', style: TextStyle(color: AppColors.textSecondary)));
        }

        final data = controller.selectedChatData;

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${data['customerName']} ↔ ${data['handymanName']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Booking ID: ${data['bookingId'] ?? 'N/A'}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.receipt_long, size: 16),
                    label: const Text('View Booking'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColors.background,
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: controller.selectedChatMessages.length,
                  itemBuilder: (context, index) {
                    final msg = controller.selectedChatMessages[index];
                    final isCustomer = msg['senderId'] == data['customerId'];
                    final time = msg['sentAt'] != null ? DateFormat('HH:mm').format((msg['sentAt'] as Timestamp).toDate()) : '';

                    return Align(
                      alignment: isCustomer ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        constraints: const BoxConstraints(maxWidth: 400),
                        decoration: BoxDecoration(
                          color: isCustomer ? AppColors.primaryLight : Colors.white,
                          border: isCustomer ? null : Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: Radius.circular(isCustomer ? 12 : 0),
                            bottomRight: Radius.circular(isCustomer ? 0 : 12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(isCustomer ? (data['customerName'] ?? 'Customer') : (data['handymanName'] ?? 'Provider'), style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isCustomer ? AppColors.primary : AppColors.textSecondary)),
                            const SizedBox(height: 4),
                            Text(msg['text'] ?? ''),
                            const SizedBox(height: 4),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(time, style: const TextStyle(fontSize: 10, color: AppColors.textHint)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border))),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 16, color: AppColors.textSecondary),
                  SizedBox(width: 8),
                  Text('Admin view is read-only. You cannot send messages in this chat.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
