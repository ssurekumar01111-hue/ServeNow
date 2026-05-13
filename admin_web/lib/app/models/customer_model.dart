class CustomerModel {
  String? id;
  String? fullName;
  String? email;
  String? profileImage;
  String? phoneNumber;
  bool? isActive;
  bool? isBlocked;
  bool? isDeleted;

  CustomerModel({
    this.id,
    this.fullName,
    this.email,
    this.profileImage,
    this.phoneNumber,
    this.isActive,
    this.isBlocked,
    this.isDeleted,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    profileImage = json['profileImage'];
    phoneNumber = json['phoneNumber'];
    isActive = json['isActive'];
    isBlocked = json['isBlocked'] ?? false;
    isDeleted = json['isDeleted'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['email'] = email;
    data['profileImage'] = profileImage;
    data['phoneNumber'] = phoneNumber;
    data['isActive'] = isActive;
    data['isBlocked'] = isBlocked;
    data['isDeleted'] = isDeleted;
    return data;
  }
}
