import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web/app/modules/ratings/controllers/ratings_controller.dart';
import 'package:admin_web/widgets/main_layout.dart';
import 'package:admin_web/widgets/data_table_widget.dart';
import 'package:admin_web/widgets/detail_modal_widget.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/models/rating_model.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RatingsView extends GetView<RatingsController> {
  const RatingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Reviews & Ratings',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterRow(),
          const SizedBox(height: 24),
          Obx(() => DataTableWidget(
            isLoading: controller.isLoading.value,
            columns: const [
              DataColumn(label: Text('Customer')),
              DataColumn(label: Text('Provider Rating')),
              DataColumn(label: Text('Handyman Rating')),
              DataColumn(label: Text('Review')),
              DataColumn(label: Text('Photos')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Visible')),
              DataColumn(label: Text('Actions')),
            ],
            rows: controller.filteredRatings.map((r) => _buildRow(context, r)).toList(),
          )),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      children: [
        const Text('Filter by Score:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        Obx(() => DropdownButton<String>(
          value: controller.ratingFilter.value,
          items: const [
            DropdownMenuItem(value: 'all', child: Text('All Ratings')),
            DropdownMenuItem(value: '5', child: Text('5 Stars')),
            DropdownMenuItem(value: '4', child: Text('4 Stars')),
            DropdownMenuItem(value: '3', child: Text('3 Stars')),
            DropdownMenuItem(value: '2', child: Text('2 Stars')),
            DropdownMenuItem(value: '1', child: Text('1 Star')),
          ],
          onChanged: (val) => controller.setFilter(val!),
        )),
      ],
    );
  }

  DataRow _buildRow(BuildContext context, RatingModel rating) {
    return DataRow(cells: [
      DataCell(Text(rating.customerName ?? '', style: const TextStyle(fontWeight: FontWeight.bold))),
      DataCell(Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text((rating.providerRating ?? 0.0).toStringAsFixed(1)),
        ],
      )),
      DataCell(Row(
        children: [
          const Icon(Icons.star, color: Colors.amber, size: 16),
          const SizedBox(width: 4),
          Text((rating.handymanRating ?? 0.0).toStringAsFixed(1)),
        ],
      )),
      DataCell(
        SizedBox(
          width: 200,
          child: Text(rating.review ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ),
      DataCell(Text((rating.images ?? []).length.toString())),
      DataCell(Text(DateFormat('dd MMM yyyy').format((rating.createdAt ?? Timestamp.now()).toDate()))),
      DataCell(
        Switch(
          value: rating.isVisible ?? false,
          onChanged: (val) => controller.toggleVisibility(rating.id ?? '', val),
          activeColor: AppColors.success,
        ),
      ),
      DataCell(
        IconButton(
          icon: const Icon(Icons.visibility_outlined, color: AppColors.primary),
          onPressed: () => _showReviewDetail(context, rating),
        ),
      ),
    ]);
  }

  void _showReviewDetail(BuildContext context, RatingModel rating) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.centerRight,
          child: DetailModalWidget(
            title: 'Review Details',
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Booking ID: ${rating.bookingId ?? ''}', style: const TextStyle(color: AppColors.textSecondary, fontFamily: 'monospace')),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  _buildRatingSection('Customer', rating.customerName ?? '', 0, false),
                  const SizedBox(height: 16),
                  _buildRatingSection('Provider Rating', 'Provider ID: ${rating.providerId ?? ''}', rating.providerRating ?? 0.0, true),
                  const SizedBox(height: 16),
                  if ((rating.handymanId ?? '').isNotEmpty)
                    _buildRatingSection('Handyman Rating', 'Handyman ID: ${rating.handymanId ?? ''}', rating.handymanRating ?? 0.0, true),
                  const SizedBox(height: 24),
                  const Text('Review Content', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(8)),
                    child: Text(rating.review ?? '', style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(height: 24),
                  if ((rating.images ?? []).isNotEmpty) ...[
                    const Text('Photos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (rating.images ?? []).map((url) => 
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(imageUrl: url, width: 80, height: 80, fit: BoxFit.cover),
                        )
                      ).toList(),
                    ),
                  ]
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
            ],
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(anim1), child: child);
      },
    );
  }

  Widget _buildRatingSection(String title, String subtitle, double rating, bool showStars) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
        if (showStars)
          Row(
            children: [
              Text(rating.toStringAsFixed(1), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              const Icon(Icons.star, color: Colors.amber, size: 24),
            ],
          ),
      ],
    );
  }
}
