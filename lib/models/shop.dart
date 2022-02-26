import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class ShopModel {
  String? id;
  String? address;
  String? addressZh;
  LatLng? latLon;
  String? img;
  String? name;
  String? description;
  String? openHour;
  int? tel;
  List<dynamic>? rating;
  Map<String, dynamic>? services;

  ShopModel({
    this.id,
    this.address,
    this.addressZh,
    this.latLon,
    this.img,
    this.tel,
    this.name,
    this.openHour,
    this.description,
    this.rating,
    this.services,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        address: json['address'],
        addressZh: json['address_zh'],
        latLon: LatLng(json['lat_lon'].latitude, json['lat_lon'].longitude),
        img: json['image'],
        name: json['name'],
        openHour: json['openHour'],
        tel: json['tel'],
        description: json['description'],
        rating: json['rating']?.values.toList() ?? [],
        services: json['services'],
      );

  factory ShopModel.fromSnapShot(QueryDocumentSnapshot queryDocumentSnapshot) {
    var shop = ShopModel.fromJson(
        queryDocumentSnapshot.data() as Map<String, dynamic>);
    shop.id = queryDocumentSnapshot.id;
    return shop;
  }
}
