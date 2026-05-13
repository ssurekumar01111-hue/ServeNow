// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProviderProfileEntity {

 String get id; String get uid; String get email; String get phone; String get businessName; String? get logoUrl; List<String> get categories; String get serviceArea; String? get idProofUrl; String? get idProofType; String? get bankAccountNumber; String? get bankIFSC; String? get bankAccountName; String? get gstNumber; double get commissionRate; String get onboardingStatus;// 'pending_profile' | 'pending_approval' | 'approved' | 'rejected'
 String? get rejectionReason; bool get isActive; double get rating; int get totalRatings; int get totalBookings; double get totalEarnings; double get walletBalance; DateTime get createdAt; DateTime get updatedAt; DateTime? get approvedAt; String? get approvedBy; String? get description; String? get businessLicenseUrl;
/// Create a copy of ProviderProfileEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProviderProfileEntityCopyWith<ProviderProfileEntity> get copyWith => _$ProviderProfileEntityCopyWithImpl<ProviderProfileEntity>(this as ProviderProfileEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProviderProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.serviceArea, serviceArea) || other.serviceArea == serviceArea)&&(identical(other.idProofUrl, idProofUrl) || other.idProofUrl == idProofUrl)&&(identical(other.idProofType, idProofType) || other.idProofType == idProofType)&&(identical(other.bankAccountNumber, bankAccountNumber) || other.bankAccountNumber == bankAccountNumber)&&(identical(other.bankIFSC, bankIFSC) || other.bankIFSC == bankIFSC)&&(identical(other.bankAccountName, bankAccountName) || other.bankAccountName == bankAccountName)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.totalBookings, totalBookings) || other.totalBookings == totalBookings)&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.description, description) || other.description == description)&&(identical(other.businessLicenseUrl, businessLicenseUrl) || other.businessLicenseUrl == businessLicenseUrl));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,uid,email,phone,businessName,logoUrl,const DeepCollectionEquality().hash(categories),serviceArea,idProofUrl,idProofType,bankAccountNumber,bankIFSC,bankAccountName,gstNumber,commissionRate,onboardingStatus,rejectionReason,isActive,rating,totalRatings,totalBookings,totalEarnings,walletBalance,createdAt,updatedAt,approvedAt,approvedBy,description,businessLicenseUrl]);

@override
String toString() {
  return 'ProviderProfileEntity(id: $id, uid: $uid, email: $email, phone: $phone, businessName: $businessName, logoUrl: $logoUrl, categories: $categories, serviceArea: $serviceArea, idProofUrl: $idProofUrl, idProofType: $idProofType, bankAccountNumber: $bankAccountNumber, bankIFSC: $bankIFSC, bankAccountName: $bankAccountName, gstNumber: $gstNumber, commissionRate: $commissionRate, onboardingStatus: $onboardingStatus, rejectionReason: $rejectionReason, isActive: $isActive, rating: $rating, totalRatings: $totalRatings, totalBookings: $totalBookings, totalEarnings: $totalEarnings, walletBalance: $walletBalance, createdAt: $createdAt, updatedAt: $updatedAt, approvedAt: $approvedAt, approvedBy: $approvedBy, description: $description, businessLicenseUrl: $businessLicenseUrl)';
}


}

/// @nodoc
abstract mixin class $ProviderProfileEntityCopyWith<$Res>  {
  factory $ProviderProfileEntityCopyWith(ProviderProfileEntity value, $Res Function(ProviderProfileEntity) _then) = _$ProviderProfileEntityCopyWithImpl;
@useResult
$Res call({
 String id, String uid, String email, String phone, String businessName, String? logoUrl, List<String> categories, String serviceArea, String? idProofUrl, String? idProofType, String? bankAccountNumber, String? bankIFSC, String? bankAccountName, String? gstNumber, double commissionRate, String onboardingStatus, String? rejectionReason, bool isActive, double rating, int totalRatings, int totalBookings, double totalEarnings, double walletBalance, DateTime createdAt, DateTime updatedAt, DateTime? approvedAt, String? approvedBy, String? description, String? businessLicenseUrl
});




}
/// @nodoc
class _$ProviderProfileEntityCopyWithImpl<$Res>
    implements $ProviderProfileEntityCopyWith<$Res> {
  _$ProviderProfileEntityCopyWithImpl(this._self, this._then);

  final ProviderProfileEntity _self;
  final $Res Function(ProviderProfileEntity) _then;

/// Create a copy of ProviderProfileEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? uid = null,Object? email = null,Object? phone = null,Object? businessName = null,Object? logoUrl = freezed,Object? categories = null,Object? serviceArea = null,Object? idProofUrl = freezed,Object? idProofType = freezed,Object? bankAccountNumber = freezed,Object? bankIFSC = freezed,Object? bankAccountName = freezed,Object? gstNumber = freezed,Object? commissionRate = null,Object? onboardingStatus = null,Object? rejectionReason = freezed,Object? isActive = null,Object? rating = null,Object? totalRatings = null,Object? totalBookings = null,Object? totalEarnings = null,Object? walletBalance = null,Object? createdAt = null,Object? updatedAt = null,Object? approvedAt = freezed,Object? approvedBy = freezed,Object? description = freezed,Object? businessLicenseUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,serviceArea: null == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as String,idProofUrl: freezed == idProofUrl ? _self.idProofUrl : idProofUrl // ignore: cast_nullable_to_non_nullable
as String?,idProofType: freezed == idProofType ? _self.idProofType : idProofType // ignore: cast_nullable_to_non_nullable
as String?,bankAccountNumber: freezed == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String?,bankIFSC: freezed == bankIFSC ? _self.bankIFSC : bankIFSC // ignore: cast_nullable_to_non_nullable
as String?,bankAccountName: freezed == bankAccountName ? _self.bankAccountName : bankAccountName // ignore: cast_nullable_to_non_nullable
as String?,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as double,onboardingStatus: null == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,totalBookings: null == totalBookings ? _self.totalBookings : totalBookings // ignore: cast_nullable_to_non_nullable
as int,totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,walletBalance: null == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,businessLicenseUrl: freezed == businessLicenseUrl ? _self.businessLicenseUrl : businessLicenseUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProviderProfileEntity].
extension ProviderProfileEntityPatterns on ProviderProfileEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProviderProfileEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProviderProfileEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProviderProfileEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProviderProfileEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProviderProfileEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProviderProfileEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String uid,  String email,  String phone,  String businessName,  String? logoUrl,  List<String> categories,  String serviceArea,  String? idProofUrl,  String? idProofType,  String? bankAccountNumber,  String? bankIFSC,  String? bankAccountName,  String? gstNumber,  double commissionRate,  String onboardingStatus,  String? rejectionReason,  bool isActive,  double rating,  int totalRatings,  int totalBookings,  double totalEarnings,  double walletBalance,  DateTime createdAt,  DateTime updatedAt,  DateTime? approvedAt,  String? approvedBy,  String? description,  String? businessLicenseUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProviderProfileEntity() when $default != null:
return $default(_that.id,_that.uid,_that.email,_that.phone,_that.businessName,_that.logoUrl,_that.categories,_that.serviceArea,_that.idProofUrl,_that.idProofType,_that.bankAccountNumber,_that.bankIFSC,_that.bankAccountName,_that.gstNumber,_that.commissionRate,_that.onboardingStatus,_that.rejectionReason,_that.isActive,_that.rating,_that.totalRatings,_that.totalBookings,_that.totalEarnings,_that.walletBalance,_that.createdAt,_that.updatedAt,_that.approvedAt,_that.approvedBy,_that.description,_that.businessLicenseUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String uid,  String email,  String phone,  String businessName,  String? logoUrl,  List<String> categories,  String serviceArea,  String? idProofUrl,  String? idProofType,  String? bankAccountNumber,  String? bankIFSC,  String? bankAccountName,  String? gstNumber,  double commissionRate,  String onboardingStatus,  String? rejectionReason,  bool isActive,  double rating,  int totalRatings,  int totalBookings,  double totalEarnings,  double walletBalance,  DateTime createdAt,  DateTime updatedAt,  DateTime? approvedAt,  String? approvedBy,  String? description,  String? businessLicenseUrl)  $default,) {final _that = this;
switch (_that) {
case _ProviderProfileEntity():
return $default(_that.id,_that.uid,_that.email,_that.phone,_that.businessName,_that.logoUrl,_that.categories,_that.serviceArea,_that.idProofUrl,_that.idProofType,_that.bankAccountNumber,_that.bankIFSC,_that.bankAccountName,_that.gstNumber,_that.commissionRate,_that.onboardingStatus,_that.rejectionReason,_that.isActive,_that.rating,_that.totalRatings,_that.totalBookings,_that.totalEarnings,_that.walletBalance,_that.createdAt,_that.updatedAt,_that.approvedAt,_that.approvedBy,_that.description,_that.businessLicenseUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String uid,  String email,  String phone,  String businessName,  String? logoUrl,  List<String> categories,  String serviceArea,  String? idProofUrl,  String? idProofType,  String? bankAccountNumber,  String? bankIFSC,  String? bankAccountName,  String? gstNumber,  double commissionRate,  String onboardingStatus,  String? rejectionReason,  bool isActive,  double rating,  int totalRatings,  int totalBookings,  double totalEarnings,  double walletBalance,  DateTime createdAt,  DateTime updatedAt,  DateTime? approvedAt,  String? approvedBy,  String? description,  String? businessLicenseUrl)?  $default,) {final _that = this;
switch (_that) {
case _ProviderProfileEntity() when $default != null:
return $default(_that.id,_that.uid,_that.email,_that.phone,_that.businessName,_that.logoUrl,_that.categories,_that.serviceArea,_that.idProofUrl,_that.idProofType,_that.bankAccountNumber,_that.bankIFSC,_that.bankAccountName,_that.gstNumber,_that.commissionRate,_that.onboardingStatus,_that.rejectionReason,_that.isActive,_that.rating,_that.totalRatings,_that.totalBookings,_that.totalEarnings,_that.walletBalance,_that.createdAt,_that.updatedAt,_that.approvedAt,_that.approvedBy,_that.description,_that.businessLicenseUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ProviderProfileEntity extends ProviderProfileEntity {
  const _ProviderProfileEntity({required this.id, required this.uid, required this.email, required this.phone, required this.businessName, this.logoUrl, required final  List<String> categories, required this.serviceArea, this.idProofUrl, this.idProofType, this.bankAccountNumber, this.bankIFSC, this.bankAccountName, this.gstNumber, required this.commissionRate, required this.onboardingStatus, this.rejectionReason, required this.isActive, required this.rating, required this.totalRatings, required this.totalBookings, required this.totalEarnings, this.walletBalance = 0.0, required this.createdAt, required this.updatedAt, this.approvedAt, this.approvedBy, this.description, this.businessLicenseUrl}): _categories = categories,super._();
  

@override final  String id;
@override final  String uid;
@override final  String email;
@override final  String phone;
@override final  String businessName;
@override final  String? logoUrl;
 final  List<String> _categories;
@override List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override final  String serviceArea;
@override final  String? idProofUrl;
@override final  String? idProofType;
@override final  String? bankAccountNumber;
@override final  String? bankIFSC;
@override final  String? bankAccountName;
@override final  String? gstNumber;
@override final  double commissionRate;
@override final  String onboardingStatus;
// 'pending_profile' | 'pending_approval' | 'approved' | 'rejected'
@override final  String? rejectionReason;
@override final  bool isActive;
@override final  double rating;
@override final  int totalRatings;
@override final  int totalBookings;
@override final  double totalEarnings;
@override@JsonKey() final  double walletBalance;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  DateTime? approvedAt;
@override final  String? approvedBy;
@override final  String? description;
@override final  String? businessLicenseUrl;

/// Create a copy of ProviderProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProviderProfileEntityCopyWith<_ProviderProfileEntity> get copyWith => __$ProviderProfileEntityCopyWithImpl<_ProviderProfileEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProviderProfileEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.serviceArea, serviceArea) || other.serviceArea == serviceArea)&&(identical(other.idProofUrl, idProofUrl) || other.idProofUrl == idProofUrl)&&(identical(other.idProofType, idProofType) || other.idProofType == idProofType)&&(identical(other.bankAccountNumber, bankAccountNumber) || other.bankAccountNumber == bankAccountNumber)&&(identical(other.bankIFSC, bankIFSC) || other.bankIFSC == bankIFSC)&&(identical(other.bankAccountName, bankAccountName) || other.bankAccountName == bankAccountName)&&(identical(other.gstNumber, gstNumber) || other.gstNumber == gstNumber)&&(identical(other.commissionRate, commissionRate) || other.commissionRate == commissionRate)&&(identical(other.onboardingStatus, onboardingStatus) || other.onboardingStatus == onboardingStatus)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.totalRatings, totalRatings) || other.totalRatings == totalRatings)&&(identical(other.totalBookings, totalBookings) || other.totalBookings == totalBookings)&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.approvedAt, approvedAt) || other.approvedAt == approvedAt)&&(identical(other.approvedBy, approvedBy) || other.approvedBy == approvedBy)&&(identical(other.description, description) || other.description == description)&&(identical(other.businessLicenseUrl, businessLicenseUrl) || other.businessLicenseUrl == businessLicenseUrl));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,uid,email,phone,businessName,logoUrl,const DeepCollectionEquality().hash(_categories),serviceArea,idProofUrl,idProofType,bankAccountNumber,bankIFSC,bankAccountName,gstNumber,commissionRate,onboardingStatus,rejectionReason,isActive,rating,totalRatings,totalBookings,totalEarnings,walletBalance,createdAt,updatedAt,approvedAt,approvedBy,description,businessLicenseUrl]);

@override
String toString() {
  return 'ProviderProfileEntity(id: $id, uid: $uid, email: $email, phone: $phone, businessName: $businessName, logoUrl: $logoUrl, categories: $categories, serviceArea: $serviceArea, idProofUrl: $idProofUrl, idProofType: $idProofType, bankAccountNumber: $bankAccountNumber, bankIFSC: $bankIFSC, bankAccountName: $bankAccountName, gstNumber: $gstNumber, commissionRate: $commissionRate, onboardingStatus: $onboardingStatus, rejectionReason: $rejectionReason, isActive: $isActive, rating: $rating, totalRatings: $totalRatings, totalBookings: $totalBookings, totalEarnings: $totalEarnings, walletBalance: $walletBalance, createdAt: $createdAt, updatedAt: $updatedAt, approvedAt: $approvedAt, approvedBy: $approvedBy, description: $description, businessLicenseUrl: $businessLicenseUrl)';
}


}

/// @nodoc
abstract mixin class _$ProviderProfileEntityCopyWith<$Res> implements $ProviderProfileEntityCopyWith<$Res> {
  factory _$ProviderProfileEntityCopyWith(_ProviderProfileEntity value, $Res Function(_ProviderProfileEntity) _then) = __$ProviderProfileEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String uid, String email, String phone, String businessName, String? logoUrl, List<String> categories, String serviceArea, String? idProofUrl, String? idProofType, String? bankAccountNumber, String? bankIFSC, String? bankAccountName, String? gstNumber, double commissionRate, String onboardingStatus, String? rejectionReason, bool isActive, double rating, int totalRatings, int totalBookings, double totalEarnings, double walletBalance, DateTime createdAt, DateTime updatedAt, DateTime? approvedAt, String? approvedBy, String? description, String? businessLicenseUrl
});




}
/// @nodoc
class __$ProviderProfileEntityCopyWithImpl<$Res>
    implements _$ProviderProfileEntityCopyWith<$Res> {
  __$ProviderProfileEntityCopyWithImpl(this._self, this._then);

  final _ProviderProfileEntity _self;
  final $Res Function(_ProviderProfileEntity) _then;

/// Create a copy of ProviderProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uid = null,Object? email = null,Object? phone = null,Object? businessName = null,Object? logoUrl = freezed,Object? categories = null,Object? serviceArea = null,Object? idProofUrl = freezed,Object? idProofType = freezed,Object? bankAccountNumber = freezed,Object? bankIFSC = freezed,Object? bankAccountName = freezed,Object? gstNumber = freezed,Object? commissionRate = null,Object? onboardingStatus = null,Object? rejectionReason = freezed,Object? isActive = null,Object? rating = null,Object? totalRatings = null,Object? totalBookings = null,Object? totalEarnings = null,Object? walletBalance = null,Object? createdAt = null,Object? updatedAt = null,Object? approvedAt = freezed,Object? approvedBy = freezed,Object? description = freezed,Object? businessLicenseUrl = freezed,}) {
  return _then(_ProviderProfileEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,serviceArea: null == serviceArea ? _self.serviceArea : serviceArea // ignore: cast_nullable_to_non_nullable
as String,idProofUrl: freezed == idProofUrl ? _self.idProofUrl : idProofUrl // ignore: cast_nullable_to_non_nullable
as String?,idProofType: freezed == idProofType ? _self.idProofType : idProofType // ignore: cast_nullable_to_non_nullable
as String?,bankAccountNumber: freezed == bankAccountNumber ? _self.bankAccountNumber : bankAccountNumber // ignore: cast_nullable_to_non_nullable
as String?,bankIFSC: freezed == bankIFSC ? _self.bankIFSC : bankIFSC // ignore: cast_nullable_to_non_nullable
as String?,bankAccountName: freezed == bankAccountName ? _self.bankAccountName : bankAccountName // ignore: cast_nullable_to_non_nullable
as String?,gstNumber: freezed == gstNumber ? _self.gstNumber : gstNumber // ignore: cast_nullable_to_non_nullable
as String?,commissionRate: null == commissionRate ? _self.commissionRate : commissionRate // ignore: cast_nullable_to_non_nullable
as double,onboardingStatus: null == onboardingStatus ? _self.onboardingStatus : onboardingStatus // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,totalRatings: null == totalRatings ? _self.totalRatings : totalRatings // ignore: cast_nullable_to_non_nullable
as int,totalBookings: null == totalBookings ? _self.totalBookings : totalBookings // ignore: cast_nullable_to_non_nullable
as int,totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,walletBalance: null == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,approvedAt: freezed == approvedAt ? _self.approvedAt : approvedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,approvedBy: freezed == approvedBy ? _self.approvedBy : approvedBy // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,businessLicenseUrl: freezed == businessLicenseUrl ? _self.businessLicenseUrl : businessLicenseUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
