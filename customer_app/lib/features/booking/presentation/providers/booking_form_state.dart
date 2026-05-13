import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:customer/features/booking/domain/entities/booking_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_form_state.freezed.dart';

@freezed
abstract class BookingFormState with _$BookingFormState {
  const factory BookingFormState({
    AddressEntity? address,
    DateTime? selectedDate,
    DateTime? selectedTime,
    String? providerId,
    String? providerName,
    String? notes,
    List<String>? images,
    CouponEntity? appliedCoupon,
    @Default(PaymentMethod.cod) PaymentMethod paymentMethod,
    @Default(false) bool isSubmitting,
  }) = _BookingFormState;

  const BookingFormState._();
}
