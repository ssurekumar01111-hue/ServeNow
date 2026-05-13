// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banner_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BannerModel {

 String get id; String get title; String get subtitle; String get imageUrl; String get actionType; String get actionValue; int get sortOrder; bool get isActive; String? get targetRoute;
/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannerModelCopyWith<BannerModel> get copyWith => _$BannerModelCopyWithImpl<BannerModel>(this as BannerModel, _$identity);

  /// Serializes this BannerModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.actionValue, actionValue) || other.actionValue == actionValue)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.targetRoute, targetRoute) || other.targetRoute == targetRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,imageUrl,actionType,actionValue,sortOrder,isActive,targetRoute);

@override
String toString() {
  return 'BannerModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, actionType: $actionType, actionValue: $actionValue, sortOrder: $sortOrder, isActive: $isActive, targetRoute: $targetRoute)';
}


}

/// @nodoc
abstract mixin class $BannerModelCopyWith<$Res>  {
  factory $BannerModelCopyWith(BannerModel value, $Res Function(BannerModel) _then) = _$BannerModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subtitle, String imageUrl, String actionType, String actionValue, int sortOrder, bool isActive, String? targetRoute
});




}
/// @nodoc
class _$BannerModelCopyWithImpl<$Res>
    implements $BannerModelCopyWith<$Res> {
  _$BannerModelCopyWithImpl(this._self, this._then);

  final BannerModel _self;
  final $Res Function(BannerModel) _then;

/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? imageUrl = null,Object? actionType = null,Object? actionValue = null,Object? sortOrder = null,Object? isActive = null,Object? targetRoute = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,actionValue: null == actionValue ? _self.actionValue : actionValue // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,targetRoute: freezed == targetRoute ? _self.targetRoute : targetRoute // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BannerModel].
extension BannerModelPatterns on BannerModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BannerModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BannerModel value)  $default,){
final _that = this;
switch (_that) {
case _BannerModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BannerModel value)?  $default,){
final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String imageUrl,  String actionType,  String actionValue,  int sortOrder,  bool isActive,  String? targetRoute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.actionType,_that.actionValue,_that.sortOrder,_that.isActive,_that.targetRoute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  String imageUrl,  String actionType,  String actionValue,  int sortOrder,  bool isActive,  String? targetRoute)  $default,) {final _that = this;
switch (_that) {
case _BannerModel():
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.actionType,_that.actionValue,_that.sortOrder,_that.isActive,_that.targetRoute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subtitle,  String imageUrl,  String actionType,  String actionValue,  int sortOrder,  bool isActive,  String? targetRoute)?  $default,) {final _that = this;
switch (_that) {
case _BannerModel() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.imageUrl,_that.actionType,_that.actionValue,_that.sortOrder,_that.isActive,_that.targetRoute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BannerModel extends BannerModel {
  const _BannerModel({required this.id, required this.title, required this.subtitle, required this.imageUrl, required this.actionType, required this.actionValue, required this.sortOrder, this.isActive = true, this.targetRoute}): super._();
  factory _BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String subtitle;
@override final  String imageUrl;
@override final  String actionType;
@override final  String actionValue;
@override final  int sortOrder;
@override@JsonKey() final  bool isActive;
@override final  String? targetRoute;

/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BannerModelCopyWith<_BannerModel> get copyWith => __$BannerModelCopyWithImpl<_BannerModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BannerModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BannerModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.actionType, actionType) || other.actionType == actionType)&&(identical(other.actionValue, actionValue) || other.actionValue == actionValue)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.targetRoute, targetRoute) || other.targetRoute == targetRoute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,imageUrl,actionType,actionValue,sortOrder,isActive,targetRoute);

@override
String toString() {
  return 'BannerModel(id: $id, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, actionType: $actionType, actionValue: $actionValue, sortOrder: $sortOrder, isActive: $isActive, targetRoute: $targetRoute)';
}


}

/// @nodoc
abstract mixin class _$BannerModelCopyWith<$Res> implements $BannerModelCopyWith<$Res> {
  factory _$BannerModelCopyWith(_BannerModel value, $Res Function(_BannerModel) _then) = __$BannerModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subtitle, String imageUrl, String actionType, String actionValue, int sortOrder, bool isActive, String? targetRoute
});




}
/// @nodoc
class __$BannerModelCopyWithImpl<$Res>
    implements _$BannerModelCopyWith<$Res> {
  __$BannerModelCopyWithImpl(this._self, this._then);

  final _BannerModel _self;
  final $Res Function(_BannerModel) _then;

/// Create a copy of BannerModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? imageUrl = null,Object? actionType = null,Object? actionValue = null,Object? sortOrder = null,Object? isActive = null,Object? targetRoute = freezed,}) {
  return _then(_BannerModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,actionType: null == actionType ? _self.actionType : actionType // ignore: cast_nullable_to_non_nullable
as String,actionValue: null == actionValue ? _self.actionValue : actionValue // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,targetRoute: freezed == targetRoute ? _self.targetRoute : targetRoute // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
