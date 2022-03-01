import 'package:cloud_firestore/cloud_firestore.dart';

class StatusModel {
  String? id;
  String? shopId;
  String? userId;
  int? status;
  DateTime? bookingDatetime;
  DateTime? bookByDatetime;
  List<dynamic?>? services;
  int? price;

  StatusModel({
    this.id,
    this.shopId,
    this.userId,
    this.status,
    this.bookByDatetime,
    this.bookingDatetime,
    this.services,
    this.price,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        shopId: json['shopId'],
        userId: json['userId'],
        status: json['status'] as int,
        bookByDatetime: json['by'].toDate(),
        bookingDatetime: json['bookDate'].toDate(),
        services: json['service'],
        price: json['price'],
      );

  factory StatusModel.fromSnapShot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    var booking = StatusModel.fromJson(
        queryDocumentSnapshot.data() as Map<String, dynamic>);
    booking.id = queryDocumentSnapshot.id;
    return booking;
  }
}
