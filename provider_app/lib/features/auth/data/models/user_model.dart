import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/features/auth/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required UserRole role,
    String? name,
    String? phone,
    String? email,
    String? photoUrl,
    @Default(true) bool isActive,
    String? fcmToken,
    @TimestampConverter() DateTime? createdAt,
    String? walletId,
    String? referralCode,
    AddressModel? address,
    @Default(0.0) double rating,
    @Default(0) int totalRatings,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return UserModel.fromJson(data);
  }

  UserEntity toEntity() => UserEntity(
        uid: uid,
        role: role,
        name: name,
        phone: phone,
        email: email,
        photoUrl: photoUrl,
        isActive: isActive,
        fcmToken: fcmToken,
        createdAt: createdAt,
        walletId: walletId,
        referralCode: referralCode,
        address: address?.toEntity(),
        rating: rating,
        totalRatings: totalRatings,
      );
}

@freezed
abstract class AddressModel with _$AddressModel {
  const factory AddressModel({
    String? street,
    String? city,
    String? state,
    double? lat,
    double? lng,
    String? pincode,
  }) = _AddressModel;

  const AddressModel._();

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);

  AddressEntity toEntity() => AddressEntity(
        street: street,
        city: city,
        state: state,
        lat: lat,
        lng: lng,
        pincode: pincode,
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
  dynamic toJson(DateTime? date) => date?.toIso8601String();
}
