import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String? id;
  String? name;
  String? fullName;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? role;
  bool? isActive;
  Timestamp? createdAt;

  AdminModel({
    this.id,
    this.name,
    this.fullName,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.role,
    this.isActive,
    this.createdAt,
  });

  AdminModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullName = json['fullName'];
    email = json['email'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['fullName'] = fullName;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['phoneNumber'] = phoneNumber;
    data['role'] = role;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    return data;
  }
}
