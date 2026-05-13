// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handyman_profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HandymanProfileEntity {

 String get id; String get name; String get phone; List<String> get skills; String get serviceArea; String get photoUrl; String get email; double get rating; int get totalRatings; int get commissionRate; double get walletBalance; double get totalEarnings; double get cashCollected; bool get isOnline; bool get isApproved; String get onboardingStatus; String get providerId;
/// Create a copy of HandymanProfileEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandymanProfileEntityCopyWith<HandymanProfileEntity> get copyWith => _$HandymanProfileEntityCopyWithImpl<HandymanProfileEntity>(this as HandymanProfileEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandymanProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.serviceArea, serviceArea) || other.serviceArea == serviceArea)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.cashCollected, cashCollected) || other.cashCollected == cashCollected)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus)&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,const DeepCollectionEquality().hash(skills),serviceArea,photoUrl,email,rating,totalRatings,commissionRate,walletBalance,totalEarnings,cashCollected,isOnline,isApproved,onboardingStatus,providerId);

@override
String toString() {
  return 'HandymanProfileEntity(id: $id, name: $name, phone: $phone, skills: $skills, serviceArea: $serviceArea, photoUrl: $photoUrl, email: $email, rating: $rating, totalRatings: $totalRatings, commissionRate: $commissionRate, walletBalance: $walletBalance, totalEarnings: $totalEarnings, cashCollected: $cashCollected, isOnline: $isOnline, isApproved: $isApproved, onboardingStatus: $onboardingStatus, providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class $HandymanProfileEntityCopyWith<$Res>  {
  factory $HandymanProfileEntityCopyWith(HandymanProfileEntity value, $Res Function(HandymanProfileEntity) _then) = _$HandymanProfileEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String phone, List<String> skills, String serviceArea, String photoUrl, String email, double rating, int totalRatings, int commissionRate, double walletBalance, double totalEarnings, double cashCollected, bool isOnline, bool isApproved, String onboardingStatus, String providerId
});




}
/// @nodoc
class _$HandymanProfileEntityCopyWithImpl<$Res>
    implements $HandymanProfileEntityCopyWith<$Res> {
  _$HandymanProfileEntityCopyWithImpl(this._self, this._then);

  final HandymanProfileEntity _self;
  final $Res Function(HandymanProfileEntity) _then;

/// Create a copy of HandymanProfileEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? skills = null,Object? serviceArea = null,Object? photoUrl = null,Object? email = null,Object? rating = null,Object? totalRatings = null,Object? commissionRate = null,Object? walletBalance = null,Object? totalEarnings = null,Object? cashCollected = null,Object? isOnline = null,Object? isApproved = null,Object? onboardingStatus = null,Object? providerId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,serviceArea: null == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as int,walletBalance: null == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as double,totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,cashCollected: null == cashCollected ? _self.cashCollected : cashCollected // ignore: cast_nullable_to_non_nullable
as double,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,onboardingStatus: null == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HandymanProfileEntity].
extension HandymanProfileEntityPatterns on HandymanProfileEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandymanProfileEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandymanProfileEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandymanProfileEntity value)  $default,){
final _that = this;
switch (_that) {
case _HandymanProfileEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandymanProfileEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HandymanProfileEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  List<String> skills,  String serviceArea,  String photoUrl,  String email,  double rating,  int totalRatings,  int commissionRate,  double walletBalance,  double totalEarnings,  double cashCollected,  bool isOnline,  bool isApproved,  String onboardingStatus,  String providerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandymanProfileEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.skills,_that.serviceArea,_that.photoUrl,_that.email,_that.rating,_that.totalRatings,_that.commissionRate,_that.walletBalance,_that.totalEarnings,_that.cashCollected,_that.isOnline,_that.isApproved,_that.onboardingStatus,_that.providerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String phone,  List<String> skills,  String serviceArea,  String photoUrl,  String email,  double rating,  int totalRatings,  int commissionRate,  double walletBalance,  double totalEarnings,  double cashCollected,  bool isOnline,  bool isApproved,  String onboardingStatus,  String providerId)  $default,) {final _that = this;
switch (_that) {
case _HandymanProfileEntity():
return $default(_that.id,_that.name,_that.phone,_that.skills,_that.serviceArea,_that.photoUrl,_that.email,_that.rating,_that.totalRatings,_that.commissionRate,_that.walletBalance,_that.totalEarnings,_that.cashCollected,_that.isOnline,_that.isApproved,_that.onboardingStatus,_that.providerId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String phone,  List<String> skills,  String serviceArea,  String photoUrl,  String email,  double rating,  int totalRatings,  int commissionRate,  double walletBalance,  double totalEarnings,  double cashCollected,  bool isOnline,  bool isApproved,  String onboardingStatus,  String providerId)?  $default,) {final _that = this;
switch (_that) {
case _HandymanProfileEntity() when $default != null:
return $default(_that.id,_that.name,_that.phone,_that.skills,_that.serviceArea,_that.photoUrl,_that.email,_that.rating,_that.totalRatings,_that.commissionRate,_that.walletBalance,_that.totalEarnings,_that.cashCollected,_that.isOnline,_that.isApproved,_that.onboardingStatus,_that.providerId);case _:
  return null;

}
}

}

/// @nodoc


class _HandymanProfileEntity extends HandymanProfileEntity {
  const _HandymanProfileEntity({required this.id, this.name = '', this.phone = '', final  List<String> skills = const [], this.serviceArea = '', this.photoUrl = '', this.email = '', this.rating = 0.0, this.totalRatings = 0, this.commissionRate = 0, this.walletBalance = 0.0, this.totalEarnings = 0.0, this.cashCollected = 0.0, this.isOnline = false, this.isApproved = false, this.onboardingStatus = '', this.providerId = ''}): _skills = skills,super._();
  

@override final  String id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String phone;
 final  List<String> _skills;
@override@JsonKey() List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

@override@JsonKey() final  String serviceArea;
@override@JsonKey() final  String photoUrl;
@override@JsonKey() final  String email;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int totalRatings;
@override@JsonKey() final  int commissionRate;
@override@JsonKey() final  double walletBalance;
@override@JsonKey() final  double totalEarnings;
@override@JsonKey() final  double cashCollected;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isApproved;
@override@JsonKey() final  String onboardingStatus;
@override@JsonKey() final  String providerId;

/// Create a copy of HandymanProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandymanProfileEntityCopyWith<_HandymanProfileEntity> get copyWith => __$HandymanProfileEntityCopyWithImpl<_HandymanProfileEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandymanProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.serviceArea, serviceArea) || other.serviceArea == serviceArea)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.email, email) || other.email == email)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.cashCollected, cashCollected) || other.cashCollected == cashCollected)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus)&&(identical(other.providerId, providerId) || other.providerId == providerId));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,phone,const DeepCollectionEquality().hash(_skills),serviceArea,photoUrl,email,rating,totalRatings,commissionRate,walletBalance,totalEarnings,cashCollected,isOnline,isApproved,onboardingStatus,providerId);

@override
String toString() {
  return 'HandymanProfileEntity(id: $id, name: $name, phone: $phone, skills: $skills, serviceArea: $serviceArea, photoUrl: $photoUrl, email: $email, rating: $rating, totalRatings: $totalRatings, commissionRate: $commissionRate, walletBalance: $walletBalance, totalEarnings: $totalEarnings, cashCollected: $cashCollected, isOnline: $isOnline, isApproved: $isApproved, onboardingStatus: $onboardingStatus, providerId: $providerId)';
}


}

/// @nodoc
abstract mixin class _$HandymanProfileEntityCopyWith<$Res> implements $HandymanProfileEntityCopyWith<$Res> {
  factory _$HandymanProfileEntityCopyWith(_HandymanProfileEntity value, $Res Function(_HandymanProfileEntity) _then) = __$HandymanProfileEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String phone, List<String> skills, String serviceArea, String photoUrl, String email, double rating, int totalRatings, int commissionRate, double walletBalance, double totalEarnings, double cashCollected, bool isOnline, bool isApproved, String onboardingStatus, String providerId
});




}
/// @nodoc
class __$HandymanProfileEntityCopyWithImpl<$Res>
    implements _$HandymanProfileEntityCopyWith<$Res> {
  __$HandymanProfileEntityCopyWithImpl(this._self, this._then);

  final _HandymanProfileEntity _self;
  final $Res Function(_HandymanProfileEntity) _then;

/// Create a copy of HandymanProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? phone = null,Object? skills = null,Object? serviceArea = null,Object? photoUrl = null,Object? email = null,Object? rating = null,Object? totalRatings = null,Object? commissionRate = null,Object? walletBalance = null,Object? totalEarnings = null,Object? cashCollected = null,Object? isOnline = null,Object? isApproved = null,Object? onboardingStatus = null,Object? providerId = null,}) {
  return _then(_HandymanProfileEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,serviceArea: null == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as int,walletBalance: null == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as double,totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,cashCollected: null == cashCollected ? _self.cashCollected : cashCollected // ignore: cast_nullable_to_non_nullable
as double,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,onboardingStatus: null == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
