import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hairfly/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  GetStorage box = GetStorage();

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "phone": user.phone,
        "email": user.email,
        'gender': user.gender,
        "privilege": 'customer',
      });
      box.write('user', {
        'id': user.id,
        'name': user.name,
        'phone': user.phone,
        'email': user.email,
        'gender': user.gender,
        'privilege': 'customer',
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    var user = box.read('user');
    if (user != null && user['id'] == uid) {
      return UserModel(
          id: user['id'],
          name: user['name'],
          phone: user['phone'],
          email: user['email'],
          gender: user['gender'],
          privilege: user['privilege']);
    } else {
      try {
        DocumentSnapshot _doc =
            await _firestore.collection('users').doc(uid).get();
        return UserModel.fromSnapshot(_doc);
      } catch (e) {
        rethrow;
      }
    }
  }

  // for general usage
  Future<QuerySnapshot> getFromFirestore(String doucmentName) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(doucmentName).get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  // to update the shop rating
  Future<void> shopRating(String shopId, String userId, double rating) async {
    try {
      await _firestore.collection('shop').doc(shopId).update({
        'rating': {userId: rating}
      });
    } catch (e) {
      rethrow;
    }
  }

  // to update user information
  Future<void> updateUser(String userId, String key, dynamic value) async {
    try {
      await _firestore.collection('users').doc(userId).update({key: value});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadProfileImage(Uint8List data, String userId) async {
    var ref = storage.ref('profile/$userId.jpg');
    var metadata = SettableMetadata(contentType: 'image/jpeg');
    try {
      await ref.putData(data, metadata);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
