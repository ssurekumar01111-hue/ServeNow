// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earning_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarningEntity {

 double get totalEarnings; double get totalWithdrawn; double get availableBalance; List<TransactionEntity> get transactions;
/// Create a copy of EarningEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningEntityCopyWith<EarningEntity> get copyWith => _$EarningEntityCopyWithImpl<EarningEntity>(this as EarningEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningEntity&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.totalWithdrawn, totalWithdrawn) || other.totalWithdrawn == totalWithdrawn)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&const DeepCollectionEquality().equals(other.transactions, transactions));
}


@override
int get hashCode => Object.hash(runtimeType,totalEarnings,totalWithdrawn,availableBalance,const DeepCollectionEquality().hash(transactions));

@override
String toString() {
  return 'EarningEntity(totalEarnings: $totalEarnings, totalWithdrawn: $totalWithdrawn, availableBalance: $availableBalance, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $EarningEntityCopyWith<$Res>  {
  factory $EarningEntityCopyWith(EarningEntity value, $Res Function(EarningEntity) _then) = _$EarningEntityCopyWithImpl;
@useResult
$Res call({
 double totalEarnings, double totalWithdrawn, double availableBalance, List<TransactionEntity> transactions
});




}
/// @nodoc
class _$EarningEntityCopyWithImpl<$Res>
    implements $EarningEntityCopyWith<$Res> {
  _$EarningEntityCopyWithImpl(this._self, this._then);

  final EarningEntity _self;
  final $Res Function(EarningEntity) _then;

/// Create a copy of EarningEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalEarnings = null,Object? totalWithdrawn = null,Object? availableBalance = null,Object? transactions = null,}) {
  return _then(_self.copyWith(
totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,totalWithdrawn: null == totalWithdrawn ? _self.totalWithdrawn : totalWithdrawn // ignore: cast_nullable_to_non_nullable
as double,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [EarningEntity].
extension EarningEntityPatterns on EarningEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningEntity value)  $default,){
final _that = this;
switch (_that) {
case _EarningEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningEntity value)?  $default,){
final _that = this;
switch (_that) {
case _EarningEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double totalEarnings,  double totalWithdrawn,  double availableBalance,  List<TransactionEntity> transactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningEntity() when $default != null:
return $default(_that.totalEarnings,_that.totalWithdrawn,_that.availableBalance,_that.transactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double totalEarnings,  double totalWithdrawn,  double availableBalance,  List<TransactionEntity> transactions)  $default,) {final _that = this;
switch (_that) {
case _EarningEntity():
return $default(_that.totalEarnings,_that.totalWithdrawn,_that.availableBalance,_that.transactions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double totalEarnings,  double totalWithdrawn,  double availableBalance,  List<TransactionEntity> transactions)?  $default,) {final _that = this;
switch (_that) {
case _EarningEntity() when $default != null:
return $default(_that.totalEarnings,_that.totalWithdrawn,_that.availableBalance,_that.transactions);case _:
  return null;

}
}

}

/// @nodoc


class _EarningEntity extends EarningEntity {
  const _EarningEntity({required this.totalEarnings, required this.totalWithdrawn, required this.availableBalance, required final  List<TransactionEntity> transactions}): _transactions = transactions,super._();
  

@override final  double totalEarnings;
@override final  double totalWithdrawn;
@override final  double availableBalance;
 final  List<TransactionEntity> _transactions;
@override List<TransactionEntity> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of EarningEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningEntityCopyWith<_EarningEntity> get copyWith => __$EarningEntityCopyWithImpl<_EarningEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningEntity&&(identical(other.totalEarnings, totalEarnings) || other.totalEarnings == totalEarnings)&&(identical(other.totalWithdrawn, totalWithdrawn) || other.totalWithdrawn == totalWithdrawn)&&(identical(other.availableBalance, availableBalance) || other.availableBalance == availableBalance)&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}


@override
int get hashCode => Object.hash(runtimeType,totalEarnings,totalWithdrawn,availableBalance,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'EarningEntity(totalEarnings: $totalEarnings, totalWithdrawn: $totalWithdrawn, availableBalance: $availableBalance, transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$EarningEntityCopyWith<$Res> implements $EarningEntityCopyWith<$Res> {
  factory _$EarningEntityCopyWith(_EarningEntity value, $Res Function(_EarningEntity) _then) = __$EarningEntityCopyWithImpl;
@override @useResult
$Res call({
 double totalEarnings, double totalWithdrawn, double availableBalance, List<TransactionEntity> transactions
});




}
/// @nodoc
class __$EarningEntityCopyWithImpl<$Res>
    implements _$EarningEntityCopyWith<$Res> {
  __$EarningEntityCopyWithImpl(this._self, this._then);

  final _EarningEntity _self;
  final $Res Function(_EarningEntity) _then;

/// Create a copy of EarningEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalEarnings = null,Object? totalWithdrawn = null,Object? availableBalance = null,Object? transactions = null,}) {
  return _then(_EarningEntity(
totalEarnings: null == totalEarnings ? _self.totalEarnings : totalEarnings // ignore: cast_nullable_to_non_nullable
as double,totalWithdrawn: null == totalWithdrawn ? _self.totalWithdrawn : totalWithdrawn // ignore: cast_nullable_to_non_nullable
as double,availableBalance: null == availableBalance ? _self.availableBalance : availableBalance // ignore: cast_nullable_to_non_nullable
as double,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionEntity>,
  ));
}


}

/// @nodoc
mixin _$TransactionEntity {

 String get id; String? get bookingId; double get amount; double? get commission; double? get netAmount; DateTime get createdAt; String get type;// booking | withdrawal
 String get status;// pending | completed | rejected
 String? get rejectionReason; Map<String, dynamic>? get bankDetails; DateTime? get requestedAt;
/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionEntityCopyWith<TransactionEntity> get copyWith => _$TransactionEntityCopyWithImpl<TransactionEntity>(this as TransactionEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&const DeepCollectionEquality().equals(other.bankDetails, bankDetails)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,amount,commission,netAmount,createdAt,type,status,rejectionReason,const DeepCollectionEquality().hash(bankDetails),requestedAt);

@override
String toString() {
  return 'TransactionEntity(id: $id, bookingId: $bookingId, amount: $amount, commission: $commission, netAmount: $netAmount, createdAt: $createdAt, type: $type, status: $status, rejectionReason: $rejectionReason, bankDetails: $bankDetails, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class $TransactionEntityCopyWith<$Res>  {
  factory $TransactionEntityCopyWith(TransactionEntity value, $Res Function(TransactionEntity) _then) = _$TransactionEntityCopyWithImpl;
@useResult
$Res call({
 String id, String? bookingId, double amount, double? commission, double? netAmount, DateTime createdAt, String type, String status, String? rejectionReason, Map<String, dynamic>? bankDetails, DateTime? requestedAt
});




}
/// @nodoc
class _$TransactionEntityCopyWithImpl<$Res>
    implements $TransactionEntityCopyWith<$Res> {
  _$TransactionEntityCopyWithImpl(this._self, this._then);

  final TransactionEntity _self;
  final $Res Function(TransactionEntity) _then;

/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookingId = freezed,Object? amount = null,Object? commission = freezed,Object? netAmount = freezed,Object? createdAt = null,Object? type = null,Object? status = null,Object? rejectionReason = freezed,Object? bankDetails = freezed,Object? requestedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,commission: freezed == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as double?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,bankDetails: freezed == bankDetails ? _self.bankDetails : bankDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionEntity].
extension TransactionEntityPatterns on TransactionEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionEntity value)  $default,){
final _that = this;
switch (_that) {
case _TransactionEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? bookingId,  double amount,  double? commission,  double? netAmount,  DateTime createdAt,  String type,  String status,  String? rejectionReason,  Map<String, dynamic>? bankDetails,  DateTime? requestedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
return $default(_that.id,_that.bookingId,_that.amount,_that.commission,_that.netAmount,_that.createdAt,_that.type,_that.status,_that.rejectionReason,_that.bankDetails,_that.requestedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? bookingId,  double amount,  double? commission,  double? netAmount,  DateTime createdAt,  String type,  String status,  String? rejectionReason,  Map<String, dynamic>? bankDetails,  DateTime? requestedAt)  $default,) {final _that = this;
switch (_that) {
case _TransactionEntity():
return $default(_that.id,_that.bookingId,_that.amount,_that.commission,_that.netAmount,_that.createdAt,_that.type,_that.status,_that.rejectionReason,_that.bankDetails,_that.requestedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? bookingId,  double amount,  double? commission,  double? netAmount,  DateTime createdAt,  String type,  String status,  String? rejectionReason,  Map<String, dynamic>? bankDetails,  DateTime? requestedAt)?  $default,) {final _that = this;
switch (_that) {
case _TransactionEntity() when $default != null:
return $default(_that.id,_that.bookingId,_that.amount,_that.commission,_that.netAmount,_that.createdAt,_that.type,_that.status,_that.rejectionReason,_that.bankDetails,_that.requestedAt);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionEntity extends TransactionEntity {
  const _TransactionEntity({required this.id, this.bookingId, required this.amount, this.commission, this.netAmount, required this.createdAt, required this.type, this.status = 'completed', this.rejectionReason, final  Map<String, dynamic>? bankDetails, this.requestedAt}): _bankDetails = bankDetails,super._();
  

@override final  String id;
@override final  String? bookingId;
@override final  double amount;
@override final  double? commission;
@override final  double? netAmount;
@override final  DateTime createdAt;
@override final  String type;
// booking | withdrawal
@override@JsonKey() final  String status;
// pending | completed | rejected
@override final  String? rejectionReason;
 final  Map<String, dynamic>? _bankDetails;
@override Map<String, dynamic>? get bankDetails {
  final value = _bankDetails;
  if (value == null) return null;
  if (_bankDetails is EqualUnmodifiableMapView) return _bankDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  DateTime? requestedAt;

/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionEntityCopyWith<_TransactionEntity> get copyWith => __$TransactionEntityCopyWithImpl<_TransactionEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.bookingId, bookingId) || other.bookingId == bookingId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.commission, commission) || other.commission == commission)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&const DeepCollectionEquality().equals(other._bankDetails, _bankDetails)&&(identical(other.requestedAt, requestedAt) || other.requestedAt == requestedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,bookingId,amount,commission,netAmount,createdAt,type,status,rejectionReason,const DeepCollectionEquality().hash(_bankDetails),requestedAt);

@override
String toString() {
  return 'TransactionEntity(id: $id, bookingId: $bookingId, amount: $amount, commission: $commission, netAmount: $netAmount, createdAt: $createdAt, type: $type, status: $status, rejectionReason: $rejectionReason, bankDetails: $bankDetails, requestedAt: $requestedAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionEntityCopyWith<$Res> implements $TransactionEntityCopyWith<$Res> {
  factory _$TransactionEntityCopyWith(_TransactionEntity value, $Res Function(_TransactionEntity) _then) = __$TransactionEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String? bookingId, double amount, double? commission, double? netAmount, DateTime createdAt, String type, String status, String? rejectionReason, Map<String, dynamic>? bankDetails, DateTime? requestedAt
});




}
/// @nodoc
class __$TransactionEntityCopyWithImpl<$Res>
    implements _$TransactionEntityCopyWith<$Res> {
  __$TransactionEntityCopyWithImpl(this._self, this._then);

  final _TransactionEntity _self;
  final $Res Function(_TransactionEntity) _then;

/// Create a copy of TransactionEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookingId = freezed,Object? amount = null,Object? commission = freezed,Object? netAmount = freezed,Object? createdAt = null,Object? type = null,Object? status = null,Object? rejectionReason = freezed,Object? bankDetails = freezed,Object? requestedAt = freezed,}) {
  return _then(_TransactionEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookingId: freezed == bookingId ? _self.bookingId : bookingId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,commission: freezed == commission ? _self.commission : commission // ignore: cast_nullable_to_non_nullable
as double?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,bankDetails: freezed == bankDetails ? _self._bankDetails : bankDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,requestedAt: freezed == requestedAt ? _self.requestedAt : requestedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
