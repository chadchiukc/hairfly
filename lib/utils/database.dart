import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hairfly/models/shop.dart';
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
        "privilege": 'customer',
        'description': 'Hey there, I am using hairfly.'
      });
      box.write('user', {
        'id': user.id,
        'name': user.name,
        'phone': user.phone,
        'email': user.email,
        'privilege': 'customer',
        'description': 'Hey there, I am using hairfly.'
      });
      print(box.read('user'));
      print('-----------wrote box------------');
      return true;
    } catch (e) {
      print('error');
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    var user = box.read('user');
    print('--------------read from box---------------');
    print(user);
    print('--------------read from box---------------');
    if (user != null && user['id'] == uid) {
      print('Getting User from box');
      return UserModel(
          id: user['id'],
          name: user['name'],
          phone: user['phone'],
          email: user['email'],
          privilege: user['privilege']);
    } else {
      try {
        print('Getting User from Firestore');
        DocumentSnapshot _doc =
            await _firestore.collection('users').doc(uid).get();
        return UserModel.fromSnapshot(_doc);
      } catch (e) {
        print('user error');
        rethrow;
      }
    }
  }

  Future<QuerySnapshot> getFromFirestore(String doucmentName) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(doucmentName).get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadURLExample(String fileName) async {
    String downloadURL =
        await storage.ref('shop/jackystyle.jpg').getDownloadURL();
    print(downloadURL);
    // // Within your widgets:
    // // Image.network(downloadURL);

    // ListResult result = await FirebaseStorage.instance
    // .ref('shop')
    // .list(ListOptions(maxResults: 10));
    // print(result.items.length);
  }

  Future<void> shopRating(String shopId, String userId, double rating) async {
    try {
      await _firestore.collection('shop').doc(shopId).update({
        'rating': {userId: rating}
      });
    } catch (e) {
      rethrow;
    }
  }
}
