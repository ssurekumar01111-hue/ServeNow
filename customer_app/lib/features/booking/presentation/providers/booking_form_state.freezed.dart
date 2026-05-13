// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingFormState {

 AddressEntity? get address; DateTime? get selectedDate; DateTime? get selectedTime; String? get providerId; String? get providerName; String? get notes; List<String>? get images; CouponEntity? get appliedCoupon; PaymentMethod get paymentMethod; bool get isSubmitting;
/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingFormStateCopyWith<BookingFormState> get copyWith => _$BookingFormStateCopyWithImpl<BookingFormState>(this as BookingFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingFormState&&(identical(other.address, address) || other.address == address)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.appliedCoupon, appliedCoupon) || other.appliedCoupon == appliedCoupon)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,address,selectedDate,selectedTime,providerId,providerName,notes,const DeepCollectionEquality().hash(images),appliedCoupon,paymentMethod,isSubmitting);

@override
String toString() {
  return 'BookingFormState(address: $address, selectedDate: $selectedDate, selectedTime: $selectedTime, providerId: $providerId, providerName: $providerName, notes: $notes, images: $images, appliedCoupon: $appliedCoupon, paymentMethod: $paymentMethod, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class $BookingFormStateCopyWith<$Res>  {
  factory $BookingFormStateCopyWith(BookingFormState value, $Res Function(BookingFormState) _then) = _$BookingFormStateCopyWithImpl;
@useResult
$Res call({
 AddressEntity? address, DateTime? selectedDate, DateTime? selectedTime, String? providerId, String? providerName, String? notes, List<String>? images, CouponEntity? appliedCoupon, PaymentMethod paymentMethod, bool isSubmitting
});


$AddressEntityCopyWith<$Res>? get address;$CouponEntityCopyWith<$Res>? get appliedCoupon;

}
/// @nodoc
class _$BookingFormStateCopyWithImpl<$Res>
    implements $BookingFormStateCopyWith<$Res> {
  _$BookingFormStateCopyWithImpl(this._self, this._then);

  final BookingFormState _self;
  final $Res Function(BookingFormState) _then;

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = freezed,Object? selectedDate = freezed,Object? selectedTime = freezed,Object? providerId = freezed,Object? providerName = freezed,Object? notes = freezed,Object? images = freezed,Object? appliedCoupon = freezed,Object? paymentMethod = null,Object? isSubmitting = null,}) {
  return _then(_self.copyWith(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressEntity?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,images: freezed == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,appliedCoupon: freezed == appliedCoupon ? _self.appliedCoupon : appliedCoupon // ignore: cast_nullable_to_non_nullable
as CouponEntity?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressEntityCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressEntityCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CouponEntityCopyWith<$Res>? get appliedCoupon {
    if (_self.appliedCoupon == null) {
    return null;
  }

  return $CouponEntityCopyWith<$Res>(_self.appliedCoupon!, (value) {
    return _then(_self.copyWith(appliedCoupon: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookingFormState].
extension BookingFormStatePatterns on BookingFormState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingFormState value)  $default,){
final _that = this;
switch (_that) {
case _BookingFormState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingFormState value)?  $default,){
final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AddressEntity? address,  DateTime? selectedDate,  DateTime? selectedTime,  String? providerId,  String? providerName,  String? notes,  List<String>? images,  CouponEntity? appliedCoupon,  PaymentMethod paymentMethod,  bool isSubmitting)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
return $default(_that.address,_that.selectedDate,_that.selectedTime,_that.providerId,_that.providerName,_that.notes,_that.images,_that.appliedCoupon,_that.paymentMethod,_that.isSubmitting);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AddressEntity? address,  DateTime? selectedDate,  DateTime? selectedTime,  String? providerId,  String? providerName,  String? notes,  List<String>? images,  CouponEntity? appliedCoupon,  PaymentMethod paymentMethod,  bool isSubmitting)  $default,) {final _that = this;
switch (_that) {
case _BookingFormState():
return $default(_that.address,_that.selectedDate,_that.selectedTime,_that.providerId,_that.providerName,_that.notes,_that.images,_that.appliedCoupon,_that.paymentMethod,_that.isSubmitting);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AddressEntity? address,  DateTime? selectedDate,  DateTime? selectedTime,  String? providerId,  String? providerName,  String? notes,  List<String>? images,  CouponEntity? appliedCoupon,  PaymentMethod paymentMethod,  bool isSubmitting)?  $default,) {final _that = this;
switch (_that) {
case _BookingFormState() when $default != null:
return $default(_that.address,_that.selectedDate,_that.selectedTime,_that.providerId,_that.providerName,_that.notes,_that.images,_that.appliedCoupon,_that.paymentMethod,_that.isSubmitting);case _:
  return null;

}
}

}

/// @nodoc


class _BookingFormState extends BookingFormState {
  const _BookingFormState({this.address, this.selectedDate, this.selectedTime, this.providerId, this.providerName, this.notes, final  List<String>? images, this.appliedCoupon, this.paymentMethod = PaymentMethod.cod, this.isSubmitting = false}): _images = images,super._();
  

@override final  AddressEntity? address;
@override final  DateTime? selectedDate;
@override final  DateTime? selectedTime;
@override final  String? providerId;
@override final  String? providerName;
@override final  String? notes;
 final  List<String>? _images;
@override List<String>? get images {
  final value = _images;
  if (value == null) return null;
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  CouponEntity? appliedCoupon;
@override@JsonKey() final  PaymentMethod paymentMethod;
@override@JsonKey() final  bool isSubmitting;

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingFormStateCopyWith<_BookingFormState> get copyWith => __$BookingFormStateCopyWithImpl<_BookingFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingFormState&&(identical(other.address, address) || other.address == address)&&(identical(other.selectedDate, selectedDate) || other.selectedDate == selectedDate)&&(identical(other.selectedTime, selectedTime) || other.selectedTime == selectedTime)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.appliedCoupon, appliedCoupon) || other.appliedCoupon == appliedCoupon)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting));
}


@override
int get hashCode => Object.hash(runtimeType,address,selectedDate,selectedTime,providerId,providerName,notes,const DeepCollectionEquality().hash(_images),appliedCoupon,paymentMethod,isSubmitting);

@override
String toString() {
  return 'BookingFormState(address: $address, selectedDate: $selectedDate, selectedTime: $selectedTime, providerId: $providerId, providerName: $providerName, notes: $notes, images: $images, appliedCoupon: $appliedCoupon, paymentMethod: $paymentMethod, isSubmitting: $isSubmitting)';
}


}

/// @nodoc
abstract mixin class _$BookingFormStateCopyWith<$Res> implements $BookingFormStateCopyWith<$Res> {
  factory _$BookingFormStateCopyWith(_BookingFormState value, $Res Function(_BookingFormState) _then) = __$BookingFormStateCopyWithImpl;
@override @useResult
$Res call({
 AddressEntity? address, DateTime? selectedDate, DateTime? selectedTime, String? providerId, String? providerName, String? notes, List<String>? images, CouponEntity? appliedCoupon, PaymentMethod paymentMethod, bool isSubmitting
});


@override $AddressEntityCopyWith<$Res>? get address;@override $CouponEntityCopyWith<$Res>? get appliedCoupon;

}
/// @nodoc
class __$BookingFormStateCopyWithImpl<$Res>
    implements _$BookingFormStateCopyWith<$Res> {
  __$BookingFormStateCopyWithImpl(this._self, this._then);

  final _BookingFormState _self;
  final $Res Function(_BookingFormState) _then;

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = freezed,Object? selectedDate = freezed,Object? selectedTime = freezed,Object? providerId = freezed,Object? providerName = freezed,Object? notes = freezed,Object? images = freezed,Object? appliedCoupon = freezed,Object? paymentMethod = null,Object? isSubmitting = null,}) {
  return _then(_BookingFormState(
address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressEntity?,selectedDate: freezed == selectedDate ? _self.selectedDate : selectedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedTime: freezed == selectedTime ? _self.selectedTime : selectedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,providerId: freezed == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,images: freezed == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>?,appliedCoupon: freezed == appliedCoupon ? _self.appliedCoupon : appliedCoupon // ignore: cast_nullable_to_non_nullable
as CouponEntity?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AddressEntityCopyWith<$Res>? get address {
    if (_self.address == null) {
    return null;
  }

  return $AddressEntityCopyWith<$Res>(_self.address!, (value) {
    return _then(_self.copyWith(address: value));
  });
}/// Create a copy of BookingFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CouponEntityCopyWith<$Res>? get appliedCoupon {
    if (_self.appliedCoupon == null) {
    return null;
  }

  return $CouponEntityCopyWith<$Res>(_self.appliedCoupon!, (value) {
    return _then(_self.copyWith(appliedCoupon: value));
  });
}
}

// dart format on
