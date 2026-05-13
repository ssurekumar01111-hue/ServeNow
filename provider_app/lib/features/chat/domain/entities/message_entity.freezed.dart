// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageEntity {

 String get id; String get senderId; String get senderRole; String get text; DateTime get createdAt; String? get imageUrl; bool get isRead;
/// Create a copy of MessageEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageEntityCopyWith<MessageEntity> get copyWith => _$MessageEntityCopyWithImpl<MessageEntity>(this as MessageEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderRole, senderRole) || other.senderRole == senderRole)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderRole,text,createdAt,imageUrl,isRead);

@override
String toString() {
  return 'MessageEntity(id: $id, senderId: $senderId, senderRole: $senderRole, text: $text, createdAt: $createdAt, imageUrl: $imageUrl, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class $MessageEntityCopyWith<$Res>  {
  factory $MessageEntityCopyWith(MessageEntity value, $Res Function(MessageEntity) _then) = _$MessageEntityCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderRole, String text, DateTime createdAt, String? imageUrl, bool isRead
});




}
/// @nodoc
class _$MessageEntityCopyWithImpl<$Res>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._self, this._then);

  final MessageEntity _self;
  final $Res Function(MessageEntity) _then;

/// Create a copy of MessageEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? senderRole = null,Object? text = null,Object? createdAt = null,Object? imageUrl = freezed,Object? isRead = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageEntity].
extension MessageEntityPatterns on MessageEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageEntity value)  $default,){
final _that = this;
switch (_that) {
case _MessageEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MessageEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderRole,  String text,  DateTime createdAt,  String? imageUrl,  bool isRead)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageEntity() when $default != null:
return $default(_that.id,_that.senderId,_that.senderRole,_that.text,_that.createdAt,_that.imageUrl,_that.isRead);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderRole,  String text,  DateTime createdAt,  String? imageUrl,  bool isRead)  $default,) {final _that = this;
switch (_that) {
case _MessageEntity():
return $default(_that.id,_that.senderId,_that.senderRole,_that.text,_that.createdAt,_that.imageUrl,_that.isRead);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderRole,  String text,  DateTime createdAt,  String? imageUrl,  bool isRead)?  $default,) {final _that = this;
switch (_that) {
case _MessageEntity() when $default != null:
return $default(_that.id,_that.senderId,_that.senderRole,_that.text,_that.createdAt,_that.imageUrl,_that.isRead);case _:
  return null;

}
}

}

/// @nodoc


class _MessageEntity extends MessageEntity {
  const _MessageEntity({required this.id, required this.senderId, required this.senderRole, required this.text, required this.createdAt, this.imageUrl, this.isRead = false}): super._();
  

@override final  String id;
@override final  String senderId;
@override final  String senderRole;
@override final  String text;
@override final  DateTime createdAt;
@override final  String? imageUrl;
@override@JsonKey() final  bool isRead;

/// Create a copy of MessageEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageEntityCopyWith<_MessageEntity> get copyWith => __$MessageEntityCopyWithImpl<_MessageEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderRole, senderRole) || other.senderRole == senderRole)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}


@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderRole,text,createdAt,imageUrl,isRead);

@override
String toString() {
  return 'MessageEntity(id: $id, senderId: $senderId, senderRole: $senderRole, text: $text, createdAt: $createdAt, imageUrl: $imageUrl, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class _$MessageEntityCopyWith<$Res> implements $MessageEntityCopyWith<$Res> {
  factory _$MessageEntityCopyWith(_MessageEntity value, $Res Function(_MessageEntity) _then) = __$MessageEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderRole, String text, DateTime createdAt, String? imageUrl, bool isRead
});




}
/// @nodoc
class __$MessageEntityCopyWithImpl<$Res>
    implements _$MessageEntityCopyWith<$Res> {
  __$MessageEntityCopyWithImpl(this._self, this._then);

  final _MessageEntity _self;
  final $Res Function(_MessageEntity) _then;

/// Create a copy of MessageEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderRole = null,Object? text = null,Object? createdAt = null,Object? imageUrl = freezed,Object? isRead = null,}) {
  return _then(_MessageEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderRole: null == senderRole ? _self.senderRole : senderRole // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
