import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselModel {
  String? id;
  String? datetime;
  String? from;
  String? gender;

  CarouselModel({
    this.id,
    this.datetime,
    this.from,
    this.gender,
  });

  factory CarouselModel.fromJson(Map<String, dynamic> json) => CarouselModel(
        datetime: json['datetime'],
        from: json['from'],
        gender: json['gender'],
      );

  factory CarouselModel.fromSnapShot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    var carousel = CarouselModel.fromJson(
        queryDocumentSnapshot.data() as Map<String, dynamic>);
    carousel.id = queryDocumentSnapshot.id;
    return carousel;
  }
}
