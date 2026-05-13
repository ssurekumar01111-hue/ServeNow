// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceEntity {

 String get id; String get name; String get categoryId; String get description; double get basePrice; bool get isActive; Map<String, dynamic> get workingHours; int get estimatedDuration; List<ServicePackage> get packages; List<String> get images;
/// Create a copy of ServiceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceEntityCopyWith<ServiceEntity> get copyWith => _$ServiceEntityCopyWithImpl<ServiceEntity>(this as ServiceEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.workingHours, workingHours)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&const DeepCollectionEquality().equals(other.packages, packages)&&const DeepCollectionEquality().equals(other.images, images));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,categoryId,description,basePrice,isActive,const DeepCollectionEquality().hash(workingHours),estimatedDuration,const DeepCollectionEquality().hash(packages),const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'ServiceEntity(id: $id, name: $name, categoryId: $categoryId, description: $description, basePrice: $basePrice, isActive: $isActive, workingHours: $workingHours, estimatedDuration: $estimatedDuration, packages: $packages, images: $images)';
}


}

/// @nodoc
abstract mixin class $ServiceEntityCopyWith<$Res>  {
  factory $ServiceEntityCopyWith(ServiceEntity value, $Res Function(ServiceEntity) _then) = _$ServiceEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String categoryId, String description, double basePrice, bool isActive, Map<String, dynamic> workingHours, int estimatedDuration, List<ServicePackage> packages, List<String> images
});




}
/// @nodoc
class _$ServiceEntityCopyWithImpl<$Res>
    implements $ServiceEntityCopyWith<$Res> {
  _$ServiceEntityCopyWithImpl(this._self, this._then);

  final ServiceEntity _self;
  final $Res Function(ServiceEntity) _then;

/// Create a copy of ServiceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? categoryId = null,Object? description = null,Object? basePrice = null,Object? isActive = null,Object? workingHours = null,Object? estimatedDuration = null,Object? packages = null,Object? images = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,workingHours: null == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,estimatedDuration: null == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int,packages: null == packages ? _self.packages : packages // ignore: cast_nullable_to_non_nullable
as List<ServicePackage>,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceEntity].
extension ServiceEntityPatterns on ServiceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceEntity value)  $default,){
final _that = this;
switch (_that) {
case _ServiceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String categoryId,  String description,  double basePrice,  bool isActive,  Map<String, dynamic> workingHours,  int estimatedDuration,  List<ServicePackage> packages,  List<String> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceEntity() when $default != null:
return $default(_that.id,_that.name,_that.categoryId,_that.description,_that.basePrice,_that.isActive,_that.workingHours,_that.estimatedDuration,_that.packages,_that.images);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String categoryId,  String description,  double basePrice,  bool isActive,  Map<String, dynamic> workingHours,  int estimatedDuration,  List<ServicePackage> packages,  List<String> images)  $default,) {final _that = this;
switch (_that) {
case _ServiceEntity():
return $default(_that.id,_that.name,_that.categoryId,_that.description,_that.basePrice,_that.isActive,_that.workingHours,_that.estimatedDuration,_that.packages,_that.images);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String categoryId,  String description,  double basePrice,  bool isActive,  Map<String, dynamic> workingHours,  int estimatedDuration,  List<ServicePackage> packages,  List<String> images)?  $default,) {final _that = this;
switch (_that) {
case _ServiceEntity() when $default != null:
return $default(_that.id,_that.name,_that.categoryId,_that.description,_that.basePrice,_that.isActive,_that.workingHours,_that.estimatedDuration,_that.packages,_that.images);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceEntity extends ServiceEntity {
  const _ServiceEntity({required this.id, required this.name, required this.categoryId, required this.description, required this.basePrice, required this.isActive, required final  Map<String, dynamic> workingHours, required this.estimatedDuration, final  List<ServicePackage> packages = const [], final  List<String> images = const []}): _workingHours = workingHours,_packages = packages,_images = images,super._();
  

@override final  String id;
@override final  String name;
@override final  String categoryId;
@override final  String description;
@override final  double basePrice;
@override final  bool isActive;
 final  Map<String, dynamic> _workingHours;
@override Map<String, dynamic> get workingHours {
  if (_workingHours is EqualUnmodifiableMapView) return _workingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_workingHours);
}

@override final  int estimatedDuration;
 final  List<ServicePackage> _packages;
@override@JsonKey() List<ServicePackage> get packages {
  if (_packages is EqualUnmodifiableListView) return _packages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_packages);
}

 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of ServiceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceEntityCopyWith<_ServiceEntity> get copyWith => __$ServiceEntityCopyWithImpl<_ServiceEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.description, description) || other.description == description)&&(identical(other.basePrice, basePrice) || other.basePrice == basePrice)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._workingHours, _workingHours)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&const DeepCollectionEquality().equals(other._packages, _packages)&&const DeepCollectionEquality().equals(other._images, _images));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,categoryId,description,basePrice,isActive,const DeepCollectionEquality().hash(_workingHours),estimatedDuration,const DeepCollectionEquality().hash(_packages),const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'ServiceEntity(id: $id, name: $name, categoryId: $categoryId, description: $description, basePrice: $basePrice, isActive: $isActive, workingHours: $workingHours, estimatedDuration: $estimatedDuration, packages: $packages, images: $images)';
}


}

/// @nodoc
abstract mixin class _$ServiceEntityCopyWith<$Res> implements $ServiceEntityCopyWith<$Res> {
  factory _$ServiceEntityCopyWith(_ServiceEntity value, $Res Function(_ServiceEntity) _then) = __$ServiceEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String categoryId, String description, double basePrice, bool isActive, Map<String, dynamic> workingHours, int estimatedDuration, List<ServicePackage> packages, List<String> images
});




}
/// @nodoc
class __$ServiceEntityCopyWithImpl<$Res>
    implements _$ServiceEntityCopyWith<$Res> {
  __$ServiceEntityCopyWithImpl(this._self, this._then);

  final _ServiceEntity _self;
  final $Res Function(_ServiceEntity) _then;

/// Create a copy of ServiceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? categoryId = null,Object? description = null,Object? basePrice = null,Object? isActive = null,Object? workingHours = null,Object? estimatedDuration = null,Object? packages = null,Object? images = null,}) {
  return _then(_ServiceEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,basePrice: null == basePrice ? _self.basePrice : basePrice // ignore: cast_nullable_to_non_nullable
as double,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,workingHours: null == workingHours ? _self._workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,estimatedDuration: null == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as int,packages: null == packages ? _self._packages : packages // ignore: cast_nullable_to_non_nullable
as List<ServicePackage>,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$ServicePackage {

 String get name; String get description; double get price; int get duration;
/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicePackageCopyWith<ServicePackage> get copyWith => _$ServicePackageCopyWithImpl<ServicePackage>(this as ServicePackage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicePackage&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,price,duration);

@override
String toString() {
  return 'ServicePackage(name: $name, description: $description, price: $price, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $ServicePackageCopyWith<$Res>  {
  factory $ServicePackageCopyWith(ServicePackage value, $Res Function(ServicePackage) _then) = _$ServicePackageCopyWithImpl;
@useResult
$Res call({
 String name, String description, double price, int duration
});




}
/// @nodoc
class _$ServicePackageCopyWithImpl<$Res>
    implements $ServicePackageCopyWith<$Res> {
  _$ServicePackageCopyWithImpl(this._self, this._then);

  final ServicePackage _self;
  final $Res Function(ServicePackage) _then;

/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? price = null,Object? duration = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ServicePackage].
extension ServicePackagePatterns on ServicePackage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServicePackage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServicePackage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServicePackage value)  $default,){
final _that = this;
switch (_that) {
case _ServicePackage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServicePackage value)?  $default,){
final _that = this;
switch (_that) {
case _ServicePackage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  double price,  int duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServicePackage() when $default != null:
return $default(_that.name,_that.description,_that.price,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  double price,  int duration)  $default,) {final _that = this;
switch (_that) {
case _ServicePackage():
return $default(_that.name,_that.description,_that.price,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  double price,  int duration)?  $default,) {final _that = this;
switch (_that) {
case _ServicePackage() when $default != null:
return $default(_that.name,_that.description,_that.price,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _ServicePackage extends ServicePackage {
  const _ServicePackage({required this.name, required this.description, required this.price, required this.duration}): super._();
  

@override final  String name;
@override final  String description;
@override final  double price;
@override final  int duration;

/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicePackageCopyWith<_ServicePackage> get copyWith => __$ServicePackageCopyWithImpl<_ServicePackage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicePackage&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,price,duration);

@override
String toString() {
  return 'ServicePackage(name: $name, description: $description, price: $price, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$ServicePackageCopyWith<$Res> implements $ServicePackageCopyWith<$Res> {
  factory _$ServicePackageCopyWith(_ServicePackage value, $Res Function(_ServicePackage) _then) = __$ServicePackageCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, double price, int duration
});




}
/// @nodoc
class __$ServicePackageCopyWithImpl<$Res>
    implements _$ServicePackageCopyWith<$Res> {
  __$ServicePackageCopyWithImpl(this._self, this._then);

  final _ServicePackage _self;
  final $Res Function(_ServicePackage) _then;

/// Create a copy of ServicePackage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? price = null,Object? duration = null,}) {
  return _then(_ServicePackage(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
