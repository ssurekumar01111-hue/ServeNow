// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_summary_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProviderSummaryEntity {

 String get id; String get businessName; double get rating; int get reviewCount; String get photoUrl; List<String> get categories; bool get isVerified; double? get distance; int get completedJobs; String? get serviceArea; bool get isActive; String? get onboardingStatus;
/// Create a copy of ProviderSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderSummaryEntityCopyWith<ProviderSummaryEntity> get copyWith => _$ProviderSummaryEntityCopyWithImpl<ProviderSummaryEntity>(this as ProviderSummaryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.completedJobs, completedJobs) || other.completedJobs == completedJobs)&&(identical(other.serviceArea, serviceArea) || other.serviceArea == serviceArea)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,businessName,rating,reviewCount,photoUrl,const DeepCollectionEquality().hash(categories),isVerified,distance,completedJobs,serviceArea,isActive,onboardingStatus);

@override
String toString() {
  return 'ProviderSummaryEntity(id: $id, businessName: $businessName, rating: $rating, reviewCount: $reviewCount, photoUrl: $photoUrl, categories: $categories, isVerified: $isVerified, distance: $distance, completedJobs: $completedJobs, serviceArea: $serviceArea, isActive: $isActive, onboardingStatus: $onboardingStatus)';
}


}

/// @nodoc
abstract mixin class $ProviderSummaryEntityCopyWith<$Res>  {
  factory $ProviderSummaryEntityCopyWith(ProviderSummaryEntity value, $Res Function(ProviderSummaryEntity) _then) = _$ProviderSummaryEntityCopyWithImpl;
@useResult
$Res call({
 String id, String businessName, double rating, int reviewCount, String photoUrl, List<String> categories, bool isVerified, double? distance, int completedJobs, String? serviceArea, bool isActive, String? onboardingStatus
});




}
/// @nodoc
class _$ProviderSummaryEntityCopyWithImpl<$Res>
    implements $ProviderSummaryEntityCopyWith<$Res> {
  _$ProviderSummaryEntityCopyWithImpl(this._self, this._then);

  final ProviderSummaryEntity _self;
  final $Res Function(ProviderSummaryEntity) _then;

/// Create a copy of ProviderSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? businessName = null,Object? rating = null,Object? reviewCount = null,Object? photoUrl = null,Object? categories = null,Object? isVerified = null,Object? distance = freezed,Object? completedJobs = null,Object? serviceArea = freezed,Object? isActive = null,Object? onboardingStatus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,completedJobs: null == completedJobs ? _self.completedJobs : completedJobs // ignore: cast_nullable_to_non_nullable
as int,serviceArea: freezed == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,onboardingStatus: freezed == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderSummaryEntity].
extension ProviderSummaryEntityPatterns on ProviderSummaryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderSummaryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderSummaryEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProviderSummaryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderSummaryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderSummaryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String businessName,  double rating,  int reviewCount,  String photoUrl,  List<String> categories,  bool isVerified,  double? distance,  int completedJobs,  String? serviceArea,  bool isActive,  String? onboardingStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderSummaryEntity() when $default != null:
return $default(_that.id,_that.businessName,_that.rating,_that.reviewCount,_that.photoUrl,_that.categories,_that.isVerified,_that.distance,_that.completedJobs,_that.serviceArea,_that.isActive,_that.onboardingStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String businessName,  double rating,  int reviewCount,  String photoUrl,  List<String> categories,  bool isVerified,  double? distance,  int completedJobs,  String? serviceArea,  bool isActive,  String? onboardingStatus)  $default,) {final _that = this;
switch (_that) {
case _ProviderSummaryEntity():
return $default(_that.id,_that.businessName,_that.rating,_that.reviewCount,_that.photoUrl,_that.categories,_that.isVerified,_that.distance,_that.completedJobs,_that.serviceArea,_that.isActive,_that.onboardingStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String businessName,  double rating,  int reviewCount,  String photoUrl,  List<String> categories,  bool isVerified,  double? distance,  int completedJobs,  String? serviceArea,  bool isActive,  String? onboardingStatus)?  $default,) {final _that = this;
switch (_that) {
case _ProviderSummaryEntity() when $default != null:
return $default(_that.id,_that.businessName,_that.rating,_that.reviewCount,_that.photoUrl,_that.categories,_that.isVerified,_that.distance,_that.completedJobs,_that.serviceArea,_that.isActive,_that.onboardingStatus);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderSummaryEntity extends ProviderSummaryEntity {
  const _ProviderSummaryEntity({required this.id, required this.businessName, required this.rating, required this.reviewCount, required this.photoUrl, required final  List<String> categories, this.isVerified = false, this.distance, this.completedJobs = 0, this.serviceArea, this.isActive = true, this.onboardingStatus}): _categories = categories,super._();
  

@override final  String id;
@override final  String businessName;
@override final  double rating;
@override final  int reviewCount;
@override final  String photoUrl;
 final  List<String> _categories;
@override List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  bool isVerified;
@override final  double? distance;
@override@JsonKey() final  int completedJobs;
@override final  String? serviceArea;
@override@JsonKey() final  bool isActive;
@override final  String? onboardingStatus;

/// Create a copy of ProviderSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderSummaryEntityCopyWith<_ProviderSummaryEntity> get copyWith => __$ProviderSummaryEntityCopyWithImpl<_ProviderSummaryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderSummaryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.completedJobs, completedJobs) || other.completedJobs == completedJobs)&&(identical(other.serviceArea, serviceArea) || other.serviceArea == serviceArea)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus));
}


@override
int get hashCode => Object.hash(runtimeType,id,businessName,rating,reviewCount,photoUrl,const DeepCollectionEquality().hash(_categories),isVerified,distance,completedJobs,serviceArea,isActive,onboardingStatus);

@override
String toString() {
  return 'ProviderSummaryEntity(id: $id, businessName: $businessName, rating: $rating, reviewCount: $reviewCount, photoUrl: $photoUrl, categories: $categories, isVerified: $isVerified, distance: $distance, completedJobs: $completedJobs, serviceArea: $serviceArea, isActive: $isActive, onboardingStatus: $onboardingStatus)';
}


}

/// @nodoc
abstract mixin class _$ProviderSummaryEntityCopyWith<$Res> implements $ProviderSummaryEntityCopyWith<$Res> {
  factory _$ProviderSummaryEntityCopyWith(_ProviderSummaryEntity value, $Res Function(_ProviderSummaryEntity) _then) = __$ProviderSummaryEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String businessName, double rating, int reviewCount, String photoUrl, List<String> categories, bool isVerified, double? distance, int completedJobs, String? serviceArea, bool isActive, String? onboardingStatus
});




}
/// @nodoc
class __$ProviderSummaryEntityCopyWithImpl<$Res>
    implements _$ProviderSummaryEntityCopyWith<$Res> {
  __$ProviderSummaryEntityCopyWithImpl(this._self, this._then);

  final _ProviderSummaryEntity _self;
  final $Res Function(_ProviderSummaryEntity) _then;

/// Create a copy of ProviderSummaryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? businessName = null,Object? rating = null,Object? reviewCount = null,Object? photoUrl = null,Object? categories = null,Object? isVerified = null,Object? distance = freezed,Object? completedJobs = null,Object? serviceArea = freezed,Object? isActive = null,Object? onboardingStatus = freezed,}) {
  return _then(_ProviderSummaryEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,completedJobs: null == completedJobs ? _self.completedJobs : completedJobs // ignore: cast_nullable_to_non_nullable
as int,serviceArea: freezed == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,onboardingStatus: freezed == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
