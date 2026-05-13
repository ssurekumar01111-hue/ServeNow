import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    @Default(UserRole.customer) UserRole role,
    String? fullName,
    String? phone,
    String? email,
    String? photoUrl,
    @Default(false) bool isProfileComplete,
    @Default(false) bool isBlocked,
    @Default(false) bool isDeleted,
    String? defaultAddressId,
    String? fcmToken,
    String? authProvider,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    @TimestampConverter() DateTime? lastLoginAt,
    String? walletId,
    String? referralCode,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return UserModel.fromJson({
      ...data,
      'uid': doc.id,
      'role': data['role'] ?? 'customer',
    });
  }

  UserEntity toEntity() => UserEntity(
        uid: uid,
        role: role,
        fullName: fullName,
        phone: phone,
        email: email,
        photoUrl: photoUrl,
        isProfileComplete: isProfileComplete,
        isBlocked: isBlocked,
        isDeleted: isDeleted,
        defaultAddressId: defaultAddressId,
        fcmToken: fcmToken,
        authProvider: authProvider,
        createdAt: createdAt,
        updatedAt: updatedAt,
        lastLoginAt: lastLoginAt,
        walletId: walletId,
        referralCode: referralCode,
      );
}

@freezed
abstract class AddressModel with _$AddressModel {
  const factory AddressModel({
    String? id,
    @Default('Home') String label,
    String? fullAddress,
    String? area,
    String? city,
    String? state,
    double? lat,
    double? lng,
    String? pincode,
    @Default(false) bool isDefault,
    @TimestampConverter() DateTime? createdAt,
  }) = _AddressModel;

  const AddressModel._();

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  factory AddressModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return AddressModel.fromJson({
      ...data,
      'id': doc.id,
    });
  }

  AddressEntity toEntity() => AddressEntity(
        id: id,
        label: label,
        fullAddress: fullAddress,
        area: area,
        city: city,
        state: state,
        lat: lat,
        lng: lng,
        pincode: pincode,
        isDefault: isDefault,
        createdAt: createdAt,
      );
}

class TimestampConverter implements JsonConverter<DateTime?, dynamic> {
  const TimestampConverter();

  @override
  DateTime? fromJson(dynamic timestamp) {
    if (timestamp is Timestamp) return timestamp.toDate();
    if (timestamp is String) return DateTime.parse(timestamp);
    return null;
  }

  @override
  dynamic toJson(DateTime? date) => date != null ? Timestamp.fromDate(date) : null;
}
