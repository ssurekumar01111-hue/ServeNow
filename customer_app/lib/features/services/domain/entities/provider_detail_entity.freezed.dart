// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_detail_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProviderDetailEntity {

 String get id; String get businessName; String get photoUrl; double get rating; int get reviewCount; String get description; Map<String, dynamic> get workingHours; List<String> get serviceArea; bool get isVerified; List<ServiceEntity> get services; List<String> get gallery; String? get coverPhoto;
/// Create a copy of ProviderDetailEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderDetailEntityCopyWith<ProviderDetailEntity> get copyWith => _$ProviderDetailEntityCopyWithImpl<ProviderDetailEntity>(this as ProviderDetailEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderDetailEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.workingHours, workingHours)&&const DeepCollectionEquality().equals(other.serviceArea, serviceArea)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&const DeepCollectionEquality().equals(other.services, services)&&const DeepCollectionEquality().equals(other.gallery, gallery)&&(identical(other.coverPhoto, coverPhoto) || other.coverPhoto == coverPhoto));
}


@override
int get hashCode => Object.hash(runtimeType,id,businessName,photoUrl,rating,reviewCount,description,const DeepCollectionEquality().hash(workingHours),const DeepCollectionEquality().hash(serviceArea),isVerified,const DeepCollectionEquality().hash(services),const DeepCollectionEquality().hash(gallery),coverPhoto);

@override
String toString() {
  return 'ProviderDetailEntity(id: $id, businessName: $businessName, photoUrl: $photoUrl, rating: $rating, reviewCount: $reviewCount, description: $description, workingHours: $workingHours, serviceArea: $serviceArea, isVerified: $isVerified, services: $services, gallery: $gallery, coverPhoto: $coverPhoto)';
}


}

/// @nodoc
abstract mixin class $ProviderDetailEntityCopyWith<$Res>  {
  factory $ProviderDetailEntityCopyWith(ProviderDetailEntity value, $Res Function(ProviderDetailEntity) _then) = _$ProviderDetailEntityCopyWithImpl;
@useResult
$Res call({
 String id, String businessName, String photoUrl, double rating, int reviewCount, String description, Map<String, dynamic> workingHours, List<String> serviceArea, bool isVerified, List<ServiceEntity> services, List<String> gallery, String? coverPhoto
});




}
/// @nodoc
class _$ProviderDetailEntityCopyWithImpl<$Res>
    implements $ProviderDetailEntityCopyWith<$Res> {
  _$ProviderDetailEntityCopyWithImpl(this._self, this._then);

  final ProviderDetailEntity _self;
  final $Res Function(ProviderDetailEntity) _then;

/// Create a copy of ProviderDetailEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? businessName = null,Object? photoUrl = null,Object? rating = null,Object? reviewCount = null,Object? description = null,Object? workingHours = null,Object? serviceArea = null,Object? isVerified = null,Object? services = null,Object? gallery = null,Object? coverPhoto = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,workingHours: null == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,serviceArea: null == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<ServiceEntity>,gallery: null == gallery ? _self.gallery : gallery // ignore: cast_nullable_to_non_nullable
as List<String>,coverPhoto: freezed == coverPhoto ? _self.coverPhoto : coverPhoto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderDetailEntity].
extension ProviderDetailEntityPatterns on ProviderDetailEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderDetailEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderDetailEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderDetailEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProviderDetailEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderDetailEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderDetailEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String businessName,  String photoUrl,  double rating,  int reviewCount,  String description,  Map<String, dynamic> workingHours,  List<String> serviceArea,  bool isVerified,  List<ServiceEntity> services,  List<String> gallery,  String? coverPhoto)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderDetailEntity() when $default != null:
return $default(_that.id,_that.businessName,_that.photoUrl,_that.rating,_that.reviewCount,_that.description,_that.workingHours,_that.serviceArea,_that.isVerified,_that.services,_that.gallery,_that.coverPhoto);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String businessName,  String photoUrl,  double rating,  int reviewCount,  String description,  Map<String, dynamic> workingHours,  List<String> serviceArea,  bool isVerified,  List<ServiceEntity> services,  List<String> gallery,  String? coverPhoto)  $default,) {final _that = this;
switch (_that) {
case _ProviderDetailEntity():
return $default(_that.id,_that.businessName,_that.photoUrl,_that.rating,_that.reviewCount,_that.description,_that.workingHours,_that.serviceArea,_that.isVerified,_that.services,_that.gallery,_that.coverPhoto);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String businessName,  String photoUrl,  double rating,  int reviewCount,  String description,  Map<String, dynamic> workingHours,  List<String> serviceArea,  bool isVerified,  List<ServiceEntity> services,  List<String> gallery,  String? coverPhoto)?  $default,) {final _that = this;
switch (_that) {
case _ProviderDetailEntity() when $default != null:
return $default(_that.id,_that.businessName,_that.photoUrl,_that.rating,_that.reviewCount,_that.description,_that.workingHours,_that.serviceArea,_that.isVerified,_that.services,_that.gallery,_that.coverPhoto);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderDetailEntity extends ProviderDetailEntity {
  const _ProviderDetailEntity({required this.id, required this.businessName, required this.photoUrl, required this.rating, required this.reviewCount, required this.description, required final  Map<String, dynamic> workingHours, required final  List<String> serviceArea, this.isVerified = false, final  List<ServiceEntity> services = const [], final  List<String> gallery = const [], this.coverPhoto}): _workingHours = workingHours,_serviceArea = serviceArea,_services = services,_gallery = gallery,super._();
  

@override final  String id;
@override final  String businessName;
@override final  String photoUrl;
@override final  double rating;
@override final  int reviewCount;
@override final  String description;
 final  Map<String, dynamic> _workingHours;
@override Map<String, dynamic> get workingHours {
  if (_workingHours is EqualUnmodifiableMapView) return _workingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_workingHours);
}

 final  List<String> _serviceArea;
@override List<String> get serviceArea {
  if (_serviceArea is EqualUnmodifiableListView) return _serviceArea;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_serviceArea);
}

@override@JsonKey() final  bool isVerified;
 final  List<ServiceEntity> _services;
@override@JsonKey() List<ServiceEntity> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

 final  List<String> _gallery;
@override@JsonKey() List<String> get gallery {
  if (_gallery is EqualUnmodifiableListView) return _gallery;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gallery);
}

@override final  String? coverPhoto;

/// Create a copy of ProviderDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderDetailEntityCopyWith<_ProviderDetailEntity> get copyWith => __$ProviderDetailEntityCopyWithImpl<_ProviderDetailEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderDetailEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._workingHours, _workingHours)&&const DeepCollectionEquality().equals(other._serviceArea, _serviceArea)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&const DeepCollectionEquality().equals(other._services, _services)&&const DeepCollectionEquality().equals(other._gallery, _gallery)&&(identical(other.coverPhoto, coverPhoto) || other.coverPhoto == coverPhoto));
}


@override
int get hashCode => Object.hash(runtimeType,id,businessName,photoUrl,rating,reviewCount,description,const DeepCollectionEquality().hash(_workingHours),const DeepCollectionEquality().hash(_serviceArea),isVerified,const DeepCollectionEquality().hash(_services),const DeepCollectionEquality().hash(_gallery),coverPhoto);

@override
String toString() {
  return 'ProviderDetailEntity(id: $id, businessName: $businessName, photoUrl: $photoUrl, rating: $rating, reviewCount: $reviewCount, description: $description, workingHours: $workingHours, serviceArea: $serviceArea, isVerified: $isVerified, services: $services, gallery: $gallery, coverPhoto: $coverPhoto)';
}


}

/// @nodoc
abstract mixin class _$ProviderDetailEntityCopyWith<$Res> implements $ProviderDetailEntityCopyWith<$Res> {
  factory _$ProviderDetailEntityCopyWith(_ProviderDetailEntity value, $Res Function(_ProviderDetailEntity) _then) = __$ProviderDetailEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String businessName, String photoUrl, double rating, int reviewCount, String description, Map<String, dynamic> workingHours, List<String> serviceArea, bool isVerified, List<ServiceEntity> services, List<String> gallery, String? coverPhoto
});




}
/// @nodoc
class __$ProviderDetailEntityCopyWithImpl<$Res>
    implements _$ProviderDetailEntityCopyWith<$Res> {
  __$ProviderDetailEntityCopyWithImpl(this._self, this._then);

  final _ProviderDetailEntity _self;
  final $Res Function(_ProviderDetailEntity) _then;

/// Create a copy of ProviderDetailEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? businessName = null,Object? photoUrl = null,Object? rating = null,Object? reviewCount = null,Object? description = null,Object? workingHours = null,Object? serviceArea = null,Object? isVerified = null,Object? services = null,Object? gallery = null,Object? coverPhoto = freezed,}) {
  return _then(_ProviderDetailEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewCount: null == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,workingHours: null == workingHours ? _self._workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,serviceArea: null == serviceArea ? _self._serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as List<String>,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<ServiceEntity>,gallery: null == gallery ? _self._gallery : gallery // ignore: cast_nullable_to_non_nullable
as List<String>,coverPhoto: freezed == coverPhoto ? _self.coverPhoto : coverPhoto // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
