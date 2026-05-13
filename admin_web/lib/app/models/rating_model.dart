import 'package:cloud_firestore/cloud_firestore.dart';

class RatingModel {
  String? id;
  String? bookingId;
  String? customerId;
  String? customerName;
  String? serviceId;
  String? providerId;
  String? handymanId;
  double? rating;
  double? providerRating;
  double? handymanRating;
  String? comment;
  String? review;
  List<String>? images;
  bool? isVisible;
  Timestamp? createdAt;

  RatingModel({
    this.id,
    this.bookingId,
    this.customerId,
    this.customerName,
    this.serviceId,
    this.providerId,
    this.handymanId,
    this.rating,
    this.providerRating,
    this.handymanRating,
    this.comment,
    this.review,
    this.images,
    this.isVisible,
    this.createdAt,
  });

  RatingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    serviceId = json['serviceId'];
    providerId = json['providerId'];
    handymanId = json['handymanId'];
    rating = json['rating']?.toDouble();
    providerRating = json['providerRating']?.toDouble();
    handymanRating = json['handymanRating']?.toDouble();
    comment = json['comment'];
    review = json['review'];
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    isVisible = json['isVisible'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookingId'] = bookingId;
    data['customerId'] = customerId;
    data['customerName'] = customerName;
    data['serviceId'] = serviceId;
    data['providerId'] = providerId;
    data['handymanId'] = handymanId;
    data['rating'] = rating;
    data['providerRating'] = providerRating;
    data['handymanRating'] = handymanRating;
    data['comment'] = comment;
    data['review'] = review;
    data['images'] = images;
    data['isVisible'] = isVisible;
    data['createdAt'] = createdAt;
    return data;
  }
}
