import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../app/models/provider_model.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../widgets/main_layout.dart';
import '../controllers/provider_approvals_controller.dart';

class ProviderApprovalsView extends StatelessWidget {
  const ProviderApprovalsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller directly here
    final controller = Get.put(
      ProviderApprovalsController(),
      tag: 'approvals',
    );

    return MainLayout(
      title: 'Provider Approvals',
      child: GetBuilder<ProviderApprovalsController>(
        tag: 'approvals',
        init: controller,
        builder: (ctrl) {
          // Show loading
          if (ctrl.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator());
          }

          // Debug info always visible
          final debugWidget = Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300)),
            child: Column(
              crossAxisAlignment:
                CrossAxisAlignment.start,
              children: [
                Text('Debug Info',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700)),
                const SizedBox(height: 4),
                Text('Total providers in DB: '
                  '${ctrl.allProviders.length}'),
                Text('Pending approval: '
                  '${ctrl.pendingProviders.length}'),
                const SizedBox(height: 8),
                ...ctrl.allProviders.map((p) =>
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 4),
                    child: Row(
                      children: [
                        Container(
                          padding:
                            const EdgeInsets
                              .symmetric(
                              horizontal: 8,
                              vertical: 2),
                          decoration: BoxDecoration(
                            color: p.onboardingStatus
                              == 'pending_approval'
                              ? Colors.orange
                                  .shade100
                              : Colors.green
                                  .shade100,
                            borderRadius:
                              BorderRadius
                                .circular(4)),
                          child: Text(
                            p.onboardingStatus,
                            style: TextStyle(
                              fontSize: 11,
                              color: p.onboardingStatus
                                == 'pending_approval'
                                ? Colors.orange
                                    .shade800
                                : Colors.green
                                    .shade800)),
                        ),
                        const SizedBox(width: 8),
                        Text(p.businessName,
                          style: const TextStyle(
                            fontWeight:
                              FontWeight.w500)),
                        const SizedBox(width: 8),
                        Text(
                          p.id.length > 8
                            ? p.id.substring(0, 8)
                            : p.id,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey
                              .shade500)),
                      ],
                    ),
                  )).toList(),
              ],
            ),
          );

          // No pending providers
          if (ctrl.pendingProviders.isEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  debugWidget,
                  const SizedBox(height: 40),
                  const Icon(Icons.check_circle_outline,
                    size: 64,
                    color: AppColors.success),
                  const SizedBox(height: 16),
                  const Text('No pending approvals',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary)),
                ],
              ),
            );
          }

          // Show pending providers
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment:
                CrossAxisAlignment.start,
              children: [
                debugWidget,
                const SizedBox(height: 16),
                Text(
                  '${ctrl.pendingProviders.length}'
                  ' Pending Approval',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
                const SizedBox(height: 16),
                ...ctrl.pendingProviders.map((p) =>
                  _ProviderCard(
                    provider: p,
                    onApprove: () =>
                      ctrl.approveProvider(p),
                    onReject: (reason) =>
                      ctrl.rejectProvider(p, reason),
                  )).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProviderCard extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback onApprove;
  final Function(String reason) onReject;

  const _ProviderCard({
    required this.provider,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
            CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                    AppColors.primaryLight,
                  child: Text(
                    provider.businessName.isNotEmpty
                      ? provider.businessName[0]
                          .toUpperCase()
                      : 'P',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                      CrossAxisAlignment.start,
                    children: [
                      Text(provider.businessName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight:
                            FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(provider.phone,
                        style: const TextStyle(
                          color: AppColors
                            .textSecondary)),
                      if (provider.serviceArea
                          .isNotEmpty)
                        Text(provider.serviceArea,
                          style: const TextStyle(
                            color: AppColors
                              .textHint,
                            fontSize: 12)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets
                    .symmetric(
                    horizontal: 12,
                    vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.warningLight,
                    borderRadius:
                      BorderRadius.circular(20)),
                  child: const Text('Pending',
                    style: TextStyle(
                      color: AppColors.warning,
                      fontSize: 12,
                      fontWeight:
                        FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            if (provider.description.isNotEmpty)
              Text(provider.description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13)),

            const Divider(height: 24),

            // Documents row
            Row(
              children: [
                const Icon(Icons.badge_outlined,
                  size: 16,
                  color: AppColors.textSecondary),
                const SizedBox(width: 6),
                const Text('Documents attached: ',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary)),
                if (provider.idProofUrl.isNotEmpty)
                  _DocChip('ID Proof',
                    provider.idProofUrl),
                if (provider.businessLicenseUrl
                    .isNotEmpty)
                  _DocChip('Business License',
                    provider.businessLicenseUrl),
              ],
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () =>
                      _showRejectDialog(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                        AppColors.error,
                      side: const BorderSide(
                        color: AppColors.error),
                      padding:
                        const EdgeInsets.symmetric(
                          vertical: 14)),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () =>
                      _showApproveDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                        AppColors.success,
                      padding:
                        const EdgeInsets.symmetric(
                          vertical: 14)),
                    child: const Text(
                      'Approve Provider',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                          FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showApproveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Approve Provider'),
        content: Text(
          'Approve "${provider.businessName}"?\n\n'
          'They will be notified and can start'
          ' accepting bookings immediately.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              onApprove();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success),
            child: const Text('Approve',
              style: TextStyle(
                color: Colors.white))),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reject Provider'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
            CrossAxisAlignment.start,
          children: [
            const Text(
              'Please provide a reason'
              ' (required):'),
            const SizedBox(height: 12),
            TextField(
              controller: ctrl,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText:
                  'e.g. Documents not clear,'
                  ' incomplete information...',
                border: OutlineInputBorder()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isEmpty) {
                EasyLoading.showError(
                  'Please enter a reason');
                return;
              }
              Navigator.pop(ctx);
              onReject(ctrl.text.trim());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error),
            child: const Text('Reject',
              style: TextStyle(
                color: Colors.white))),
        ],
      ),
    );
  }
}

class _DocChip extends StatelessWidget {
  final String label;
  final String url;
  const _DocChip(this.label, this.url);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label,
          style: const TextStyle(fontSize: 11)),
        avatar: const Icon(Icons.open_in_new,
          size: 14),
        onPressed: () {
          launchUrl(Uri.parse(url));
        },
      ),
    );
  }
}
