// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEntity {

 String get uid; UserRole? get role; String? get fullName; String? get phone; String? get email; String? get photoUrl; bool? get isProfileComplete; bool? get isBlocked; bool? get isDeleted; String? get defaultAddressId; String? get fcmToken; String? get authProvider;// 'phone' | 'google'
 DateTime? get createdAt; DateTime? get updatedAt; DateTime? get lastLoginAt; String? get walletId; String? get referralCode;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isProfileComplete, isProfileComplete) || other.isProfileComplete == isProfileComplete)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.defaultAddressId, defaultAddressId) || other.defaultAddressId == defaultAddressId)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode));
}


@override
int get hashCode => Object.hash(runtimeType,uid,role,fullName,phone,email,photoUrl,isProfileComplete,isBlocked,isDeleted,defaultAddressId,fcmToken,authProvider,createdAt,updatedAt,lastLoginAt,walletId,referralCode);

@override
String toString() {
  return 'UserEntity(uid: $uid, role: $role, fullName: $fullName, phone: $phone, email: $email, photoUrl: $photoUrl, isProfileComplete: $isProfileComplete, isBlocked: $isBlocked, isDeleted: $isDeleted, defaultAddressId: $defaultAddressId, fcmToken: $fcmToken, authProvider: $authProvider, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt, walletId: $walletId, referralCode: $referralCode)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 String uid, UserRole? role, String? fullName, String? phone, String? email, String? photoUrl, bool? isProfileComplete, bool? isBlocked, bool? isDeleted, String? defaultAddressId, String? fcmToken, String? authProvider, DateTime? createdAt, DateTime? updatedAt, DateTime? lastLoginAt, String? walletId, String? referralCode
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? role = freezed,Object? fullName = freezed,Object? phone = freezed,Object? email = freezed,Object? photoUrl = freezed,Object? isProfileComplete = freezed,Object? isBlocked = freezed,Object? isDeleted = freezed,Object? defaultAddressId = freezed,Object? fcmToken = freezed,Object? authProvider = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? lastLoginAt = freezed,Object? walletId = freezed,Object? referralCode = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isProfileComplete: freezed == isProfileComplete ? _self.isProfileComplete : isProfileComplete // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,defaultAddressId: freezed == defaultAddressId ? _self.defaultAddressId : defaultAddressId // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,authProvider: freezed == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  UserRole? role,  String? fullName,  String? phone,  String? email,  String? photoUrl,  bool? isProfileComplete,  bool? isBlocked,  bool? isDeleted,  String? defaultAddressId,  String? fcmToken,  String? authProvider,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? lastLoginAt,  String? walletId,  String? referralCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.uid,_that.role,_that.fullName,_that.phone,_that.email,_that.photoUrl,_that.isProfileComplete,_that.isBlocked,_that.isDeleted,_that.defaultAddressId,_that.fcmToken,_that.authProvider,_that.createdAt,_that.updatedAt,_that.lastLoginAt,_that.walletId,_that.referralCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  UserRole? role,  String? fullName,  String? phone,  String? email,  String? photoUrl,  bool? isProfileComplete,  bool? isBlocked,  bool? isDeleted,  String? defaultAddressId,  String? fcmToken,  String? authProvider,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? lastLoginAt,  String? walletId,  String? referralCode)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.uid,_that.role,_that.fullName,_that.phone,_that.email,_that.photoUrl,_that.isProfileComplete,_that.isBlocked,_that.isDeleted,_that.defaultAddressId,_that.fcmToken,_that.authProvider,_that.createdAt,_that.updatedAt,_that.lastLoginAt,_that.walletId,_that.referralCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  UserRole? role,  String? fullName,  String? phone,  String? email,  String? photoUrl,  bool? isProfileComplete,  bool? isBlocked,  bool? isDeleted,  String? defaultAddressId,  String? fcmToken,  String? authProvider,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? lastLoginAt,  String? walletId,  String? referralCode)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.uid,_that.role,_that.fullName,_that.phone,_that.email,_that.photoUrl,_that.isProfileComplete,_that.isBlocked,_that.isDeleted,_that.defaultAddressId,_that.fcmToken,_that.authProvider,_that.createdAt,_that.updatedAt,_that.lastLoginAt,_that.walletId,_that.referralCode);case _:
  return null;

}
}

}

/// @nodoc


class _UserEntity extends UserEntity {
  const _UserEntity({required this.uid, this.role, this.fullName, this.phone, this.email, this.photoUrl, this.isProfileComplete, this.isBlocked, this.isDeleted, this.defaultAddressId, this.fcmToken, this.authProvider, this.createdAt, this.updatedAt, this.lastLoginAt, this.walletId, this.referralCode}): super._();
  

@override final  String uid;
@override final  UserRole? role;
@override final  String? fullName;
@override final  String? phone;
@override final  String? email;
@override final  String? photoUrl;
@override final  bool? isProfileComplete;
@override final  bool? isBlocked;
@override final  bool? isDeleted;
@override final  String? defaultAddressId;
@override final  String? fcmToken;
@override final  String? authProvider;
// 'phone' | 'google'
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? lastLoginAt;
@override final  String? walletId;
@override final  String? referralCode;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isProfileComplete, isProfileComplete) || other.isProfileComplete == isProfileComplete)&&(identical(other.isBlocked, isBlocked) || other.isBlocked == isBlocked)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.defaultAddressId, defaultAddressId) || other.defaultAddressId == defaultAddressId)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode));
}


@override
int get hashCode => Object.hash(runtimeType,uid,role,fullName,phone,email,photoUrl,isProfileComplete,isBlocked,isDeleted,defaultAddressId,fcmToken,authProvider,createdAt,updatedAt,lastLoginAt,walletId,referralCode);

@override
String toString() {
  return 'UserEntity(uid: $uid, role: $role, fullName: $fullName, phone: $phone, email: $email, photoUrl: $photoUrl, isProfileComplete: $isProfileComplete, isBlocked: $isBlocked, isDeleted: $isDeleted, defaultAddressId: $defaultAddressId, fcmToken: $fcmToken, authProvider: $authProvider, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt, walletId: $walletId, referralCode: $referralCode)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 String uid, UserRole? role, String? fullName, String? phone, String? email, String? photoUrl, bool? isProfileComplete, bool? isBlocked, bool? isDeleted, String? defaultAddressId, String? fcmToken, String? authProvider, DateTime? createdAt, DateTime? updatedAt, DateTime? lastLoginAt, String? walletId, String? referralCode
});




}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? role = freezed,Object? fullName = freezed,Object? phone = freezed,Object? email = freezed,Object? photoUrl = freezed,Object? isProfileComplete = freezed,Object? isBlocked = freezed,Object? isDeleted = freezed,Object? defaultAddressId = freezed,Object? fcmToken = freezed,Object? authProvider = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? lastLoginAt = freezed,Object? walletId = freezed,Object? referralCode = freezed,}) {
  return _then(_UserEntity(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isProfileComplete: freezed == isProfileComplete ? _self.isProfileComplete : isProfileComplete // ignore: cast_nullable_to_non_nullable
as bool?,isBlocked: freezed == isBlocked ? _self.isBlocked : isBlocked // ignore: cast_nullable_to_non_nullable
as bool?,isDeleted: freezed == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool?,defaultAddressId: freezed == defaultAddressId ? _self.defaultAddressId : defaultAddressId // ignore: cast_nullable_to_non_nullable
as String?,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,authProvider: freezed == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$AddressEntity {

 String? get id; String? get label;// 'Home' | 'Work' | 'Other'
 String? get fullAddress; String? get area; String? get city; String? get state; double? get lat; double? get lng; String? get pincode; bool? get isDefault; DateTime? get createdAt;
/// Create a copy of AddressEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressEntityCopyWith<AddressEntity> get copyWith => _$AddressEntityCopyWithImpl<AddressEntity>(this as AddressEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.fullAddress, fullAddress) || other.fullAddress == fullAddress)&&(identical(other.area, area) || other.area == area)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,fullAddress,area,city,state,lat,lng,pincode,isDefault,createdAt);

@override
String toString() {
  return 'AddressEntity(id: $id, label: $label, fullAddress: $fullAddress, area: $area, city: $city, state: $state, lat: $lat, lng: $lng, pincode: $pincode, isDefault: $isDefault, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AddressEntityCopyWith<$Res>  {
  factory $AddressEntityCopyWith(AddressEntity value, $Res Function(AddressEntity) _then) = _$AddressEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String? label, String? fullAddress, String? area, String? city, String? state, double? lat, double? lng, String? pincode, bool? isDefault, DateTime? createdAt
});




}
/// @nodoc
class _$AddressEntityCopyWithImpl<$Res>
    implements $AddressEntityCopyWith<$Res> {
  _$AddressEntityCopyWithImpl(this._self, this._then);

  final AddressEntity _self;
  final $Res Function(AddressEntity) _then;

/// Create a copy of AddressEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? label = freezed,Object? fullAddress = freezed,Object? area = freezed,Object? city = freezed,Object? state = freezed,Object? lat = freezed,Object? lng = freezed,Object? pincode = freezed,Object? isDefault = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,fullAddress: freezed == fullAddress ? _self.fullAddress : fullAddress // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressEntity].
extension AddressEntityPatterns on AddressEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressEntity value)  $default,){
final _that = this;
switch (_that) {
case _AddressEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressEntity value)?  $default,){
final _that = this;
switch (_that) {
case _AddressEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? label,  String? fullAddress,  String? area,  String? city,  String? state,  double? lat,  double? lng,  String? pincode,  bool? isDefault,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressEntity() when $default != null:
return $default(_that.id,_that.label,_that.fullAddress,_that.area,_that.city,_that.state,_that.lat,_that.lng,_that.pincode,_that.isDefault,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? label,  String? fullAddress,  String? area,  String? city,  String? state,  double? lat,  double? lng,  String? pincode,  bool? isDefault,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _AddressEntity():
return $default(_that.id,_that.label,_that.fullAddress,_that.area,_that.city,_that.state,_that.lat,_that.lng,_that.pincode,_that.isDefault,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? label,  String? fullAddress,  String? area,  String? city,  String? state,  double? lat,  double? lng,  String? pincode,  bool? isDefault,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AddressEntity() when $default != null:
return $default(_that.id,_that.label,_that.fullAddress,_that.area,_that.city,_that.state,_that.lat,_that.lng,_that.pincode,_that.isDefault,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _AddressEntity extends AddressEntity {
  const _AddressEntity({this.id, this.label, this.fullAddress, this.area, this.city, this.state, this.lat, this.lng, this.pincode, this.isDefault, this.createdAt}): super._();
  

@override final  String? id;
@override final  String? label;
// 'Home' | 'Work' | 'Other'
@override final  String? fullAddress;
@override final  String? area;
@override final  String? city;
@override final  String? state;
@override final  double? lat;
@override final  double? lng;
@override final  String? pincode;
@override final  bool? isDefault;
@override final  DateTime? createdAt;

/// Create a copy of AddressEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressEntityCopyWith<_AddressEntity> get copyWith => __$AddressEntityCopyWithImpl<_AddressEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.fullAddress, fullAddress) || other.fullAddress == fullAddress)&&(identical(other.area, area) || other.area == area)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.pincode, pincode) || other.pincode == pincode)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,label,fullAddress,area,city,state,lat,lng,pincode,isDefault,createdAt);

@override
String toString() {
  return 'AddressEntity(id: $id, label: $label, fullAddress: $fullAddress, area: $area, city: $city, state: $state, lat: $lat, lng: $lng, pincode: $pincode, isDefault: $isDefault, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AddressEntityCopyWith<$Res> implements $AddressEntityCopyWith<$Res> {
  factory _$AddressEntityCopyWith(_AddressEntity value, $Res Function(_AddressEntity) _then) = __$AddressEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? label, String? fullAddress, String? area, String? city, String? state, double? lat, double? lng, String? pincode, bool? isDefault, DateTime? createdAt
});




}
/// @nodoc
class __$AddressEntityCopyWithImpl<$Res>
    implements _$AddressEntityCopyWith<$Res> {
  __$AddressEntityCopyWithImpl(this._self, this._then);

  final _AddressEntity _self;
  final $Res Function(_AddressEntity) _then;

/// Create a copy of AddressEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? label = freezed,Object? fullAddress = freezed,Object? area = freezed,Object? city = freezed,Object? state = freezed,Object? lat = freezed,Object? lng = freezed,Object? pincode = freezed,Object? isDefault = freezed,Object? createdAt = freezed,}) {
  return _then(_AddressEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,fullAddress: freezed == fullAddress ? _self.fullAddress : fullAddress // ignore: cast_nullable_to_non_nullable
as String?,area: freezed == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,isDefault: freezed == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
