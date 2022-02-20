import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  int? phone;
  String? description;
  String? privilege;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.privilege,
      this.description});

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
        id: documentSnapshot.id,
        name: documentSnapshot['name'],
        email: documentSnapshot['email'],
        phone: documentSnapshot['phone'],
        description: documentSnapshot['description'],
        privilege: documentSnapshot['privilege']);
  }
}
