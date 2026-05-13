// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingEntity {

 String get id; String get customerId; String get customerName; String get customerPhone; String get customerAddress; String get customerArea; String get providerId; String get providerName; String? get assignedHandymanId; String? get assignedHandymanName; String get serviceId; String get serviceName; String get serviceCategory; String get serviceCategoryId; DateTime get scheduledDate; String get scheduledTime; String get status; String get otp; double get amount; double get commission; double get providerEarning; double get handymanEarning; double get handymanCommissionRate; PaymentMethod get paymentMethod; PaymentStatus get paymentStatus; String? get razorpayOrderId; String? get razorpayPaymentId; String? get cancellationReason; String? get cancelledBy; String? get couponCode; double? get discountAmount; String? get notes; DateTime get createdAt; DateTime get updatedAt; DateTime? get completedAt; double? get rating; String? get review; bool get isRated; Map<String, DateTime>? get statusTimeline; double? get customerLat; double? get customerLng;
/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingEntityCopyWith<BookingEntity> get copyWith => _$BookingEntityCopyWithImpl<BookingEntity>(this as BookingEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.customerAddress, customerAddress) || other.customerAddress == customerAddress)&&(identical(other.customerArea, customerArea) || other.customerArea == customerArea)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.assignedHandymanId, assignedHandymanId) || other.assignedHandymanId == assignedHandymanId)&&(identical(other.assignedHandymanName, assignedHandymanName) || other.assignedHandymanName == assignedHandymanName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceCategory, serviceCategory) || other.serviceCategory == serviceCategory)&&(identical(other.serviceCategoryId, serviceCategoryId) || other.serviceCategoryId == serviceCategoryId)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.providerEarning, providerEarning) || other.providerEarning == providerEarning)&&(identical(other.handymanEarning, handymanEarning) || other.handymanEarning == handymanEarning)&&(identical(other.handymanCommissionRate, handymanCommissionRate) || other.handymanCommissionRate == handymanCommissionRate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.review, review) || other.review == review)&&(identical(other.isRated, isRated) || other.isRated == isRated)&&const DeepCollectionEquality().equals(other.statusTimeline, statusTimeline)&&(identical(other.customerLat, customerLat) || other.customerLat == customerLat)&&(identical(other.customerLng, customerLng) || other.customerLng == customerLng));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,customerAddress,customerArea,providerId,providerName,assignedHandymanId,assignedHandymanName,serviceId,serviceName,serviceCategory,serviceCategoryId,scheduledDate,scheduledTime,status,otp,amount,commission,providerEarning,handymanEarning,handymanCommissionRate,paymentMethod,paymentStatus,razorpayOrderId,razorpayPaymentId,cancellationReason,cancelledBy,couponCode,discountAmount,notes,createdAt,updatedAt,completedAt,rating,review,isRated,const DeepCollectionEquality().hash(statusTimeline),customerLat,customerLng]);

@override
String toString() {
  return 'BookingEntity(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, customerAddress: $customerAddress, customerArea: $customerArea, providerId: $providerId, providerName: $providerName, assignedHandymanId: $assignedHandymanId, assignedHandymanName: $assignedHandymanName, serviceId: $serviceId, serviceName: $serviceName, serviceCategory: $serviceCategory, serviceCategoryId: $serviceCategoryId, scheduledDate: $scheduledDate, scheduledTime: $scheduledTime, status: $status, otp: $otp, amount: $amount, commission: $commission, providerEarning: $providerEarning, handymanEarning: $handymanEarning, handymanCommissionRate: $handymanCommissionRate, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, cancellationReason: $cancellationReason, cancelledBy: $cancelledBy, couponCode: $couponCode, discountAmount: $discountAmount, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, rating: $rating, review: $review, isRated: $isRated, statusTimeline: $statusTimeline, customerLat: $customerLat, customerLng: $customerLng)';
}


}

/// @nodoc
abstract mixin class $BookingEntityCopyWith<$Res>  {
  factory $BookingEntityCopyWith(BookingEntity value, $Res Function(BookingEntity) _then) = _$BookingEntityCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String customerName, String customerPhone, String customerAddress, String customerArea, String providerId, String providerName, String? assignedHandymanId, String? assignedHandymanName, String serviceId, String serviceName, String serviceCategory, String serviceCategoryId, DateTime scheduledDate, String scheduledTime, String status, String otp, double amount, double commission, double providerEarning, double handymanEarning, double handymanCommissionRate, PaymentMethod paymentMethod, PaymentStatus paymentStatus, String? razorpayOrderId, String? razorpayPaymentId, String? cancellationReason, String? cancelledBy, String? couponCode, double? discountAmount, String? notes, DateTime createdAt, DateTime updatedAt, DateTime? completedAt, double? rating, String? review, bool isRated, Map<String, DateTime>? statusTimeline, double? customerLat, double? customerLng
});




}
/// @nodoc
class _$BookingEntityCopyWithImpl<$Res>
    implements $BookingEntityCopyWith<$Res> {
  _$BookingEntityCopyWithImpl(this._self, this._then);

  final BookingEntity _self;
  final $Res Function(BookingEntity) _then;

/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? customerAddress = null,Object? customerArea = null,Object? providerId = null,Object? providerName = null,Object? assignedHandymanId = freezed,Object? assignedHandymanName = freezed,Object? serviceId = null,Object? serviceName = null,Object? serviceCategory = null,Object? serviceCategoryId = null,Object? scheduledDate = null,Object? scheduledTime = null,Object? status = null,Object? otp = null,Object? amount = null,Object? commission = null,Object? providerEarning = null,Object? handymanEarning = null,Object? handymanCommissionRate = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? razorpayOrderId = freezed,Object? razorpayPaymentId = freezed,Object? cancellationReason = freezed,Object? cancelledBy = freezed,Object? couponCode = freezed,Object? discountAmount = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? rating = freezed,Object? review = freezed,Object? isRated = null,Object? statusTimeline = freezed,Object? customerLat = freezed,Object? customerLng = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,customerAddress: null == customerAddress ? _self.customerAddress : customerAddress // ignore: cast_nullable_to_non_nullable
as String,customerArea: null == customerArea ? _self.customerArea : customerArea // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,assignedHandymanId: freezed == assignedHandymanId ? _self.assignedHandymanId : assignedHandymanId // ignore: cast_nullable_to_non_nullable
as String?,assignedHandymanName: freezed == assignedHandymanName ? _self.assignedHandymanName : assignedHandymanName // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,serviceCategory: null == serviceCategory ? _self.serviceCategory : serviceCategory // ignore: cast_nullable_to_non_nullable
as String,serviceCategoryId: null == serviceCategoryId ? _self.serviceCategoryId : serviceCategoryId // ignore: cast_nullable_to_non_nullable
as String,scheduledDate: null == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as double,providerEarning: null == providerEarning ? _self.providerEarning : providerEarning // ignore: cast_nullable_to_non_nullable
as double,handymanEarning: null == handymanEarning ? _self.handymanEarning : handymanEarning // ignore: cast_nullable_to_non_nullable
as double,handymanCommissionRate: null == handymanCommissionRate ? _self.handymanCommissionRate : handymanCommissionRate // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,razorpayOrderId: freezed == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String?,razorpayPaymentId: freezed == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String?,isRated: null == isRated ? _self.isRated : isRated // ignore: cast_nullable_to_non_nullable
as bool,statusTimeline: freezed == statusTimeline ? _self.statusTimeline : statusTimeline // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>?,customerLat: freezed == customerLat ? _self.customerLat : customerLat // ignore: cast_nullable_to_non_nullable
as double?,customerLng: freezed == customerLng ? _self.customerLng : customerLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingEntity].
extension BookingEntityPatterns on BookingEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingEntity value)  $default,){
final _that = this;
switch (_that) {
case _BookingEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingEntity value)?  $default,){
final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String customerPhone,  String customerAddress,  String customerArea,  String providerId,  String providerName,  String? assignedHandymanId,  String? assignedHandymanName,  String serviceId,  String serviceName,  String serviceCategory,  String serviceCategoryId,  DateTime scheduledDate,  String scheduledTime,  String status,  String otp,  double amount,  double commission,  double providerEarning,  double handymanEarning,  double handymanCommissionRate,  PaymentMethod paymentMethod,  PaymentStatus paymentStatus,  String? razorpayOrderId,  String? razorpayPaymentId,  String? cancellationReason,  String? cancelledBy,  String? couponCode,  double? discountAmount,  String? notes,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt,  double? rating,  String? review,  bool isRated,  Map<String, DateTime>? statusTimeline,  double? customerLat,  double? customerLng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.customerAddress,_that.customerArea,_that.providerId,_that.providerName,_that.assignedHandymanId,_that.assignedHandymanName,_that.serviceId,_that.serviceName,_that.serviceCategory,_that.serviceCategoryId,_that.scheduledDate,_that.scheduledTime,_that.status,_that.otp,_that.amount,_that.commission,_that.providerEarning,_that.handymanEarning,_that.handymanCommissionRate,_that.paymentMethod,_that.paymentStatus,_that.razorpayOrderId,_that.razorpayPaymentId,_that.cancellationReason,_that.cancelledBy,_that.couponCode,_that.discountAmount,_that.notes,_that.createdAt,_that.updatedAt,_that.completedAt,_that.rating,_that.review,_that.isRated,_that.statusTimeline,_that.customerLat,_that.customerLng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String customerPhone,  String customerAddress,  String customerArea,  String providerId,  String providerName,  String? assignedHandymanId,  String? assignedHandymanName,  String serviceId,  String serviceName,  String serviceCategory,  String serviceCategoryId,  DateTime scheduledDate,  String scheduledTime,  String status,  String otp,  double amount,  double commission,  double providerEarning,  double handymanEarning,  double handymanCommissionRate,  PaymentMethod paymentMethod,  PaymentStatus paymentStatus,  String? razorpayOrderId,  String? razorpayPaymentId,  String? cancellationReason,  String? cancelledBy,  String? couponCode,  double? discountAmount,  String? notes,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt,  double? rating,  String? review,  bool isRated,  Map<String, DateTime>? statusTimeline,  double? customerLat,  double? customerLng)  $default,) {final _that = this;
switch (_that) {
case _BookingEntity():
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.customerAddress,_that.customerArea,_that.providerId,_that.providerName,_that.assignedHandymanId,_that.assignedHandymanName,_that.serviceId,_that.serviceName,_that.serviceCategory,_that.serviceCategoryId,_that.scheduledDate,_that.scheduledTime,_that.status,_that.otp,_that.amount,_that.commission,_that.providerEarning,_that.handymanEarning,_that.handymanCommissionRate,_that.paymentMethod,_that.paymentStatus,_that.razorpayOrderId,_that.razorpayPaymentId,_that.cancellationReason,_that.cancelledBy,_that.couponCode,_that.discountAmount,_that.notes,_that.createdAt,_that.updatedAt,_that.completedAt,_that.rating,_that.review,_that.isRated,_that.statusTimeline,_that.customerLat,_that.customerLng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String customerName,  String customerPhone,  String customerAddress,  String customerArea,  String providerId,  String providerName,  String? assignedHandymanId,  String? assignedHandymanName,  String serviceId,  String serviceName,  String serviceCategory,  String serviceCategoryId,  DateTime scheduledDate,  String scheduledTime,  String status,  String otp,  double amount,  double commission,  double providerEarning,  double handymanEarning,  double handymanCommissionRate,  PaymentMethod paymentMethod,  PaymentStatus paymentStatus,  String? razorpayOrderId,  String? razorpayPaymentId,  String? cancellationReason,  String? cancelledBy,  String? couponCode,  double? discountAmount,  String? notes,  DateTime createdAt,  DateTime updatedAt,  DateTime? completedAt,  double? rating,  String? review,  bool isRated,  Map<String, DateTime>? statusTimeline,  double? customerLat,  double? customerLng)?  $default,) {final _that = this;
switch (_that) {
case _BookingEntity() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.customerAddress,_that.customerArea,_that.providerId,_that.providerName,_that.assignedHandymanId,_that.assignedHandymanName,_that.serviceId,_that.serviceName,_that.serviceCategory,_that.serviceCategoryId,_that.scheduledDate,_that.scheduledTime,_that.status,_that.otp,_that.amount,_that.commission,_that.providerEarning,_that.handymanEarning,_that.handymanCommissionRate,_that.paymentMethod,_that.paymentStatus,_that.razorpayOrderId,_that.razorpayPaymentId,_that.cancellationReason,_that.cancelledBy,_that.couponCode,_that.discountAmount,_that.notes,_that.createdAt,_that.updatedAt,_that.completedAt,_that.rating,_that.review,_that.isRated,_that.statusTimeline,_that.customerLat,_that.customerLng);case _:
  return null;

}
}

}

/// @nodoc


class _BookingEntity extends BookingEntity {
  const _BookingEntity({required this.id, required this.customerId, required this.customerName, required this.customerPhone, required this.customerAddress, required this.customerArea, required this.providerId, required this.providerName, this.assignedHandymanId, this.assignedHandymanName, required this.serviceId, required this.serviceName, required this.serviceCategory, required this.serviceCategoryId, required this.scheduledDate, required this.scheduledTime, required this.status, required this.otp, required this.amount, required this.commission, required this.providerEarning, this.handymanEarning = 0.0, this.handymanCommissionRate = 0.0, required this.paymentMethod, required this.paymentStatus, this.razorpayOrderId, this.razorpayPaymentId, this.cancellationReason, this.cancelledBy, this.couponCode, this.discountAmount, this.notes, required this.createdAt, required this.updatedAt, this.completedAt, this.rating, this.review, this.isRated = false, final  Map<String, DateTime>? statusTimeline, this.customerLat, this.customerLng}): _statusTimeline = statusTimeline,super._();
  

@override final  String id;
@override final  String customerId;
@override final  String customerName;
@override final  String customerPhone;
@override final  String customerAddress;
@override final  String customerArea;
@override final  String providerId;
@override final  String providerName;
@override final  String? assignedHandymanId;
@override final  String? assignedHandymanName;
@override final  String serviceId;
@override final  String serviceName;
@override final  String serviceCategory;
@override final  String serviceCategoryId;
@override final  DateTime scheduledDate;
@override final  String scheduledTime;
@override final  String status;
@override final  String otp;
@override final  double amount;
@override final  double commission;
@override final  double providerEarning;
@override@JsonKey() final  double handymanEarning;
@override@JsonKey() final  double handymanCommissionRate;
@override final  PaymentMethod paymentMethod;
@override final  PaymentStatus paymentStatus;
@override final  String? razorpayOrderId;
@override final  String? razorpayPaymentId;
@override final  String? cancellationReason;
@override final  String? cancelledBy;
@override final  String? couponCode;
@override final  double? discountAmount;
@override final  String? notes;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? completedAt;
@override final  double? rating;
@override final  String? review;
@override@JsonKey() final  bool isRated;
 final  Map<String, DateTime>? _statusTimeline;
@override Map<String, DateTime>? get statusTimeline {
  final value = _statusTimeline;
  if (value == null) return null;
  if (_statusTimeline is EqualUnmodifiableMapView) return _statusTimeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  double? customerLat;
@override final  double? customerLng;

/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingEntityCopyWith<_BookingEntity> get copyWith => __$BookingEntityCopyWithImpl<_BookingEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.customerAddress, customerAddress) || other.customerAddress == customerAddress)&&(identical(other.customerArea, customerArea) || other.customerArea == customerArea)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.assignedHandymanId, assignedHandymanId) || other.assignedHandymanId == assignedHandymanId)&&(identical(other.assignedHandymanName, assignedHandymanName) || other.assignedHandymanName == assignedHandymanName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceCategory, serviceCategory) || other.serviceCategory == serviceCategory)&&(identical(other.serviceCategoryId, serviceCategoryId) || other.serviceCategoryId == serviceCategoryId)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.providerEarning, providerEarning) || other.providerEarning == providerEarning)&&(identical(other.handymanEarning, handymanEarning) || other.handymanEarning == handymanEarning)&&(identical(other.handymanCommissionRate, handymanCommissionRate) || other.handymanCommissionRate == handymanCommissionRate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.review, review) || other.review == review)&&(identical(other.isRated, isRated) || other.isRated == isRated)&&const DeepCollectionEquality().equals(other._statusTimeline, _statusTimeline)&&(identical(other.customerLat, customerLat) || other.customerLat == customerLat)&&(identical(other.customerLng, customerLng) || other.customerLng == customerLng));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,customerAddress,customerArea,providerId,providerName,assignedHandymanId,assignedHandymanName,serviceId,serviceName,serviceCategory,serviceCategoryId,scheduledDate,scheduledTime,status,otp,amount,commission,providerEarning,handymanEarning,handymanCommissionRate,paymentMethod,paymentStatus,razorpayOrderId,razorpayPaymentId,cancellationReason,cancelledBy,couponCode,discountAmount,notes,createdAt,updatedAt,completedAt,rating,review,isRated,const DeepCollectionEquality().hash(_statusTimeline),customerLat,customerLng]);

@override
String toString() {
  return 'BookingEntity(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, customerAddress: $customerAddress, customerArea: $customerArea, providerId: $providerId, providerName: $providerName, assignedHandymanId: $assignedHandymanId, assignedHandymanName: $assignedHandymanName, serviceId: $serviceId, serviceName: $serviceName, serviceCategory: $serviceCategory, serviceCategoryId: $serviceCategoryId, scheduledDate: $scheduledDate, scheduledTime: $scheduledTime, status: $status, otp: $otp, amount: $amount, commission: $commission, providerEarning: $providerEarning, handymanEarning: $handymanEarning, handymanCommissionRate: $handymanCommissionRate, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, cancellationReason: $cancellationReason, cancelledBy: $cancelledBy, couponCode: $couponCode, discountAmount: $discountAmount, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, rating: $rating, review: $review, isRated: $isRated, statusTimeline: $statusTimeline, customerLat: $customerLat, customerLng: $customerLng)';
}


}

/// @nodoc
abstract mixin class _$BookingEntityCopyWith<$Res> implements $BookingEntityCopyWith<$Res> {
  factory _$BookingEntityCopyWith(_BookingEntity value, $Res Function(_BookingEntity) _then) = __$BookingEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String customerName, String customerPhone, String customerAddress, String customerArea, String providerId, String providerName, String? assignedHandymanId, String? assignedHandymanName, String serviceId, String serviceName, String serviceCategory, String serviceCategoryId, DateTime scheduledDate, String scheduledTime, String status, String otp, double amount, double commission, double providerEarning, double handymanEarning, double handymanCommissionRate, PaymentMethod paymentMethod, PaymentStatus paymentStatus, String? razorpayOrderId, String? razorpayPaymentId, String? cancellationReason, String? cancelledBy, String? couponCode, double? discountAmount, String? notes, DateTime createdAt, DateTime updatedAt, DateTime? completedAt, double? rating, String? review, bool isRated, Map<String, DateTime>? statusTimeline, double? customerLat, double? customerLng
});




}
/// @nodoc
class __$BookingEntityCopyWithImpl<$Res>
    implements _$BookingEntityCopyWith<$Res> {
  __$BookingEntityCopyWithImpl(this._self, this._then);

  final _BookingEntity _self;
  final $Res Function(_BookingEntity) _then;

/// Create a copy of BookingEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? customerAddress = null,Object? customerArea = null,Object? providerId = null,Object? providerName = null,Object? assignedHandymanId = freezed,Object? assignedHandymanName = freezed,Object? serviceId = null,Object? serviceName = null,Object? serviceCategory = null,Object? serviceCategoryId = null,Object? scheduledDate = null,Object? scheduledTime = null,Object? status = null,Object? otp = null,Object? amount = null,Object? commission = null,Object? providerEarning = null,Object? handymanEarning = null,Object? handymanCommissionRate = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? razorpayOrderId = freezed,Object? razorpayPaymentId = freezed,Object? cancellationReason = freezed,Object? cancelledBy = freezed,Object? couponCode = freezed,Object? discountAmount = freezed,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? rating = freezed,Object? review = freezed,Object? isRated = null,Object? statusTimeline = freezed,Object? customerLat = freezed,Object? customerLng = freezed,}) {
  return _then(_BookingEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,customerAddress: null == customerAddress ? _self.customerAddress : customerAddress // ignore: cast_nullable_to_non_nullable
as String,customerArea: null == customerArea ? _self.customerArea : customerArea // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,providerName: null == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String,assignedHandymanId: freezed == assignedHandymanId ? _self.assignedHandymanId : assignedHandymanId // ignore: cast_nullable_to_non_nullable
as String?,assignedHandymanName: freezed == assignedHandymanName ? _self.assignedHandymanName : assignedHandymanName // ignore: cast_nullable_to_non_nullable
as String?,serviceId: null == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,serviceCategory: null == serviceCategory ? _self.serviceCategory : serviceCategory // ignore: cast_nullable_to_non_nullable
as String,serviceCategoryId: null == serviceCategoryId ? _self.serviceCategoryId : serviceCategoryId // ignore: cast_nullable_to_non_nullable
as String,scheduledDate: null == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as DateTime,scheduledTime: null == scheduledTime ? _self.scheduledTime : scheduledTime // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,commission: null == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as double,providerEarning: null == providerEarning ? _self.providerEarning : providerEarning // ignore: cast_nullable_to_non_nullable
as double,handymanEarning: null == handymanEarning ? _self.handymanEarning : handymanEarning // ignore: cast_nullable_to_non_nullable
as double,handymanCommissionRate: null == handymanCommissionRate ? _self.handymanCommissionRate : handymanCommissionRate // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as PaymentStatus,razorpayOrderId: freezed == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String?,razorpayPaymentId: freezed == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: freezed == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String?,isRated: null == isRated ? _self.isRated : isRated // ignore: cast_nullable_to_non_nullable
as bool,statusTimeline: freezed == statusTimeline ? _self._statusTimeline : statusTimeline // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>?,customerLat: freezed == customerLat ? _self.customerLat : customerLat // ignore: cast_nullable_to_non_nullable
as double?,customerLng: freezed == customerLng ? _self.customerLng : customerLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc
mixin _$SlotEntity {

 DateTime get dateTime; bool? get isAvailable;
/// Create a copy of SlotEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlotEntityCopyWith<SlotEntity> get copyWith => _$SlotEntityCopyWithImpl<SlotEntity>(this as SlotEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlotEntity&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,isAvailable);

@override
String toString() {
  return 'SlotEntity(dateTime: $dateTime, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $SlotEntityCopyWith<$Res>  {
  factory $SlotEntityCopyWith(SlotEntity value, $Res Function(SlotEntity) _then) = _$SlotEntityCopyWithImpl;
@useResult
$Res call({
 DateTime dateTime, bool? isAvailable
});




}
/// @nodoc
class _$SlotEntityCopyWithImpl<$Res>
    implements $SlotEntityCopyWith<$Res> {
  _$SlotEntityCopyWithImpl(this._self, this._then);

  final SlotEntity _self;
  final $Res Function(SlotEntity) _then;

/// Create a copy of SlotEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = null,Object? isAvailable = freezed,}) {
  return _then(_self.copyWith(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,isAvailable: freezed == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SlotEntity].
extension SlotEntityPatterns on SlotEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlotEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlotEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlotEntity value)  $default,){
final _that = this;
switch (_that) {
case _SlotEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlotEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SlotEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime dateTime,  bool? isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlotEntity() when $default != null:
return $default(_that.dateTime,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime dateTime,  bool? isAvailable)  $default,) {final _that = this;
switch (_that) {
case _SlotEntity():
return $default(_that.dateTime,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime dateTime,  bool? isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _SlotEntity() when $default != null:
return $default(_that.dateTime,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc


class _SlotEntity extends SlotEntity {
  const _SlotEntity({required this.dateTime, this.isAvailable}): super._();
  

@override final  DateTime dateTime;
@override final  bool? isAvailable;

/// Create a copy of SlotEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlotEntityCopyWith<_SlotEntity> get copyWith => __$SlotEntityCopyWithImpl<_SlotEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlotEntity&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,isAvailable);

@override
String toString() {
  return 'SlotEntity(dateTime: $dateTime, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$SlotEntityCopyWith<$Res> implements $SlotEntityCopyWith<$Res> {
  factory _$SlotEntityCopyWith(_SlotEntity value, $Res Function(_SlotEntity) _then) = __$SlotEntityCopyWithImpl;
@override @useResult
$Res call({
 DateTime dateTime, bool? isAvailable
});




}
/// @nodoc
class __$SlotEntityCopyWithImpl<$Res>
    implements _$SlotEntityCopyWith<$Res> {
  __$SlotEntityCopyWithImpl(this._self, this._then);

  final _SlotEntity _self;
  final $Res Function(_SlotEntity) _then;

/// Create a copy of SlotEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = null,Object? isAvailable = freezed,}) {
  return _then(_SlotEntity(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,isAvailable: freezed == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc
mixin _$CouponEntity {

 String get code; double get discount; String get type;// flat | percentage
 double get minOrder; DateTime get expiresAt; double? get maxDiscount; bool? get isActive;
/// Create a copy of CouponEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponEntityCopyWith<CouponEntity> get copyWith => _$CouponEntityCopyWithImpl<CouponEntity>(this as CouponEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CouponEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.type, type) || other.type == type)&&(identical(other.minOrder, minOrder) || other.minOrder == minOrder)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,code,discount,type,minOrder,expiresAt,maxDiscount,isActive);

@override
String toString() {
  return 'CouponEntity(code: $code, discount: $discount, type: $type, minOrder: $minOrder, expiresAt: $expiresAt, maxDiscount: $maxDiscount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CouponEntityCopyWith<$Res>  {
  factory $CouponEntityCopyWith(CouponEntity value, $Res Function(CouponEntity) _then) = _$CouponEntityCopyWithImpl;
@useResult
$Res call({
 String code, double discount, String type, double minOrder, DateTime expiresAt, double? maxDiscount, bool? isActive
});




}
/// @nodoc
class _$CouponEntityCopyWithImpl<$Res>
    implements $CouponEntityCopyWith<$Res> {
  _$CouponEntityCopyWithImpl(this._self, this._then);

  final CouponEntity _self;
  final $Res Function(CouponEntity) _then;

/// Create a copy of CouponEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? discount = null,Object? type = null,Object? minOrder = null,Object? expiresAt = null,Object? maxDiscount = freezed,Object? isActive = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,minOrder: null == minOrder ? _self.minOrder : minOrder // ignore: cast_nullable_to_non_nullable
as double,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxDiscount: freezed == maxDiscount ? _self.maxDiscount : maxDiscount // ignore: cast_nullable_to_non_nullable
as double?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [CouponEntity].
extension CouponEntityPatterns on CouponEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CouponEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CouponEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CouponEntity value)  $default,){
final _that = this;
switch (_that) {
case _CouponEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CouponEntity value)?  $default,){
final _that = this;
switch (_that) {
case _CouponEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  double discount,  String type,  double minOrder,  DateTime expiresAt,  double? maxDiscount,  bool? isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CouponEntity() when $default != null:
return $default(_that.code,_that.discount,_that.type,_that.minOrder,_that.expiresAt,_that.maxDiscount,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  double discount,  String type,  double minOrder,  DateTime expiresAt,  double? maxDiscount,  bool? isActive)  $default,) {final _that = this;
switch (_that) {
case _CouponEntity():
return $default(_that.code,_that.discount,_that.type,_that.minOrder,_that.expiresAt,_that.maxDiscount,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  double discount,  String type,  double minOrder,  DateTime expiresAt,  double? maxDiscount,  bool? isActive)?  $default,) {final _that = this;
switch (_that) {
case _CouponEntity() when $default != null:
return $default(_that.code,_that.discount,_that.type,_that.minOrder,_that.expiresAt,_that.maxDiscount,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _CouponEntity extends CouponEntity {
  const _CouponEntity({required this.code, required this.discount, required this.type, required this.minOrder, required this.expiresAt, this.maxDiscount, this.isActive}): super._();
  

@override final  String code;
@override final  double discount;
@override final  String type;
// flat | percentage
@override final  double minOrder;
@override final  DateTime expiresAt;
@override final  double? maxDiscount;
@override final  bool? isActive;

/// Create a copy of CouponEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponEntityCopyWith<_CouponEntity> get copyWith => __$CouponEntityCopyWithImpl<_CouponEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CouponEntity&&(identical(other.code, code) || other.code == code)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.type, type) || other.type == type)&&(identical(other.minOrder, minOrder) || other.minOrder == minOrder)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,code,discount,type,minOrder,expiresAt,maxDiscount,isActive);

@override
String toString() {
  return 'CouponEntity(code: $code, discount: $discount, type: $type, minOrder: $minOrder, expiresAt: $expiresAt, maxDiscount: $maxDiscount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CouponEntityCopyWith<$Res> implements $CouponEntityCopyWith<$Res> {
  factory _$CouponEntityCopyWith(_CouponEntity value, $Res Function(_CouponEntity) _then) = __$CouponEntityCopyWithImpl;
@override @useResult
$Res call({
 String code, double discount, String type, double minOrder, DateTime expiresAt, double? maxDiscount, bool? isActive
});




}
/// @nodoc
class __$CouponEntityCopyWithImpl<$Res>
    implements _$CouponEntityCopyWith<$Res> {
  __$CouponEntityCopyWithImpl(this._self, this._then);

  final _CouponEntity _self;
  final $Res Function(_CouponEntity) _then;

/// Create a copy of CouponEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? discount = null,Object? type = null,Object? minOrder = null,Object? expiresAt = null,Object? maxDiscount = freezed,Object? isActive = freezed,}) {
  return _then(_CouponEntity(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,discount: null == discount ? _self.discount : discount // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,minOrder: null == minOrder ? _self.minOrder : minOrder // ignore: cast_nullable_to_non_nullable
as double,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,maxDiscount: freezed == maxDiscount ? _self.maxDiscount : maxDiscount // ignore: cast_nullable_to_non_nullable
as double?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
