import 'dart:io';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/features/reviews/domain/review_entity.dart';
import 'package:customer/features/reviews/presentation/review_providers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RateServiceBottomSheet extends ConsumerStatefulWidget {
  final BookingEntity booking;

  const RateServiceBottomSheet({super.key, required this.booking});

  static Future<void> show(BuildContext context, BookingEntity booking) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => RateServiceBottomSheet(booking: booking),
    );
  }

  @override
  ConsumerState<RateServiceBottomSheet> createState() => _RateServiceBottomSheetState();
}

class _RateServiceBottomSheetState extends ConsumerState<RateServiceBottomSheet> {
  double _providerRating = 0;
  double _handymanRating = 0;
  final _commentController = TextEditingController();
  final List<File> _images = [];
  bool _isSubmitting = false;

  Future<void> _pickImage() async {
    if (_images.length >= 3) return;
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      setState(() => _images.add(File(image.path)));
    }
  }

  Future<List<String>> _uploadImages() async {
    final storage = FirebaseStorage.instance;
    final List<String> urls = [];
    for (var i = 0; i < _images.length; i++) {
      final ref = storage.ref().child('ratings/${widget.booking.id}/photo_$i.jpg');
      await ref.putFile(_images[i]);
      urls.add(await ref.getDownloadURL());
    }
    return urls;
  }

  Future<void> _submit() async {
    if (_providerRating == 0 || _handymanRating == 0) return;

    setState(() => _isSubmitting = true);
    try {
      final user = ref.read(authNotifierProvider).value!;
      final photoUrls = await _uploadImages();

      final review = ReviewEntity(
        id: '',
        bookingId: widget.booking.id,
        customerId: user.uid,
        customerName: user.fullName ?? 'Customer',
        providerId: widget.booking.providerId,
        handymanId: widget.booking.assignedHandymanId,
        providerRating: _providerRating,
        handymanRating: _handymanRating,
        comment: _commentController.text,
        photos: photoUrls,
        createdAt: DateTime.now(),
      );

      await ref.read(reviewNotifierProvider.notifier).createReview(review);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you for your feedback!')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'How was your experience?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          // Provider Rating
          Text('Rate ${widget.booking.providerName}', style: const TextStyle(fontWeight: FontWeight.w600)),
          _StarSelector(
            rating: _providerRating,
            onRatingChanged: (val) => setState(() => _providerRating = val),
          ),
          
          const SizedBox(height: 16),
          
          // Handyman Rating
          if (widget.booking.assignedHandymanName != null) ...[
            Text('Rate Handyman: ${widget.booking.assignedHandymanName}', style: const TextStyle(fontWeight: FontWeight.w600)),
            _StarSelector(
              rating: _handymanRating,
              onRatingChanged: (val) => setState(() => _handymanRating = val),
            ),
            const SizedBox(height: 16),
          ],

          TextField(
            controller: _commentController,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Tell us more (optional)...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          
          // Photos
          Row(
            children: [
              ..._images.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Stack(
                  children: [
                    Image.file(_images[entry.key], width: 60, height: 60, fit: BoxFit.cover),
                    Positioned(right: 0, top: 0, child: GestureDetector(
                      onTap: () => setState(() => _images.removeAt(entry.key)),
                      child: const CircleAvatar(radius: 10, backgroundColor: Colors.red, child: Icon(Icons.close, size: 12, color: Colors.white)),
                    )),
                  ],
                ),
              )),
              if (_images.length < 3)
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.add_a_photo, size: 20, color: Colors.grey)),
                ),
            ],
          ),
          
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isSubmitting || _providerRating == 0 || _handymanRating == 0 ? null : _submit,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isSubmitting 
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Submit Review', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Skip for now', style: TextStyle(color: Colors.grey)),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _StarSelector extends StatelessWidget {
  final double rating;
  final Function(double) onRatingChanged;
  const _StarSelector({required this.rating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) => IconButton(
        icon: Icon(index < rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 32),
        onPressed: () => onRatingChanged(index + 1.0),
      )),
    );
  }
}
