// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceModel {

 String get id; String get name; String get description; String get categoryId; String get providerId; double get basePrice; int get duration; double? get discountPrice; List<String> get images; double get rating; int get reviewCount; bool get isActive; int get bookingCount; String? get categoryName; String? get imageUrl; String? get providerName;
/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceModelCopyWith<ServiceModel> get copyWith => _$ServiceModelCopyWithImpl<ServiceModel>(this as ServiceModel, _$identity);

  /// Serializes this ServiceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.bookingCount, bookingCount) || other.bookingCount == bookingCount)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.providerName, providerName) || other.providerName == providerName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,categoryId,providerId,basePrice,duration,discountPrice,const DeepCollectionEquality().hash(images),rating,reviewCount,isActive,bookingCount,categoryName,imageUrl,providerName);

@override
String toString() {
  return 'ServiceModel(id: $id, name: $name, description: $description, categoryId: $categoryId, providerId: $providerId, basePrice: $basePrice, duration: $duration, discountPrice: $discountPrice, images: $images, rating: $rating, reviewCount: $reviewCount, isActive: $isActive, bookingCount: $bookingCount, categoryName: $categoryName, imageUrl: $imageUrl, providerName: $providerName)';
}


}

/// @nodoc
abstract mixin class $ServiceModelCopyWith<$Res>  {
  factory $ServiceModelCopyWith(ServiceModel value, $Res Function(ServiceModel) _then) = _$ServiceModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String categoryId, String providerId, double basePrice, int duration, double? discountPrice, List<String> images, double rating, int reviewCount, bool isActive, int bookingCount, String? categoryName, String? imageUrl, String? providerName
});




}
/// @nodoc
class _$ServiceModelCopyWithImpl<$Res>
    implements $ServiceModelCopyWith<$Res> {
  _$ServiceModelCopyWithImpl(this._self, this._then);

  final ServiceModel _self;
  final $Res Function(ServiceModel) _then;

/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? categoryId = null,Object? providerId = null,Object? basePrice = null,Object? duration = null,Object? discountPrice = freezed,Object? images = null,Object? rating = null,Object? reviewCount = null,Object? isActive = null,Object? bookingCount = null,Object? categoryName = freezed,Object? imageUrl = freezed,Object? providerName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,bookingCount: null == bookingCount ? _self.bookingCount : bookingCount // ignore: cast_nullable_to_non_nullable
as int,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceModel].
extension ServiceModelPatterns on ServiceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceModel value)  $default,){
final _that = this;
switch (_that) {
case _ServiceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String categoryId,  String providerId,  double basePrice,  int duration,  double? discountPrice,  List<String> images,  double rating,  int reviewCount,  bool isActive,  int bookingCount,  String? categoryName,  String? imageUrl,  String? providerName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.categoryId,_that.providerId,_that.basePrice,_that.duration,_that.discountPrice,_that.images,_that.rating,_that.reviewCount,_that.isActive,_that.bookingCount,_that.categoryName,_that.imageUrl,_that.providerName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String categoryId,  String providerId,  double basePrice,  int duration,  double? discountPrice,  List<String> images,  double rating,  int reviewCount,  bool isActive,  int bookingCount,  String? categoryName,  String? imageUrl,  String? providerName)  $default,) {final _that = this;
switch (_that) {
case _ServiceModel():
return $default(_that.id,_that.name,_that.description,_that.categoryId,_that.providerId,_that.basePrice,_that.duration,_that.discountPrice,_that.images,_that.rating,_that.reviewCount,_that.isActive,_that.bookingCount,_that.categoryName,_that.imageUrl,_that.providerName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String categoryId,  String providerId,  double basePrice,  int duration,  double? discountPrice,  List<String> images,  double rating,  int reviewCount,  bool isActive,  int bookingCount,  String? categoryName,  String? imageUrl,  String? providerName)?  $default,) {final _that = this;
switch (_that) {
case _ServiceModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.categoryId,_that.providerId,_that.basePrice,_that.duration,_that.discountPrice,_that.images,_that.rating,_that.reviewCount,_that.isActive,_that.bookingCount,_that.categoryName,_that.imageUrl,_that.providerName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceModel extends ServiceModel {
  const _ServiceModel({required this.id, required this.name, required this.description, required this.categoryId, required this.providerId, required this.basePrice, required this.duration, this.discountPrice, final  List<String> images = const [], this.rating = 0.0, this.reviewCount = 0, this.isActive = true, this.bookingCount = 0, this.categoryName, this.imageUrl, this.providerName}): _images = images,super._();
  factory _ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String categoryId;
@override final  String providerId;
@override final  double basePrice;
@override final  int duration;
@override final  double? discountPrice;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  double rating;
@override@JsonKey() final  int reviewCount;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  int bookingCount;
@override final  String? categoryName;
@override final  String? imageUrl;
@override final  String? providerName;

/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceModelCopyWith<_ServiceModel> get copyWith => __$ServiceModelCopyWithImpl<_ServiceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.providerId, providerId) || other.providerId == providerId)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.discountPrice, discountPrice) || other.discountPrice == discountPrice)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.bookingCount, bookingCount) || other.bookingCount == bookingCount)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.providerName, providerName) || other.providerName == providerName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,categoryId,providerId,basePrice,duration,discountPrice,const DeepCollectionEquality().hash(_images),rating,reviewCount,isActive,bookingCount,categoryName,imageUrl,providerName);

@override
String toString() {
  return 'ServiceModel(id: $id, name: $name, description: $description, categoryId: $categoryId, providerId: $providerId, basePrice: $basePrice, duration: $duration, discountPrice: $discountPrice, images: $images, rating: $rating, reviewCount: $reviewCount, isActive: $isActive, bookingCount: $bookingCount, categoryName: $categoryName, imageUrl: $imageUrl, providerName: $providerName)';
}


}

/// @nodoc
abstract mixin class _$ServiceModelCopyWith<$Res> implements $ServiceModelCopyWith<$Res> {
  factory _$ServiceModelCopyWith(_ServiceModel value, $Res Function(_ServiceModel) _then) = __$ServiceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String categoryId, String providerId, double basePrice, int duration, double? discountPrice, List<String> images, double rating, int reviewCount, bool isActive, int bookingCount, String? categoryName, String? imageUrl, String? providerName
});




}
/// @nodoc
class __$ServiceModelCopyWithImpl<$Res>
    implements _$ServiceModelCopyWith<$Res> {
  __$ServiceModelCopyWithImpl(this._self, this._then);

  final _ServiceModel _self;
  final $Res Function(_ServiceModel) _then;

/// Create a copy of ServiceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? categoryId = null,Object? providerId = null,Object? basePrice = null,Object? duration = null,Object? discountPrice = freezed,Object? images = null,Object? rating = null,Object? reviewCount = null,Object? isActive = null,Object? bookingCount = null,Object? categoryName = freezed,Object? imageUrl = freezed,Object? providerName = freezed,}) {
  return _then(_ServiceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,providerId: null == providerId ? _self.providerId : providerId // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,discountPrice: freezed == discountPrice ? _self.discountPrice : discountPrice // ignore: cast_nullable_to_non_nullable
as double?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,bookingCount: null == bookingCount ? _self.bookingCount : bookingCount // ignore: cast_nullable_to_non_nullable
as int,categoryName: freezed == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,providerName: freezed == providerName ? _self.providerName : providerName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
