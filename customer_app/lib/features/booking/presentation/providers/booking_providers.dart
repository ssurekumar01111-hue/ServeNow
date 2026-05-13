import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/core/constants/booking_status.dart';
import 'package:customer/core/providers/firebase_providers.dart';
import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:customer/features/auth/presentation/providers/auth_provider.dart';
import 'package:customer/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:customer/features/booking/data/models/booking_model.dart';
import 'package:customer/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/features/booking/domain/repositories/booking_repository.dart';
import 'package:customer/features/booking/presentation/providers/booking_form_state.dart';
import 'package:customer/features/booking/presentation/providers/coupon_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

export 'package:customer/features/booking/presentation/providers/booking_form_state.dart';
export 'package:customer/features/booking/presentation/providers/coupon_provider.dart';

final bookingRemoteDataSourceProvider = Provider<BookingRemoteDataSource>((ref) {
  return BookingRemoteDataSourceImpl(ref.watch(firestoreProvider));
});

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepositoryImpl(ref.watch(bookingRemoteDataSourceProvider));
});

final myBookingsProvider = StreamProvider<List<BookingEntity>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);
  
  return ref.watch(bookingRepositoryProvider).getBookings(user.uid);
});

final bookingDetailProvider = StreamProvider.family<BookingEntity, String>((ref, id) {
  return ref.watch(bookingRepositoryProvider).getBookingById(id);
});

final bookingStatusProvider = StreamProvider.family<String, String>((ref, id) {
  return ref.watch(firestoreProvider)
      .collection('bookings')
      .doc(id)
      .snapshots()
      .map((doc) => doc.data()?['status'] as String? ?? BookingStatuses.pending);
});

// Saved addresses provider
final savedAddressesProvider = StreamProvider<List<AddressEntity>>((ref) {
  final user = ref.watch(authNotifierProvider).value;
  if (user == null) return Stream.value([]);
  
  return ref.watch(firestoreProvider)
      .collection('users')
      .doc(user.uid)
      .collection('addresses')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
        final data = doc.data();
        return AddressEntity(
          id: doc.id,
          fullAddress: data['fullAddress'],
          city: data['city'],
          state: data['state'],
          lat: (data['lat'] as num?)?.toDouble(),
          lng: (data['lng'] as num?)?.toDouble(),
          pincode: data['pincode'],
        );
      }).toList());
});

// Create booking provider (form state)
final createBookingProvider = NotifierProvider<CreateBookingNotifier, BookingFormState>(CreateBookingNotifier.new);

class CreateBookingNotifier extends Notifier<BookingFormState> {
  @override
  BookingFormState build() {
    return const BookingFormState();
  }

  void updateAddress(AddressEntity address) {
    state = state.copyWith(address: address);
  }

  void updateProvider(String id, String name) {
    state = state.copyWith(providerId: id, providerName: name);
  }

  void updateDateTime(DateTime date, DateTime time) {
    state = state.copyWith(selectedDate: date, selectedTime: time);
  }

  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void applyCoupon(CouponEntity coupon) {
    state = state.copyWith(appliedCoupon: coupon);
  }
}
