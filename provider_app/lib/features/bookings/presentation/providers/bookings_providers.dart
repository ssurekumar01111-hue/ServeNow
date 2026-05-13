import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/core/providers/firebase_providers.dart';
import 'package:provider/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/features/bookings/domain/entities/booking_entity.dart';
import 'package:provider/features/bookings/data/datasources/bookings_remote_datasource.dart';
import 'package:provider/features/profile/presentation/providers/profile_providers.dart';

final bookingsRemoteDataSourceProvider = Provider<BookingsRemoteDataSource>((ref) {
  return BookingsRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final bookingsProvider = StreamProvider<List<BookingEntity>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return const Stream.empty();
  
  final profileAsync = ref.watch(providerProfileProvider);
  return profileAsync.when(
    data: (profile) {
      if (profile == null) return const Stream.empty();
      return ref.watch(bookingsRemoteDataSourceProvider).getBookings(user.uid, profile.categories);
    },
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});

final pendingBookingsProvider = StreamProvider<List<BookingEntity>>((ref) {
  final bookingsAsync = ref.watch(bookingsProvider);
  return bookingsAsync.when(
    data: (bookings) => Stream.value(bookings.where((b) => b.status == BookingStatus.pending).toList()),
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});

final activeBookingsProvider = StreamProvider<List<BookingEntity>>((ref) {
  final bookingsAsync = ref.watch(bookingsProvider);
  return bookingsAsync.when(
    data: (bookings) => Stream.value(bookings.where((b) => [
      BookingStatus.confirmed,
      BookingStatus.assigned,
      BookingStatus.en_route,
      BookingStatus.arrived,
      BookingStatus.in_progress,
    ].contains(b.status)).toList()),
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});

final completedBookingsProvider = StreamProvider<List<BookingEntity>>((ref) {
  final bookingsAsync = ref.watch(bookingsProvider);
  return bookingsAsync.when(
    data: (bookings) => Stream.value(bookings.where((b) => b.status == BookingStatus.completed).toList()),
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});

final cancelledBookingsProvider = StreamProvider<List<BookingEntity>>((ref) {
  final bookingsAsync = ref.watch(bookingsProvider);
  return bookingsAsync.when(
    data: (bookings) => Stream.value(bookings.where((b) => b.status == BookingStatus.cancelled).toList()),
    loading: () => const Stream.empty(),
    error: (e, st) => Stream.error(e, st),
  );
});

final bookingDetailProvider = StreamProvider.family<BookingEntity?, String>((ref, bookingId) {
  final firestore = ref.watch(firestoreProvider);
  return firestore.collection('bookings').doc(bookingId).snapshots().map((doc) {
    if (!doc.exists) return null;
    try {
      final data = doc.data()!;
      // Use the same mapping logic as getBookings
      return BookingEntity(
        id: doc.id,
        customerId: (data['customerId'] as String?) ?? '',
        customerName: (data['customerName'] as String?) ?? 'Customer',
        customerPhone: (data['customerPhone'] as String?) ?? '',
        customerAddress: (data['customerAddress'] as String?) ?? '',
        customerArea: (data['customerArea'] as String?) ?? '',
        providerId: (data['providerId'] as String?) ?? '',
        providerName: (data['providerName'] as String?) ?? '',
        assignedHandymanId: data['assignedHandymanId'] as String?,
        assignedHandymanName: data['assignedHandymanName'] as String?,
        serviceId: (data['serviceId'] as String?) ?? '',
        serviceName: (data['serviceName'] as String?) ?? '',
        serviceCategory: (data['serviceCategory'] as String?) ?? '',
        serviceCategoryId: (data['serviceCategoryId'] as String?) ?? '',
        scheduledDate: _parseTimestamp(data['scheduledDate'] ?? data['scheduledAt']),
        scheduledTime: (data['scheduledTime'] as String?) ?? '',
        status: BookingStatus.values.firstWhere(
            (e) => e.name == ((data['status'] as String?) ?? 'pending'),
            orElse: () => BookingStatus.pending),
        otp: (data['otp'] as String?) ?? '',
        amount: ((data['amount'] as num?) ?? 0.0).toDouble(),
        commission: ((data['commission'] as num?) ?? 0.0).toDouble(),
        providerEarning: ((data['providerEarning'] as num?) ?? 0.0).toDouble(),
        paymentMethod: PaymentMethod.values.firstWhere(
            (e) => e.name == ((data['paymentMethod'] as String?) ?? 'cod'),
            orElse: () => PaymentMethod.cod),
        paymentStatus: PaymentStatus.values.firstWhere(
            (e) => e.name == ((data['paymentStatus'] as String?) ?? 'pending'),
            orElse: () => PaymentStatus.pending),
        cancellationReason: data['cancellationReason'] as String?,
        cancelledBy: data['cancelledBy'] as String?,
        couponCode: data['couponCode'] as String?,
        discountAmount: ((data['discountAmount'] as num?) ?? 0.0).toDouble(),
        notes: data['notes'] as String?,
        createdAt: _parseTimestamp(data['createdAt']),
        updatedAt: _parseTimestamp(data['updatedAt']),
        completedAt: _parseOptionalTimestamp(data['completedAt']),
        rating: (data['rating'] as num?)?.toDouble(),
        review: data['review'] as String?,
        autoAssigned: (data['autoAssigned'] as bool?) ?? false,
        autoAssignedAt: _parseOptionalTimestamp(data['autoAssignedAt']),
      );
    } catch (e) {
      print('Error parsing booking detail ${doc.id}: $e');
      return null;
    }
  });
});

DateTime _parseTimestamp(dynamic value) {
  if (value == null) return DateTime.now();
  if (value is Timestamp) return value.toDate();
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return DateTime.now();
    }
  }
  return DateTime.now();
}

DateTime? _parseOptionalTimestamp(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }
  return null;
}

final bookingStatusProvider = AsyncNotifierProvider<BookingStatusNotifier, void>(BookingStatusNotifier.new);

class BookingStatusNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> updateStatus(String bookingId, BookingStatus status) async {
    state = const AsyncLoading();
    try {
      await ref.read(bookingsRemoteDataSourceProvider).updateBookingStatus(bookingId, status.name);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> assignHandyman(String bookingId, String handymanId, String handymanName) async {
    state = const AsyncLoading();
    try {
      await ref.read(bookingsRemoteDataSourceProvider).assignHandyman(bookingId, handymanId, handymanName);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> claimBooking(String bookingId, String providerId, String providerName) async {
    state = const AsyncLoading();
    try {
      await ref.read(bookingsRemoteDataSourceProvider).claimBooking(bookingId, providerId, providerName);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
