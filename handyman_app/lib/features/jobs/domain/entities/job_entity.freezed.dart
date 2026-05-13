// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobEntity {

 String get id; String get customerId; String get customerName; String get serviceName; String get address; String get area; DateTime get scheduledAt; double get amount; double get handymanEarning; double get handymanCommissionRate; JobStatus get status; String get otp; String get paymentMethod;// 'cash' | 'online'
 double? get customerLat; double? get customerLng; String? get notes; String? get beforePhotoUrl; String? get afterPhotoUrl; double? get additionalCharges; String? get additionalNotes; DateTime? get completedAt;
/// Create a copy of JobEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobEntityCopyWith<JobEntity> get copyWith => _$JobEntityCopyWithImpl<JobEntity>(this as JobEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.address, address) || other.address == address)&&(identical(other.area, area) || other.area == area)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.handymanEarning, handymanEarning) || other.handymanEarning == handymanEarning)&&(identical(other.handymanCommissionRate, handymanCommissionRate) || other.handymanCommissionRate == handymanCommissionRate)&&(identical(other.status, status) || other.status == status)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.customerLat, customerLat) || other.customerLat == customerLat)&&(identical(other.customerLng, customerLng) || other.customerLng == customerLng)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.beforePhotoUrl, beforePhotoUrl) || other.beforePhotoUrl == beforePhotoUrl)&&(identical(other.afterPhotoUrl, afterPhotoUrl) || other.afterPhotoUrl == afterPhotoUrl)&&(identical(other.additionalCharges, additionalCharges) || other.additionalCharges == additionalCharges)&&(identical(other.additionalNotes, additionalNotes) || other.additionalNotes == additionalNotes)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,serviceName,address,area,scheduledAt,amount,handymanEarning,handymanCommissionRate,status,otp,paymentMethod,customerLat,customerLng,notes,beforePhotoUrl,afterPhotoUrl,additionalCharges,additionalNotes,completedAt]);

@override
String toString() {
  return 'JobEntity(id: $id, customerId: $customerId, customerName: $customerName, serviceName: $serviceName, address: $address, area: $area, scheduledAt: $scheduledAt, amount: $amount, handymanEarning: $handymanEarning, handymanCommissionRate: $handymanCommissionRate, status: $status, otp: $otp, paymentMethod: $paymentMethod, customerLat: $customerLat, customerLng: $customerLng, notes: $notes, beforePhotoUrl: $beforePhotoUrl, afterPhotoUrl: $afterPhotoUrl, additionalCharges: $additionalCharges, additionalNotes: $additionalNotes, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $JobEntityCopyWith<$Res>  {
  factory $JobEntityCopyWith(JobEntity value, $Res Function(JobEntity) _then) = _$JobEntityCopyWithImpl;
@useResult
$Res call({
 String id, String customerId, String customerName, String serviceName, String address, String area, DateTime scheduledAt, double amount, double handymanEarning, double handymanCommissionRate, JobStatus status, String otp, String paymentMethod, double? customerLat, double? customerLng, String? notes, String? beforePhotoUrl, String? afterPhotoUrl, double? additionalCharges, String? additionalNotes, DateTime? completedAt
});




}
/// @nodoc
class _$JobEntityCopyWithImpl<$Res>
    implements $JobEntityCopyWith<$Res> {
  _$JobEntityCopyWithImpl(this._self, this._then);

  final JobEntity _self;
  final $Res Function(JobEntity) _then;

/// Create a copy of JobEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? serviceName = null,Object? address = null,Object? area = null,Object? scheduledAt = null,Object? amount = null,Object? handymanEarning = null,Object? handymanCommissionRate = null,Object? status = null,Object? otp = null,Object? paymentMethod = null,Object? customerLat = freezed,Object? customerLng = freezed,Object? notes = freezed,Object? beforePhotoUrl = freezed,Object? afterPhotoUrl = freezed,Object? additionalCharges = freezed,Object? additionalNotes = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,handymanEarning: null == handymanEarning ? _self.handymanEarning : handymanEarning // ignore: cast_nullable_to_non_nullable
as double,handymanCommissionRate: null == handymanCommissionRate ? _self.handymanCommissionRate : handymanCommissionRate // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,customerLat: freezed == customerLat ? _self.customerLat : customerLat // ignore: cast_nullable_to_non_nullable
as double?,customerLng: freezed == customerLng ? _self.customerLng : customerLng // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,beforePhotoUrl: freezed == beforePhotoUrl ? _self.beforePhotoUrl : beforePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,afterPhotoUrl: freezed == afterPhotoUrl ? _self.afterPhotoUrl : afterPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,additionalCharges: freezed == additionalCharges ? _self.additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as double?,additionalNotes: freezed == additionalNotes ? _self.additionalNotes : additionalNotes // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobEntity].
extension JobEntityPatterns on JobEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobEntity value)  $default,){
final _that = this;
switch (_that) {
case _JobEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobEntity value)?  $default,){
final _that = this;
switch (_that) {
case _JobEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String serviceName,  String address,  String area,  DateTime scheduledAt,  double amount,  double handymanEarning,  double handymanCommissionRate,  JobStatus status,  String otp,  String paymentMethod,  double? customerLat,  double? customerLng,  String? notes,  String? beforePhotoUrl,  String? afterPhotoUrl,  double? additionalCharges,  String? additionalNotes,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobEntity() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.serviceName,_that.address,_that.area,_that.scheduledAt,_that.amount,_that.handymanEarning,_that.handymanCommissionRate,_that.status,_that.otp,_that.paymentMethod,_that.customerLat,_that.customerLng,_that.notes,_that.beforePhotoUrl,_that.afterPhotoUrl,_that.additionalCharges,_that.additionalNotes,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String customerId,  String customerName,  String serviceName,  String address,  String area,  DateTime scheduledAt,  double amount,  double handymanEarning,  double handymanCommissionRate,  JobStatus status,  String otp,  String paymentMethod,  double? customerLat,  double? customerLng,  String? notes,  String? beforePhotoUrl,  String? afterPhotoUrl,  double? additionalCharges,  String? additionalNotes,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _JobEntity():
return $default(_that.id,_that.customerId,_that.customerName,_that.serviceName,_that.address,_that.area,_that.scheduledAt,_that.amount,_that.handymanEarning,_that.handymanCommissionRate,_that.status,_that.otp,_that.paymentMethod,_that.customerLat,_that.customerLng,_that.notes,_that.beforePhotoUrl,_that.afterPhotoUrl,_that.additionalCharges,_that.additionalNotes,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String customerId,  String customerName,  String serviceName,  String address,  String area,  DateTime scheduledAt,  double amount,  double handymanEarning,  double handymanCommissionRate,  JobStatus status,  String otp,  String paymentMethod,  double? customerLat,  double? customerLng,  String? notes,  String? beforePhotoUrl,  String? afterPhotoUrl,  double? additionalCharges,  String? additionalNotes,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _JobEntity() when $default != null:
return $default(_that.id,_that.customerId,_that.customerName,_that.serviceName,_that.address,_that.area,_that.scheduledAt,_that.amount,_that.handymanEarning,_that.handymanCommissionRate,_that.status,_that.otp,_that.paymentMethod,_that.customerLat,_that.customerLng,_that.notes,_that.beforePhotoUrl,_that.afterPhotoUrl,_that.additionalCharges,_that.additionalNotes,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc


class _JobEntity extends JobEntity {
  const _JobEntity({required this.id, required this.customerId, required this.customerName, required this.serviceName, required this.address, required this.area, required this.scheduledAt, required this.amount, this.handymanEarning = 0.0, this.handymanCommissionRate = 0.0, required this.status, required this.otp, required this.paymentMethod, this.customerLat, this.customerLng, this.notes, this.beforePhotoUrl, this.afterPhotoUrl, this.additionalCharges, this.additionalNotes, this.completedAt}): super._();
  

@override final  String id;
@override final  String customerId;
@override final  String customerName;
@override final  String serviceName;
@override final  String address;
@override final  String area;
@override final  DateTime scheduledAt;
@override final  double amount;
@override@JsonKey() final  double handymanEarning;
@override@JsonKey() final  double handymanCommissionRate;
@override final  JobStatus status;
@override final  String otp;
@override final  String paymentMethod;
// 'cash' | 'online'
@override final  double? customerLat;
@override final  double? customerLng;
@override final  String? notes;
@override final  String? beforePhotoUrl;
@override final  String? afterPhotoUrl;
@override final  double? additionalCharges;
@override final  String? additionalNotes;
@override final  DateTime? completedAt;

/// Create a copy of JobEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobEntityCopyWith<_JobEntity> get copyWith => __$JobEntityCopyWithImpl<_JobEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.serviceName, serviceName) || other.serviceName == serviceName)&&(identical(other.address, address) || other.address == address)&&(identical(other.area, area) || other.area == area)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.handymanEarning, handymanEarning) || other.handymanEarning == handymanEarning)&&(identical(other.handymanCommissionRate, handymanCommissionRate) || other.handymanCommissionRate == handymanCommissionRate)&&(identical(other.status, status) || other.status == status)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.customerLat, customerLat) || other.customerLat == customerLat)&&(identical(other.customerLng, customerLng) || other.customerLng == customerLng)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.beforePhotoUrl, beforePhotoUrl) || other.beforePhotoUrl == beforePhotoUrl)&&(identical(other.afterPhotoUrl, afterPhotoUrl) || other.afterPhotoUrl == afterPhotoUrl)&&(identical(other.additionalCharges, additionalCharges) || other.additionalCharges == additionalCharges)&&(identical(other.additionalNotes, additionalNotes) || other.additionalNotes == additionalNotes)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,customerId,customerName,serviceName,address,area,scheduledAt,amount,handymanEarning,handymanCommissionRate,status,otp,paymentMethod,customerLat,customerLng,notes,beforePhotoUrl,afterPhotoUrl,additionalCharges,additionalNotes,completedAt]);

@override
String toString() {
  return 'JobEntity(id: $id, customerId: $customerId, customerName: $customerName, serviceName: $serviceName, address: $address, area: $area, scheduledAt: $scheduledAt, amount: $amount, handymanEarning: $handymanEarning, handymanCommissionRate: $handymanCommissionRate, status: $status, otp: $otp, paymentMethod: $paymentMethod, customerLat: $customerLat, customerLng: $customerLng, notes: $notes, beforePhotoUrl: $beforePhotoUrl, afterPhotoUrl: $afterPhotoUrl, additionalCharges: $additionalCharges, additionalNotes: $additionalNotes, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$JobEntityCopyWith<$Res> implements $JobEntityCopyWith<$Res> {
  factory _$JobEntityCopyWith(_JobEntity value, $Res Function(_JobEntity) _then) = __$JobEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String customerId, String customerName, String serviceName, String address, String area, DateTime scheduledAt, double amount, double handymanEarning, double handymanCommissionRate, JobStatus status, String otp, String paymentMethod, double? customerLat, double? customerLng, String? notes, String? beforePhotoUrl, String? afterPhotoUrl, double? additionalCharges, String? additionalNotes, DateTime? completedAt
});




}
/// @nodoc
class __$JobEntityCopyWithImpl<$Res>
    implements _$JobEntityCopyWith<$Res> {
  __$JobEntityCopyWithImpl(this._self, this._then);

  final _JobEntity _self;
  final $Res Function(_JobEntity) _then;

/// Create a copy of JobEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? customerId = null,Object? customerName = null,Object? serviceName = null,Object? address = null,Object? area = null,Object? scheduledAt = null,Object? amount = null,Object? handymanEarning = null,Object? handymanCommissionRate = null,Object? status = null,Object? otp = null,Object? paymentMethod = null,Object? customerLat = freezed,Object? customerLng = freezed,Object? notes = freezed,Object? beforePhotoUrl = freezed,Object? afterPhotoUrl = freezed,Object? additionalCharges = freezed,Object? additionalNotes = freezed,Object? completedAt = freezed,}) {
  return _then(_JobEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,serviceName: null == serviceName ? _self.serviceName : serviceName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,handymanEarning: null == handymanEarning ? _self.handymanEarning : handymanEarning // ignore: cast_nullable_to_non_nullable
as double,handymanCommissionRate: null == handymanCommissionRate ? _self.handymanCommissionRate : handymanCommissionRate // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,customerLat: freezed == customerLat ? _self.customerLat : customerLat // ignore: cast_nullable_to_non_nullable
as double?,customerLng: freezed == customerLng ? _self.customerLng : customerLng // ignore: cast_nullable_to_non_nullable
as double?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,beforePhotoUrl: freezed == beforePhotoUrl ? _self.beforePhotoUrl : beforePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,afterPhotoUrl: freezed == afterPhotoUrl ? _self.afterPhotoUrl : afterPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,additionalCharges: freezed == additionalCharges ? _self.additionalCharges : additionalCharges // ignore: cast_nullable_to_non_nullable
as double?,additionalNotes: freezed == additionalNotes ? _self.additionalNotes : additionalNotes // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
