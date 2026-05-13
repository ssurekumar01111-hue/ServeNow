import 'package:customer/features/booking/domain/entities/booking_entity.dart';

abstract class BookingRepository {
  Future<void> createBooking(BookingEntity booking);
  Stream<List<BookingEntity>> getBookings(String userId);
  Stream<BookingEntity> getBookingById(String id);
  Future<void> updateBookingStatus(String id, String status);
}
