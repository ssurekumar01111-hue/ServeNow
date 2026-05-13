import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String? id;
  String? name;
  String? description;
  double? price;
  double? basePrice;
  String? categoryId;
  String? categoryName;
  String? providerId;
  String? image;
  String? imageUrl;
  String? iconUrl;
  String? duration;
  String? priceType;
  int? sortOrder;
  bool? isActive;
  Timestamp? createdAt;
  Timestamp? updatedAt;

  ServiceModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.basePrice,
    this.categoryId,
    this.categoryName,
    this.providerId,
    this.image,
    this.imageUrl,
    this.iconUrl,
    this.duration,
    this.priceType,
    this.sortOrder,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price']?.toDouble();
    basePrice = json['basePrice']?.toDouble();
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    providerId = json['providerId'];
    image = json['image'];
    imageUrl = json['imageUrl'];
    iconUrl = json['iconUrl'];
    duration = json['duration'];
    priceType = json['priceType'];
    sortOrder = json['sortOrder'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['basePrice'] = basePrice;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['providerId'] = providerId;
    data['image'] = image;
    data['imageUrl'] = imageUrl;
    data['iconUrl'] = iconUrl;
    data['duration'] = duration;
    data['priceType'] = priceType;
    data['sortOrder'] = sortOrder;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
