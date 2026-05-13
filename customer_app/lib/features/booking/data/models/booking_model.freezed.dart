// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BookingModel {

 String get id; String get customerId; String get customerName; String get customerPhone; String get customerAddress; String get customerArea; String get providerId; String get providerName; String? get assignedHandymanId; String? get assignedHandymanName; String get serviceId; String get serviceName; String get serviceCategory; String get serviceCategoryId;@TimestampConverter() DateTime get scheduledDate; String get scheduledTime; String get status; String get otp; double get amount; double get commission; double get providerEarning; double get handymanEarning; double get handymanCommissionRate; String get paymentMethod; String get paymentStatus; String? get razorpayOrderId; String? get razorpayPaymentId; String? get cancellationReason; String? get cancelledBy; String? get couponCode; double get discountAmount; String? get notes;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt;@OptionalTimestampConverter() DateTime? get completedAt; double? get rating; String? get review; bool get isRated; Map<String, dynamic>? get statusTimeline; double? get customerLat; double? get customerLng;
/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingModelCopyWith<BookingModel> get copyWith => _$BookingModelCopyWithImpl<BookingModel>(this as BookingModel, _$identity);

  /// Serializes this BookingModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.customerAddress, customerAddress) || other.customerAddress == customerAddress)&&(identical(other.customerArea, customerArea) || other.customerArea == customerArea)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.assignedHandymanId, assignedHandymanId) || other.assignedHandymanId == assignedHandymanId)&&(identical(other.assignedHandymanName, assignedHandymanName) || other.assignedHandymanName == assignedHandymanName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceCategory, serviceCategory) || other.serviceCategory == serviceCategory)&&(identical(other.serviceCategoryId, serviceCategoryId) || other.serviceCategoryId == serviceCategoryId)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.providerEarning, providerEarning) || other.providerEarning == providerEarning)&&(identical(other.handymanEarning, handymanEarning) || other.handymanEarning == handymanEarning)&&(identical(other.handymanCommissionRate, handymanCommissionRate) || other.handymanCommissionRate == handymanCommissionRate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.review, review) || other.review == review)&&(identical(other.isRated, isRated) || other.isRated == isRated)&&const DeepCollectionEquality().equals(other.statusTimeline, statusTimeline)&&(identical(other.customerLat, customerLat) || other.customerLat == customerLat)&&(identical(other.customerLng, customerLng) || other.customerLng == customerLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,customerAddress,customerArea,providerId,providerName,assignedHandymanId,assignedHandymanName,serviceId,serviceName,serviceCategory,serviceCategoryId,scheduledDate,scheduledTime,status,otp,amount,commission,providerEarning,handymanEarning,handymanCommissionRate,paymentMethod,paymentStatus,razorpayOrderId,razorpayPaymentId,cancellationReason,cancelledBy,couponCode,discountAmount,notes,createdAt,updatedAt,completedAt,rating,review,isRated,const DeepCollectionEquality().hash(statusTimeline),customerLat,customerLng]);

@override
String toString() {
  return 'BookingModel(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, customerAddress: $customerAddress, customerArea: $customerArea, providerId: $providerId, providerName: $providerName, assignedHandymanId: $assignedHandymanId, assignedHandymanName: $assignedHandymanName, serviceId: $serviceId, serviceName: $serviceName, serviceCategory: $serviceCategory, serviceCategoryId: $serviceCategoryId, scheduledDate: $scheduledDate, scheduledTime: $scheduledTime, status: $status, otp: $otp, amount: $amount, commission: $commission, providerEarning: $providerEarning, handymanEarning: $handymanEarning, handymanCommissionRate: $handymanCommissionRate, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, cancellationReason: $cancellationReason, cancelledBy: $cancelledBy, couponCode: $couponCode, discountAmount: $discountAmount, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, rating: $rating, review: $review, isRated: $isRated, statusTimeline: $statusTimeline, customerLat: $customerLat, customerLng: $customerLng)';
}


}

/// @nodoc
abstract mixin class $BookingModelCopyWith<$Res>  {
  factory $BookingModelCopyWith(BookingModel value, $Res Function(BookingModel) _then) = _$BookingModelCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String customerName, String customerPhone, String customerAddress, String customerArea, String providerId, String providerName, String? assignedHandymanId, String? assignedHandymanName, String serviceId, String serviceName, String serviceCategory, String serviceCategoryId,@TimestampConverter() DateTime scheduledDate, String scheduledTime, String status, String otp, double amount, double commission, double providerEarning, double handymanEarning, double handymanCommissionRate, String paymentMethod, String paymentStatus, String? razorpayOrderId, String? razorpayPaymentId, String? cancellationReason, String? cancelledBy, String? couponCode, double discountAmount, String? notes,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt,@OptionalTimestampConverter() DateTime? completedAt, double? rating, String? review, bool isRated, Map<String, dynamic>? statusTimeline, double? customerLat, double? customerLng
});




}
/// @nodoc
class _$BookingModelCopyWithImpl<$Res>
    implements $BookingModelCopyWith<$Res> {
  _$BookingModelCopyWithImpl(this._self, this._then);

  final BookingModel _self;
  final $Res Function(BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? customerAddress = null,Object? customerArea = null,Object? providerId = null,Object? providerName = null,Object? assignedHandymanId = freezed,Object? assignedHandymanName = freezed,Object? serviceId = null,Object? serviceName = null,Object? serviceCategory = null,Object? serviceCategoryId = null,Object? scheduledDate = null,Object? scheduledTime = null,Object? status = null,Object? otp = null,Object? amount = null,Object? commission = null,Object? providerEarning = null,Object? handymanEarning = null,Object? handymanCommissionRate = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? razorpayOrderId = freezed,Object? razorpayPaymentId = freezed,Object? cancellationReason = freezed,Object? cancelledBy = freezed,Object? couponCode = freezed,Object? discountAmount = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? rating = freezed,Object? review = freezed,Object? isRated = null,Object? statusTimeline = freezed,Object? customerLat = freezed,Object? customerLng = freezed,}) {
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
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,razorpayOrderId: freezed == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String?,razorpayPaymentId: freezed == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String?,isRated: null == isRated ? _self.isRated : isRated // ignore: cast_nullable_to_non_nullable
as bool,statusTimeline: freezed == statusTimeline ? _self.statusTimeline : statusTimeline // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,customerLat: freezed == customerLat ? _self.customerLat : customerLat // ignore: cast_nullable_to_non_nullable
as double?,customerLng: freezed == customerLng ? _self.customerLng : customerLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BookingModel].
extension BookingModelPatterns on BookingModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookingModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookingModel value)  $default,){
final _that = this;
switch (_that) {
case _BookingModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookingModel value)?  $default,){
final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String customerPhone,  String customerAddress,  String customerArea,  String providerId,  String providerName,  String? assignedHandymanId,  String? assignedHandymanName,  String serviceId,  String serviceName,  String serviceCategory,  String serviceCategoryId, @TimestampConverter()  DateTime scheduledDate,  String scheduledTime,  String status,  String otp,  double amount,  double commission,  double providerEarning,  double handymanEarning,  double handymanCommissionRate,  String paymentMethod,  String paymentStatus,  String? razorpayOrderId,  String? razorpayPaymentId,  String? cancellationReason,  String? cancelledBy,  String? couponCode,  double discountAmount,  String? notes, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @OptionalTimestampConverter()  DateTime? completedAt,  double? rating,  String? review,  bool isRated,  Map<String, dynamic>? statusTimeline,  double? customerLat,  double? customerLng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String customerPhone,  String customerAddress,  String customerArea,  String providerId,  String providerName,  String? assignedHandymanId,  String? assignedHandymanName,  String serviceId,  String serviceName,  String serviceCategory,  String serviceCategoryId, @TimestampConverter()  DateTime scheduledDate,  String scheduledTime,  String status,  String otp,  double amount,  double commission,  double providerEarning,  double handymanEarning,  double handymanCommissionRate,  String paymentMethod,  String paymentStatus,  String? razorpayOrderId,  String? razorpayPaymentId,  String? cancellationReason,  String? cancelledBy,  String? couponCode,  double discountAmount,  String? notes, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @OptionalTimestampConverter()  DateTime? completedAt,  double? rating,  String? review,  bool isRated,  Map<String, dynamic>? statusTimeline,  double? customerLat,  double? customerLng)  $default,) {final _that = this;
switch (_that) {
case _BookingModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String customerName,  String customerPhone,  String customerAddress,  String customerArea,  String providerId,  String providerName,  String? assignedHandymanId,  String? assignedHandymanName,  String serviceId,  String serviceName,  String serviceCategory,  String serviceCategoryId, @TimestampConverter()  DateTime scheduledDate,  String scheduledTime,  String status,  String otp,  double amount,  double commission,  double providerEarning,  double handymanEarning,  double handymanCommissionRate,  String paymentMethod,  String paymentStatus,  String? razorpayOrderId,  String? razorpayPaymentId,  String? cancellationReason,  String? cancelledBy,  String? couponCode,  double discountAmount,  String? notes, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt, @OptionalTimestampConverter()  DateTime? completedAt,  double? rating,  String? review,  bool isRated,  Map<String, dynamic>? statusTimeline,  double? customerLat,  double? customerLng)?  $default,) {final _that = this;
switch (_that) {
case _BookingModel() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.customerPhone,_that.customerAddress,_that.customerArea,_that.providerId,_that.providerName,_that.assignedHandymanId,_that.assignedHandymanName,_that.serviceId,_that.serviceName,_that.serviceCategory,_that.serviceCategoryId,_that.scheduledDate,_that.scheduledTime,_that.status,_that.otp,_that.amount,_that.commission,_that.providerEarning,_that.handymanEarning,_that.handymanCommissionRate,_that.paymentMethod,_that.paymentStatus,_that.razorpayOrderId,_that.razorpayPaymentId,_that.cancellationReason,_that.cancelledBy,_that.couponCode,_that.discountAmount,_that.notes,_that.createdAt,_that.updatedAt,_that.completedAt,_that.rating,_that.review,_that.isRated,_that.statusTimeline,_that.customerLat,_that.customerLng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookingModel extends BookingModel {
  const _BookingModel({required this.id, required this.customerId, required this.customerName, required this.customerPhone, required this.customerAddress, required this.customerArea, required this.providerId, required this.providerName, this.assignedHandymanId, this.assignedHandymanName, required this.serviceId, required this.serviceName, required this.serviceCategory, required this.serviceCategoryId, @TimestampConverter() required this.scheduledDate, required this.scheduledTime, required this.status, required this.otp, required this.amount, required this.commission, required this.providerEarning, this.handymanEarning = 0.0, this.handymanCommissionRate = 0.0, required this.paymentMethod, required this.paymentStatus, this.razorpayOrderId, this.razorpayPaymentId, this.cancellationReason, this.cancelledBy, this.couponCode, required this.discountAmount, this.notes, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, @OptionalTimestampConverter() this.completedAt, this.rating, this.review, this.isRated = false, final  Map<String, dynamic>? statusTimeline, this.customerLat, this.customerLng}): _statusTimeline = statusTimeline,super._();
  factory _BookingModel.fromJson(Map<String, dynamic> json) => _$BookingModelFromJson(json);

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
@override@TimestampConverter() final  DateTime scheduledDate;
@override final  String scheduledTime;
@override final  String status;
@override final  String otp;
@override final  double amount;
@override final  double commission;
@override final  double providerEarning;
@override@JsonKey() final  double handymanEarning;
@override@JsonKey() final  double handymanCommissionRate;
@override final  String paymentMethod;
@override final  String paymentStatus;
@override final  String? razorpayOrderId;
@override final  String? razorpayPaymentId;
@override final  String? cancellationReason;
@override final  String? cancelledBy;
@override final  String? couponCode;
@override final  double discountAmount;
@override final  String? notes;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override@OptionalTimestampConverter() final  DateTime? completedAt;
@override final  double? rating;
@override final  String? review;
@override@JsonKey() final  bool isRated;
 final  Map<String, dynamic>? _statusTimeline;
@override Map<String, dynamic>? get statusTimeline {
  final value = _statusTimeline;
  if (value == null) return null;
  if (_statusTimeline is EqualUnmodifiableMapView) return _statusTimeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  double? customerLat;
@override final  double? customerLng;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingModelCopyWith<_BookingModel> get copyWith => __$BookingModelCopyWithImpl<_BookingModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookingModel&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.customerAddress, customerAddress) || other.customerAddress == customerAddress)&&(identical(other.customerArea, customerArea) || other.customerArea == customerArea)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.providerName, providerName) || other.providerName == providerName)&&(identical(other.assignedHandymanId, assignedHandymanId) || other.assignedHandymanId == assignedHandymanId)&&(identical(other.assignedHandymanName, assignedHandymanName) || other.assignedHandymanName == assignedHandymanName)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.serviceCategory, serviceCategory) || other.serviceCategory == serviceCategory)&&(identical(other.serviceCategoryId, serviceCategoryId) || other.serviceCategoryId == serviceCategoryId)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate)&&(identical(other.scheduledTime, scheduledTime) || other.scheduledTime == scheduledTime)&&(identical(other.status, status) || other.status == status)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.providerEarning, providerEarning) || other.providerEarning == providerEarning)&&(identical(other.handymanEarning, handymanEarning) || other.handymanEarning == handymanEarning)&&(identical(other.handymanCommissionRate, handymanCommissionRate) || other.handymanCommissionRate == handymanCommissionRate)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.razorpayOrderId, razorpayOrderId) || other.razorpayOrderId == razorpayOrderId)&&(identical(other.razorpayPaymentId, razorpayPaymentId) || other.razorpayPaymentId == razorpayPaymentId)&&(identical(other.cancellationReason, cancellationReason) || other.cancellationReason == cancellationReason)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.couponCode, couponCode) || other.couponCode == couponCode)&&(identical(other.discountAmount, discountAmount) || other.discountAmount == discountAmount)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.review, review) || other.review == review)&&(identical(other.isRated, isRated) || other.isRated == isRated)&&const DeepCollectionEquality().equals(other._statusTimeline, _statusTimeline)&&(identical(other.customerLat, customerLat) || other.customerLat == customerLat)&&(identical(other.customerLng, customerLng) || other.customerLng == customerLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,customerPhone,customerAddress,customerArea,providerId,providerName,assignedHandymanId,assignedHandymanName,serviceId,serviceName,serviceCategory,serviceCategoryId,scheduledDate,scheduledTime,status,otp,amount,commission,providerEarning,handymanEarning,handymanCommissionRate,paymentMethod,paymentStatus,razorpayOrderId,razorpayPaymentId,cancellationReason,cancelledBy,couponCode,discountAmount,notes,createdAt,updatedAt,completedAt,rating,review,isRated,const DeepCollectionEquality().hash(_statusTimeline),customerLat,customerLng]);

@override
String toString() {
  return 'BookingModel(id: $id, customerId: $customerId, customerName: $customerName, customerPhone: $customerPhone, customerAddress: $customerAddress, customerArea: $customerArea, providerId: $providerId, providerName: $providerName, assignedHandymanId: $assignedHandymanId, assignedHandymanName: $assignedHandymanName, serviceId: $serviceId, serviceName: $serviceName, serviceCategory: $serviceCategory, serviceCategoryId: $serviceCategoryId, scheduledDate: $scheduledDate, scheduledTime: $scheduledTime, status: $status, otp: $otp, amount: $amount, commission: $commission, providerEarning: $providerEarning, handymanEarning: $handymanEarning, handymanCommissionRate: $handymanCommissionRate, paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, razorpayOrderId: $razorpayOrderId, razorpayPaymentId: $razorpayPaymentId, cancellationReason: $cancellationReason, cancelledBy: $cancelledBy, couponCode: $couponCode, discountAmount: $discountAmount, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, rating: $rating, review: $review, isRated: $isRated, statusTimeline: $statusTimeline, customerLat: $customerLat, customerLng: $customerLng)';
}


}

/// @nodoc
abstract mixin class _$BookingModelCopyWith<$Res> implements $BookingModelCopyWith<$Res> {
  factory _$BookingModelCopyWith(_BookingModel value, $Res Function(_BookingModel) _then) = __$BookingModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String customerName, String customerPhone, String customerAddress, String customerArea, String providerId, String providerName, String? assignedHandymanId, String? assignedHandymanName, String serviceId, String serviceName, String serviceCategory, String serviceCategoryId,@TimestampConverter() DateTime scheduledDate, String scheduledTime, String status, String otp, double amount, double commission, double providerEarning, double handymanEarning, double handymanCommissionRate, String paymentMethod, String paymentStatus, String? razorpayOrderId, String? razorpayPaymentId, String? cancellationReason, String? cancelledBy, String? couponCode, double discountAmount, String? notes,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt,@OptionalTimestampConverter() DateTime? completedAt, double? rating, String? review, bool isRated, Map<String, dynamic>? statusTimeline, double? customerLat, double? customerLng
});




}
/// @nodoc
class __$BookingModelCopyWithImpl<$Res>
    implements _$BookingModelCopyWith<$Res> {
  __$BookingModelCopyWithImpl(this._self, this._then);

  final _BookingModel _self;
  final $Res Function(_BookingModel) _then;

/// Create a copy of BookingModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? customerPhone = null,Object? customerAddress = null,Object? customerArea = null,Object? providerId = null,Object? providerName = null,Object? assignedHandymanId = freezed,Object? assignedHandymanName = freezed,Object? serviceId = null,Object? serviceName = null,Object? serviceCategory = null,Object? serviceCategoryId = null,Object? scheduledDate = null,Object? scheduledTime = null,Object? status = null,Object? otp = null,Object? amount = null,Object? commission = null,Object? providerEarning = null,Object? handymanEarning = null,Object? handymanCommissionRate = null,Object? paymentMethod = null,Object? paymentStatus = null,Object? razorpayOrderId = freezed,Object? razorpayPaymentId = freezed,Object? cancellationReason = freezed,Object? cancelledBy = freezed,Object? couponCode = freezed,Object? discountAmount = null,Object? notes = freezed,Object? createdAt = null,Object? updatedAt = null,Object? completedAt = freezed,Object? rating = freezed,Object? review = freezed,Object? isRated = null,Object? statusTimeline = freezed,Object? customerLat = freezed,Object? customerLng = freezed,}) {
  return _then(_BookingModel(
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
as String,paymentStatus: null == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String,razorpayOrderId: freezed == razorpayOrderId ? _self.razorpayOrderId : razorpayOrderId // ignore: cast_nullable_to_non_nullable
as String?,razorpayPaymentId: freezed == razorpayPaymentId ? _self.razorpayPaymentId : razorpayPaymentId // ignore: cast_nullable_to_non_nullable
as String?,cancellationReason: freezed == cancellationReason ? _self.cancellationReason : cancellationReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,couponCode: freezed == couponCode ? _self.couponCode : couponCode // ignore: cast_nullable_to_non_nullable
as String?,discountAmount: null == discountAmount ? _self.discountAmount : discountAmount // ignore: cast_nullable_to_non_nullable
as double,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as String?,isRated: null == isRated ? _self.isRated : isRated // ignore: cast_nullable_to_non_nullable
as bool,statusTimeline: freezed == statusTimeline ? _self._statusTimeline : statusTimeline // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,customerLat: freezed == customerLat ? _self.customerLat : customerLat // ignore: cast_nullable_to_non_nullable
as double?,customerLng: freezed == customerLng ? _self.customerLng : customerLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$CouponModel {

 String get code; double get discount; String get type; double get minOrder;@TimestampConverter() DateTime get expiresAt; double? get maxDiscount; bool? get isActive;
/// Create a copy of CouponModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponModelCopyWith<CouponModel> get copyWith => _$CouponModelCopyWithImpl<CouponModel>(this as CouponModel, _$identity);

  /// Serializes this CouponModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CouponModel&&(identical(other.code, code) || other.code == code)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.type, type) || other.type == type)&&(identical(other.minOrder, minOrder) || other.minOrder == minOrder)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,discount,type,minOrder,expiresAt,maxDiscount,isActive);

@override
String toString() {
  return 'CouponModel(code: $code, discount: $discount, type: $type, minOrder: $minOrder, expiresAt: $expiresAt, maxDiscount: $maxDiscount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CouponModelCopyWith<$Res>  {
  factory $CouponModelCopyWith(CouponModel value, $Res Function(CouponModel) _then) = _$CouponModelCopyWithImpl;
@useResult
$Res call({
 String code, double discount, String type, double minOrder,@TimestampConverter() DateTime expiresAt, double? maxDiscount, bool? isActive
});




}
/// @nodoc
class _$CouponModelCopyWithImpl<$Res>
    implements $CouponModelCopyWith<$Res> {
  _$CouponModelCopyWithImpl(this._self, this._then);

  final CouponModel _self;
  final $Res Function(CouponModel) _then;

/// Create a copy of CouponModel
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


/// Adds pattern-matching-related methods to [CouponModel].
extension CouponModelPatterns on CouponModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CouponModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CouponModel value)  $default,){
final _that = this;
switch (_that) {
case _CouponModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CouponModel value)?  $default,){
final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  double discount,  String type,  double minOrder, @TimestampConverter()  DateTime expiresAt,  double? maxDiscount,  bool? isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  double discount,  String type,  double minOrder, @TimestampConverter()  DateTime expiresAt,  double? maxDiscount,  bool? isActive)  $default,) {final _that = this;
switch (_that) {
case _CouponModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  double discount,  String type,  double minOrder, @TimestampConverter()  DateTime expiresAt,  double? maxDiscount,  bool? isActive)?  $default,) {final _that = this;
switch (_that) {
case _CouponModel() when $default != null:
return $default(_that.code,_that.discount,_that.type,_that.minOrder,_that.expiresAt,_that.maxDiscount,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CouponModel extends CouponModel {
  const _CouponModel({required this.code, required this.discount, required this.type, required this.minOrder, @TimestampConverter() required this.expiresAt, this.maxDiscount, this.isActive}): super._();
  factory _CouponModel.fromJson(Map<String, dynamic> json) => _$CouponModelFromJson(json);

@override final  String code;
@override final  double discount;
@override final  String type;
@override final  double minOrder;
@override@TimestampConverter() final  DateTime expiresAt;
@override final  double? maxDiscount;
@override final  bool? isActive;

/// Create a copy of CouponModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponModelCopyWith<_CouponModel> get copyWith => __$CouponModelCopyWithImpl<_CouponModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CouponModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CouponModel&&(identical(other.code, code) || other.code == code)&&(identical(other.discount, discount) || other.discount == discount)&&(identical(other.type, type) || other.type == type)&&(identical(other.minOrder, minOrder) || other.minOrder == minOrder)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxDiscount, maxDiscount) || other.maxDiscount == maxDiscount)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,discount,type,minOrder,expiresAt,maxDiscount,isActive);

@override
String toString() {
  return 'CouponModel(code: $code, discount: $discount, type: $type, minOrder: $minOrder, expiresAt: $expiresAt, maxDiscount: $maxDiscount, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CouponModelCopyWith<$Res> implements $CouponModelCopyWith<$Res> {
  factory _$CouponModelCopyWith(_CouponModel value, $Res Function(_CouponModel) _then) = __$CouponModelCopyWithImpl;
@override @useResult
$Res call({
 String code, double discount, String type, double minOrder,@TimestampConverter() DateTime expiresAt, double? maxDiscount, bool? isActive
});




}
/// @nodoc
class __$CouponModelCopyWithImpl<$Res>
    implements _$CouponModelCopyWith<$Res> {
  __$CouponModelCopyWithImpl(this._self, this._then);

  final _CouponModel _self;
  final $Res Function(_CouponModel) _then;

/// Create a copy of CouponModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? discount = null,Object? type = null,Object? minOrder = null,Object? expiresAt = null,Object? maxDiscount = freezed,Object? isActive = freezed,}) {
  return _then(_CouponModel(
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
