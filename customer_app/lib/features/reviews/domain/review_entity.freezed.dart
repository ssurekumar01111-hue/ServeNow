// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReviewEntity {

 String get id; String get bookingId; String get customerId; String get customerName; String get providerId; String? get handymanId; double get providerRating; double get handymanRating; String? get comment; List<String> get photos; bool get isVisible; DateTime get createdAt;
/// Create a copy of ReviewEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewEntityCopyWith<ReviewEntity> get copyWith => _$ReviewEntityCopyWithImpl<ReviewEntity>(this as ReviewEntity, _$identity);

  /// Serializes this ReviewEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.handymanId, handymanId) || other.handymanId == handymanId)&&(identical(other.providerRating, providerRating) || other.providerRating == providerRating)&&(identical(other.handymanRating, handymanRating) || other.handymanRating == handymanRating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookingId,customerId,customerName,providerId,handymanId,providerRating,handymanRating,comment,const DeepCollectionEquality().hash(photos),isVisible,createdAt);

@override
String toString() {
  return 'ReviewEntity(id: $id, bookingId: $bookingId, customerId: $customerId, customerName: $customerName, providerId: $providerId, handymanId: $handymanId, providerRating: $providerRating, handymanRating: $handymanRating, comment: $comment, photos: $photos, isVisible: $isVisible, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ReviewEntityCopyWith<$Res>  {
  factory $ReviewEntityCopyWith(ReviewEntity value, $Res Function(ReviewEntity) _then) = _$ReviewEntityCopyWithImpl;
@useResult
$Res call({
 String id, String bookingId, String customerId, String customerName, String providerId, String? handymanId, double providerRating, double handymanRating, String? comment, List<String> photos, bool isVisible, DateTime createdAt
});




}
/// @nodoc
class _$ReviewEntityCopyWithImpl<$Res>
    implements $ReviewEntityCopyWith<$Res> {
  _$ReviewEntityCopyWithImpl(this._self, this._then);

  final ReviewEntity _self;
  final $Res Function(ReviewEntity) _then;

/// Create a copy of ReviewEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = null,Object? customerId = null,Object? customerName = null,Object? providerId = null,Object? handymanId = freezed,Object? providerRating = null,Object? handymanRating = null,Object? comment = freezed,Object? photos = null,Object? isVisible = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,handymanId: freezed == handymanId ? _self.handymanId : handymanId // ignore: cast_nullable_to_non_nullable
as String?,providerRating: null == providerRating ? _self.providerRating : providerRating // ignore: cast_nullable_to_non_nullable
as double,handymanRating: null == handymanRating ? _self.handymanRating : handymanRating // ignore: cast_nullable_to_non_nullable
as double,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewEntity].
extension ReviewEntityPatterns on ReviewEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewEntity value)  $default,){
final _that = this;
switch (_that) {
case _ReviewEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookingId,  String customerId,  String customerName,  String providerId,  String? handymanId,  double providerRating,  double handymanRating,  String? comment,  List<String> photos,  bool isVisible,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewEntity() when $default != null:
return $default(_that.id,_that.bookingId,_that.customerId,_that.customerName,_that.providerId,_that.handymanId,_that.providerRating,_that.handymanRating,_that.comment,_that.photos,_that.isVisible,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookingId,  String customerId,  String customerName,  String providerId,  String? handymanId,  double providerRating,  double handymanRating,  String? comment,  List<String> photos,  bool isVisible,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ReviewEntity():
return $default(_that.id,_that.bookingId,_that.customerId,_that.customerName,_that.providerId,_that.handymanId,_that.providerRating,_that.handymanRating,_that.comment,_that.photos,_that.isVisible,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookingId,  String customerId,  String customerName,  String providerId,  String? handymanId,  double providerRating,  double handymanRating,  String? comment,  List<String> photos,  bool isVisible,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ReviewEntity() when $default != null:
return $default(_that.id,_that.bookingId,_that.customerId,_that.customerName,_that.providerId,_that.handymanId,_that.providerRating,_that.handymanRating,_that.comment,_that.photos,_that.isVisible,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewEntity extends ReviewEntity {
  const _ReviewEntity({required this.id, required this.bookingId, required this.customerId, required this.customerName, required this.providerId, this.handymanId, required this.providerRating, required this.handymanRating, this.comment, final  List<String> photos = const [], this.isVisible = true, required this.createdAt}): _photos = photos,super._();
  factory _ReviewEntity.fromJson(Map<String, dynamic> json) => _$ReviewEntityFromJson(json);

@override final  String id;
@override final  String bookingId;
@override final  String customerId;
@override final  String customerName;
@override final  String providerId;
@override final  String? handymanId;
@override final  double providerRating;
@override final  double handymanRating;
@override final  String? comment;
 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override@JsonKey() final  bool isVisible;
@override final  DateTime createdAt;

/// Create a copy of ReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewEntityCopyWith<_ReviewEntity> get copyWith => __$ReviewEntityCopyWithImpl<_ReviewEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.handymanId, handymanId) || other.handymanId == handymanId)&&(identical(other.providerRating, providerRating) || other.providerRating == providerRating)&&(identical(other.handymanRating, handymanRating) || other.handymanRating == handymanRating)&&(identical(other.comment, comment) || other.comment == comment)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.isVisible, isVisible) || other.isVisible == isVisible)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookingId,customerId,customerName,providerId,handymanId,providerRating,handymanRating,comment,const DeepCollectionEquality().hash(_photos),isVisible,createdAt);

@override
String toString() {
  return 'ReviewEntity(id: $id, bookingId: $bookingId, customerId: $customerId, customerName: $customerName, providerId: $providerId, handymanId: $handymanId, providerRating: $providerRating, handymanRating: $handymanRating, comment: $comment, photos: $photos, isVisible: $isVisible, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ReviewEntityCopyWith<$Res> implements $ReviewEntityCopyWith<$Res> {
  factory _$ReviewEntityCopyWith(_ReviewEntity value, $Res Function(_ReviewEntity) _then) = __$ReviewEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookingId, String customerId, String customerName, String providerId, String? handymanId, double providerRating, double handymanRating, String? comment, List<String> photos, bool isVisible, DateTime createdAt
});




}
/// @nodoc
class __$ReviewEntityCopyWithImpl<$Res>
    implements _$ReviewEntityCopyWith<$Res> {
  __$ReviewEntityCopyWithImpl(this._self, this._then);

  final _ReviewEntity _self;
  final $Res Function(_ReviewEntity) _then;

/// Create a copy of ReviewEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = null,Object? customerId = null,Object? customerName = null,Object? providerId = null,Object? handymanId = freezed,Object? providerRating = null,Object? handymanRating = null,Object? comment = freezed,Object? photos = null,Object? isVisible = null,Object? createdAt = null,}) {
  return _then(_ReviewEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: null == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,handymanId: freezed == handymanId ? _self.handymanId : handymanId // ignore: cast_nullable_to_non_nullable
as String?,providerRating: null == providerRating ? _self.providerRating : providerRating // ignore: cast_nullable_to_non_nullable
as double,handymanRating: null == handymanRating ? _self.handymanRating : handymanRating // ignore: cast_nullable_to_non_nullable
as double,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,isVisible: null == isVisible ? _self.isVisible : isVisible // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
