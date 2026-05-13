// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handyman_location_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HandymanLocationEntity {

 double get latitude; double get longitude; DateTime get updatedAt; String get bookingId;
/// Create a copy of HandymanLocationEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandymanLocationEntityCopyWith<HandymanLocationEntity> get copyWith => _$HandymanLocationEntityCopyWithImpl<HandymanLocationEntity>(this as HandymanLocationEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandymanLocationEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,updatedAt,bookingId);

@override
String toString() {
  return 'HandymanLocationEntity(latitude: $latitude, longitude: $longitude, updatedAt: $updatedAt, bookingId: $bookingId)';
}


}

/// @nodoc
abstract mixin class $HandymanLocationEntityCopyWith<$Res>  {
  factory $HandymanLocationEntityCopyWith(HandymanLocationEntity value, $Res Function(HandymanLocationEntity) _then) = _$HandymanLocationEntityCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, DateTime updatedAt, String bookingId
});




}
/// @nodoc
class _$HandymanLocationEntityCopyWithImpl<$Res>
    implements $HandymanLocationEntityCopyWith<$Res> {
  _$HandymanLocationEntityCopyWithImpl(this._self, this._then);

  final HandymanLocationEntity _self;
  final $Res Function(HandymanLocationEntity) _then;

/// Create a copy of HandymanLocationEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? updatedAt = null,Object? bookingId = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HandymanLocationEntity].
extension HandymanLocationEntityPatterns on HandymanLocationEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandymanLocationEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandymanLocationEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandymanLocationEntity value)  $default,){
final _that = this;
switch (_that) {
case _HandymanLocationEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandymanLocationEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HandymanLocationEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude,  DateTime updatedAt,  String bookingId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandymanLocationEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.updatedAt,_that.bookingId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude,  DateTime updatedAt,  String bookingId)  $default,) {final _that = this;
switch (_that) {
case _HandymanLocationEntity():
return $default(_that.latitude,_that.longitude,_that.updatedAt,_that.bookingId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude,  DateTime updatedAt,  String bookingId)?  $default,) {final _that = this;
switch (_that) {
case _HandymanLocationEntity() when $default != null:
return $default(_that.latitude,_that.longitude,_that.updatedAt,_that.bookingId);case _:
  return null;

}
}

}

/// @nodoc


class _HandymanLocationEntity extends HandymanLocationEntity {
  const _HandymanLocationEntity({required this.latitude, required this.longitude, required this.updatedAt, required this.bookingId}): super._();
  

@override final  double latitude;
@override final  double longitude;
@override final  DateTime updatedAt;
@override final  String bookingId;

/// Create a copy of HandymanLocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandymanLocationEntityCopyWith<_HandymanLocationEntity> get copyWith => __$HandymanLocationEntityCopyWithImpl<_HandymanLocationEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandymanLocationEntity&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId));
}


@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,updatedAt,bookingId);

@override
String toString() {
  return 'HandymanLocationEntity(latitude: $latitude, longitude: $longitude, updatedAt: $updatedAt, bookingId: $bookingId)';
}


}

/// @nodoc
abstract mixin class _$HandymanLocationEntityCopyWith<$Res> implements $HandymanLocationEntityCopyWith<$Res> {
  factory _$HandymanLocationEntityCopyWith(_HandymanLocationEntity value, $Res Function(_HandymanLocationEntity) _then) = __$HandymanLocationEntityCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, DateTime updatedAt, String bookingId
});




}
/// @nodoc
class __$HandymanLocationEntityCopyWithImpl<$Res>
    implements _$HandymanLocationEntityCopyWith<$Res> {
  __$HandymanLocationEntityCopyWithImpl(this._self, this._then);

  final _HandymanLocationEntity _self;
  final $Res Function(_HandymanLocationEntity) _then;

/// Create a copy of HandymanLocationEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? updatedAt = null,Object? bookingId = null,}) {
  return _then(_HandymanLocationEntity(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
