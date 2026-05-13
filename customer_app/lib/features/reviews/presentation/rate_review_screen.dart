import 'dart:io';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/booking/presentation/providers/booking_providers.dart';
import 'package:customer/features/reviews/domain/review_entity.dart';
import 'package:customer/features/reviews/presentation/review_providers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RateReviewScreen extends ConsumerStatefulWidget {
  final String bookingId;
  final String providerId;

  const RateReviewScreen({
    super.key,
    required this.bookingId,
    required this.providerId,
  });

  @override
  ConsumerState<RateReviewScreen> createState() => _RateReviewScreenState();
}

class _RateReviewScreenState extends ConsumerState<RateReviewScreen> {
  double _providerRating = 0;
  double _handymanRating = 0;
  final _commentController = TextEditingController();
  final List<File> _images = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_images.length >= 3) return;
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (image != null) {
      setState(() {
        _images.add(File(image.path));
      });
    }
  }

  Future<List<String>> _uploadImages() async {
    final storage = FirebaseStorage.instance;
    final List<String> urls = [];
    for (var i = 0; i < _images.length; i++) {
      final ref = storage.ref().child('ratings/${widget.bookingId}/photo_$i.jpg');
      await ref.putFile(_images[i]);
      urls.add(await ref.getDownloadURL());
    }
    return urls;
  }

  Future<void> _submit() async {
    if (_providerRating == 0 || _handymanRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please provide ratings for both provider and handyman.')));
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final user = ref.read(authNotifierProvider).value;
      if (user == null) throw Exception('User not logged in');

      final booking = await ref.read(bookingDetailProvider(widget.bookingId).future);

      final photoUrls = await _uploadImages();

      final review = ReviewEntity(
        id: '',
        bookingId: widget.bookingId,
        customerId: user.uid,
        customerName: user.fullName ?? 'Customer',
        providerId: widget.providerId,
        handymanId: booking.assignedHandymanId,
        providerRating: _providerRating,
        handymanRating: _handymanRating,
        comment: _commentController.text,
        photos: photoUrls,
        createdAt: DateTime.now(),
      );

      await ref.read(reviewNotifierProvider.notifier).createReview(review);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you for your feedback!')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingAsync = ref.watch(bookingDetailProvider(widget.bookingId));

    return Scaffold(
      appBar: AppBar(title: const Text('Rate Service')),
      body: bookingAsync.when(
        data: (booking) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'How was your experience?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              // Provider Rating
              Text('Rate ${booking.providerName}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _StarSelector(
                rating: _providerRating,
                onRatingChanged: (rating) => setState(() => _providerRating = rating),
              ),
              
              const SizedBox(height: 24),
              
              // Handyman Rating
              if (booking.assignedHandymanName != null) ...[
                Text('Rate Handyman: ${booking.assignedHandymanName}', style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _StarSelector(
                  rating: _handymanRating,
                  onRatingChanged: (rating) => setState(() => _handymanRating = rating),
                ),
                const SizedBox(height: 24),
              ],

              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts about the service (optional)...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              
              // Image Upload
              const Text('Upload Photos (Optional, Max 3)', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  ..._images.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Image.file(_images[entry.key], width: 80, height: 80, fit: BoxFit.cover),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => setState(() => _images.removeAt(entry.key)),
                              child: const CircleAvatar(radius: 12, backgroundColor: Colors.red, child: Icon(Icons.close, size: 16, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  if (_images.length < 3)
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: const Icon(Icons.add_a_photo, color: Colors.grey),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSubmitting 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) 
                  : const Text('Submit Review', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
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
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 36,
          ),
          onPressed: () => onRatingChanged(index + 1.0),
        );
      }),
    );
  }
}
