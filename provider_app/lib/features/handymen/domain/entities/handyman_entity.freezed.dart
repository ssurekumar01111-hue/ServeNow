// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'handyman_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HandymanEntity {

 String get id; String get providerId; String get name; String get phone; List<String> get skills; String get photoUrl; String get idProofUrl; int get commissionRate; bool get isOnline; bool get isAvailable;
/// Create a copy of HandymanEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HandymanEntityCopyWith<HandymanEntity> get copyWith => _$HandymanEntityCopyWithImpl<HandymanEntity>(this as HandymanEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HandymanEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.idProofUrl, idProofUrl) || other.idProofUrl == idProofUrl)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,id,providerId,name,phone,const DeepCollectionEquality().hash(skills),photoUrl,idProofUrl,commissionRate,isOnline,isAvailable);

@override
String toString() {
  return 'HandymanEntity(id: $id, providerId: $providerId, name: $name, phone: $phone, skills: $skills, photoUrl: $photoUrl, idProofUrl: $idProofUrl, commissionRate: $commissionRate, isOnline: $isOnline, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $HandymanEntityCopyWith<$Res>  {
  factory $HandymanEntityCopyWith(HandymanEntity value, $Res Function(HandymanEntity) _then) = _$HandymanEntityCopyWithImpl;
@useResult
$Res call({
 String id, String providerId, String name, String phone, List<String> skills, String photoUrl, String idProofUrl, int commissionRate, bool isOnline, bool isAvailable
});




}
/// @nodoc
class _$HandymanEntityCopyWithImpl<$Res>
    implements $HandymanEntityCopyWith<$Res> {
  _$HandymanEntityCopyWithImpl(this._self, this._then);

  final HandymanEntity _self;
  final $Res Function(HandymanEntity) _then;

/// Create a copy of HandymanEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? providerId = null,Object? name = null,Object? phone = null,Object? skills = null,Object? photoUrl = null,Object? idProofUrl = null,Object? commissionRate = null,Object? isOnline = null,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,idProofUrl: null == idProofUrl ? _self.idProofUrl : idProofUrl // ignore: cast_nullable_to_non_nullable
as String,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HandymanEntity].
extension HandymanEntityPatterns on HandymanEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HandymanEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HandymanEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HandymanEntity value)  $default,){
final _that = this;
switch (_that) {
case _HandymanEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HandymanEntity value)?  $default,){
final _that = this;
switch (_that) {
case _HandymanEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String providerId,  String name,  String phone,  List<String> skills,  String photoUrl,  String idProofUrl,  int commissionRate,  bool isOnline,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HandymanEntity() when $default != null:
return $default(_that.id,_that.providerId,_that.name,_that.phone,_that.skills,_that.photoUrl,_that.idProofUrl,_that.commissionRate,_that.isOnline,_that.isAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String providerId,  String name,  String phone,  List<String> skills,  String photoUrl,  String idProofUrl,  int commissionRate,  bool isOnline,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _HandymanEntity():
return $default(_that.id,_that.providerId,_that.name,_that.phone,_that.skills,_that.photoUrl,_that.idProofUrl,_that.commissionRate,_that.isOnline,_that.isAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String providerId,  String name,  String phone,  List<String> skills,  String photoUrl,  String idProofUrl,  int commissionRate,  bool isOnline,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _HandymanEntity() when $default != null:
return $default(_that.id,_that.providerId,_that.name,_that.phone,_that.skills,_that.photoUrl,_that.idProofUrl,_that.commissionRate,_that.isOnline,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc


class _HandymanEntity extends HandymanEntity {
  const _HandymanEntity({required this.id, required this.providerId, required this.name, required this.phone, required final  List<String> skills, required this.photoUrl, required this.idProofUrl, this.commissionRate = 0, this.isOnline = false, this.isAvailable = true}): _skills = skills,super._();
  

@override final  String id;
@override final  String providerId;
@override final  String name;
@override final  String phone;
 final  List<String> _skills;
@override List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

@override final  String photoUrl;
@override final  String idProofUrl;
@override@JsonKey() final  int commissionRate;
@override@JsonKey() final  bool isOnline;
@override@JsonKey() final  bool isAvailable;

/// Create a copy of HandymanEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HandymanEntityCopyWith<_HandymanEntity> get copyWith => __$HandymanEntityCopyWithImpl<_HandymanEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HandymanEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.idProofUrl, idProofUrl) || other.idProofUrl == idProofUrl)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.isOnline, isOnline) || other.isOnline == isOnline)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}


@override
int get hashCode => Object.hash(runtimeType,id,providerId,name,phone,const DeepCollectionEquality().hash(_skills),photoUrl,idProofUrl,commissionRate,isOnline,isAvailable);

@override
String toString() {
  return 'HandymanEntity(id: $id, providerId: $providerId, name: $name, phone: $phone, skills: $skills, photoUrl: $photoUrl, idProofUrl: $idProofUrl, commissionRate: $commissionRate, isOnline: $isOnline, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$HandymanEntityCopyWith<$Res> implements $HandymanEntityCopyWith<$Res> {
  factory _$HandymanEntityCopyWith(_HandymanEntity value, $Res Function(_HandymanEntity) _then) = __$HandymanEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String providerId, String name, String phone, List<String> skills, String photoUrl, String idProofUrl, int commissionRate, bool isOnline, bool isAvailable
});




}
/// @nodoc
class __$HandymanEntityCopyWithImpl<$Res>
    implements _$HandymanEntityCopyWith<$Res> {
  __$HandymanEntityCopyWithImpl(this._self, this._then);

  final _HandymanEntity _self;
  final $Res Function(_HandymanEntity) _then;

/// Create a copy of HandymanEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? providerId = null,Object? name = null,Object? phone = null,Object? skills = null,Object? photoUrl = null,Object? idProofUrl = null,Object? commissionRate = null,Object? isOnline = null,Object? isAvailable = null,}) {
  return _then(_HandymanEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,idProofUrl: null == idProofUrl ? _self.idProofUrl : idProofUrl // ignore: cast_nullable_to_non_nullable
as String,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as int,isOnline: null == isOnline ? _self.isOnline : isOnline // ignore: cast_nullable_to_non_nullable
as bool,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
