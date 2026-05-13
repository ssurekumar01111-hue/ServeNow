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

 String get uid; UserRole get role; String? get name; String? get phone; String? get email; String? get photoUrl; bool get isActive; String? get fcmToken; DateTime? get createdAt; String? get walletId; String? get referralCode; AddressEntity? get address; double get rating; int get totalRatings;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings));
}


@override
int get hashCode => Object.hash(runtimeType,uid,role,name,phone,email,photoUrl,isActive,fcmToken,createdAt,walletId,referralCode,address,rating,totalRatings);

@override
String toString() {
  return 'UserEntity(uid: $uid, role: $role, name: $name, phone: $phone, email: $email, photoUrl: $photoUrl, isActive: $isActive, fcmToken: $fcmToken, createdAt: $createdAt, walletId: $walletId, referralCode: $referralCode, address: $address, rating: $rating, totalRatings: $totalRatings)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 String uid, UserRole role, String? name, String? phone, String? email, String? photoUrl, bool isActive, String? fcmToken, DateTime? createdAt, String? walletId, String? referralCode, AddressEntity? address, double rating, int totalRatings
});


$AddressEntityCopyWith<$Res>? get address;

}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? role = null,Object? name = freezed,Object? phone = freezed,Object? email = freezed,Object? photoUrl = freezed,Object? isActive = null,Object? fcmToken = freezed,Object? createdAt = freezed,Object? walletId = freezed,Object? referralCode = freezed,Object? address = freezed,Object? rating = null,Object? totalRatings = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressEntity?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of UserEntity
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  UserRole role,  String? name,  String? phone,  String? email,  String? photoUrl,  bool isActive,  String? fcmToken,  DateTime? createdAt,  String? walletId,  String? referralCode,  AddressEntity? address,  double rating,  int totalRatings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.uid,_that.role,_that.name,_that.phone,_that.email,_that.photoUrl,_that.isActive,_that.fcmToken,_that.createdAt,_that.walletId,_that.referralCode,_that.address,_that.rating,_that.totalRatings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  UserRole role,  String? name,  String? phone,  String? email,  String? photoUrl,  bool isActive,  String? fcmToken,  DateTime? createdAt,  String? walletId,  String? referralCode,  AddressEntity? address,  double rating,  int totalRatings)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.uid,_that.role,_that.name,_that.phone,_that.email,_that.photoUrl,_that.isActive,_that.fcmToken,_that.createdAt,_that.walletId,_that.referralCode,_that.address,_that.rating,_that.totalRatings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  UserRole role,  String? name,  String? phone,  String? email,  String? photoUrl,  bool isActive,  String? fcmToken,  DateTime? createdAt,  String? walletId,  String? referralCode,  AddressEntity? address,  double rating,  int totalRatings)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.uid,_that.role,_that.name,_that.phone,_that.email,_that.photoUrl,_that.isActive,_that.fcmToken,_that.createdAt,_that.walletId,_that.referralCode,_that.address,_that.rating,_that.totalRatings);case _:
  return null;

}
}

}

/// @nodoc


class _UserEntity extends UserEntity {
  const _UserEntity({required this.uid, required this.role, this.name, this.phone, this.email, this.photoUrl, this.isActive = true, this.fcmToken, this.createdAt, this.walletId, this.referralCode, this.address, this.rating = 0.0, this.totalRatings = 0}): super._();
  

@override final  String uid;
@override final  UserRole role;
@override final  String? name;
@override final  String? phone;
@override final  String? email;
@override final  String? photoUrl;
@override@JsonKey() final  bool isActive;
@override final  String? fcmToken;
@override final  DateTime? createdAt;
@override final  String? walletId;
@override final  String? referralCode;
@override final  AddressEntity? address;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int totalRatings;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.role, role) || other.role == role)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.fcmToken, fcmToken) || other.fcmToken == fcmToken)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.walletId, walletId) || other.walletId == walletId)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings));
}


@override
int get hashCode => Object.hash(runtimeType,uid,role,name,phone,email,photoUrl,isActive,fcmToken,createdAt,walletId,referralCode,address,rating,totalRatings);

@override
String toString() {
  return 'UserEntity(uid: $uid, role: $role, name: $name, phone: $phone, email: $email, photoUrl: $photoUrl, isActive: $isActive, fcmToken: $fcmToken, createdAt: $createdAt, walletId: $walletId, referralCode: $referralCode, address: $address, rating: $rating, totalRatings: $totalRatings)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 String uid, UserRole role, String? name, String? phone, String? email, String? photoUrl, bool isActive, String? fcmToken, DateTime? createdAt, String? walletId, String? referralCode, AddressEntity? address, double rating, int totalRatings
});


@override $AddressEntityCopyWith<$Res>? get address;

}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? role = null,Object? name = freezed,Object? phone = freezed,Object? email = freezed,Object? photoUrl = freezed,Object? isActive = null,Object? fcmToken = freezed,Object? createdAt = freezed,Object? walletId = freezed,Object? referralCode = freezed,Object? address = freezed,Object? rating = null,Object? totalRatings = null,}) {
  return _then(_UserEntity(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,fcmToken: freezed == fcmToken ? _self.fcmToken : fcmToken // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,walletId: freezed == walletId ? _self.walletId : walletId // ignore: cast_nullable_to_non_nullable
as String?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as AddressEntity?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of UserEntity
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
}
}

/// @nodoc
mixin _$AddressEntity {

 String? get street; String? get city; String? get state; double? get lat; double? get lng; String? get pincode;
/// Create a copy of AddressEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressEntityCopyWith<AddressEntity> get copyWith => _$AddressEntityCopyWithImpl<AddressEntity>(this as AddressEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressEntity&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.pincode, pincode) || other.pincode == pincode));
}


@override
int get hashCode => Object.hash(runtimeType,street,city,state,lat,lng,pincode);

@override
String toString() {
  return 'AddressEntity(street: $street, city: $city, state: $state, lat: $lat, lng: $lng, pincode: $pincode)';
}


}

/// @nodoc
abstract mixin class $AddressEntityCopyWith<$Res>  {
  factory $AddressEntityCopyWith(AddressEntity value, $Res Function(AddressEntity) _then) = _$AddressEntityCopyWithImpl;
@useResult
$Res call({
 String? street, String? city, String? state, double? lat, double? lng, String? pincode
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
@pragma('vm:prefer-inline') @override $Res call({Object? street = freezed,Object? city = freezed,Object? state = freezed,Object? lat = freezed,Object? lng = freezed,Object? pincode = freezed,}) {
  return _then(_self.copyWith(
street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? street,  String? city,  String? state,  double? lat,  double? lng,  String? pincode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressEntity() when $default != null:
return $default(_that.street,_that.city,_that.state,_that.lat,_that.lng,_that.pincode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? street,  String? city,  String? state,  double? lat,  double? lng,  String? pincode)  $default,) {final _that = this;
switch (_that) {
case _AddressEntity():
return $default(_that.street,_that.city,_that.state,_that.lat,_that.lng,_that.pincode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? street,  String? city,  String? state,  double? lat,  double? lng,  String? pincode)?  $default,) {final _that = this;
switch (_that) {
case _AddressEntity() when $default != null:
return $default(_that.street,_that.city,_that.state,_that.lat,_that.lng,_that.pincode);case _:
  return null;

}
}

}

/// @nodoc


class _AddressEntity extends AddressEntity {
  const _AddressEntity({this.street, this.city, this.state, this.lat, this.lng, this.pincode}): super._();
  

@override final  String? street;
@override final  String? city;
@override final  String? state;
@override final  double? lat;
@override final  double? lng;
@override final  String? pincode;

/// Create a copy of AddressEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressEntityCopyWith<_AddressEntity> get copyWith => __$AddressEntityCopyWithImpl<_AddressEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressEntity&&(identical(other.street, street) || other.street == street)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.pincode, pincode) || other.pincode == pincode));
}


@override
int get hashCode => Object.hash(runtimeType,street,city,state,lat,lng,pincode);

@override
String toString() {
  return 'AddressEntity(street: $street, city: $city, state: $state, lat: $lat, lng: $lng, pincode: $pincode)';
}


}

/// @nodoc
abstract mixin class _$AddressEntityCopyWith<$Res> implements $AddressEntityCopyWith<$Res> {
  factory _$AddressEntityCopyWith(_AddressEntity value, $Res Function(_AddressEntity) _then) = __$AddressEntityCopyWithImpl;
@override @useResult
$Res call({
 String? street, String? city, String? state, double? lat, double? lng, String? pincode
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
@override @pragma('vm:prefer-inline') $Res call({Object? street = freezed,Object? city = freezed,Object? state = freezed,Object? lat = freezed,Object? lng = freezed,Object? pincode = freezed,}) {
  return _then(_AddressEntity(
street: freezed == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,lat: freezed == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double?,lng: freezed == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double?,pincode: freezed == pincode ? _self.pincode : pincode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
