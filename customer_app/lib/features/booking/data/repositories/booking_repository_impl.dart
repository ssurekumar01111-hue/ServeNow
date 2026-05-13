import 'package:customer/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:customer/features/booking/data/models/booking_model.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:customer/features/booking/domain/repositories/booking_repository.dart';
import 'package:customer/core/constants/booking_status.dart';

class BookingRepositoryImpl implements BookingRepository {
  BookingRepositoryImpl(this.remoteDataSource);
  final BookingRemoteDataSource remoteDataSource;

  @override
  Future<void> createBooking(BookingEntity booking) async {
    final model = BookingModel.fromEntity(booking);
    await remoteDataSource.createBooking(model);
  }

  @override
  Stream<List<BookingEntity>> getBookings(String userId) {
    return remoteDataSource.getBookings(userId).map(
          (list) => list.map((model) => model.toEntity()).toList(),
        );
  }

  @override
  Stream<BookingEntity> getBookingById(String id) {
    return remoteDataSource.getBookingById(id).map((model) => model.toEntity());
  }

  @override
  Future<void> updateBookingStatus(String id, String status) async {
    await remoteDataSource.updateBookingStatus(id, status);
  }
}
