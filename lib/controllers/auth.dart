import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/user.dart';
import 'package:hairfly/models/user.dart';
import 'package:hairfly/utils/database.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final UserController _userController = Get.put(UserController());
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? get user => _firebaseUser.value?.uid;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> signUp(
      String name, int phone, String email, String password) async {
    EasyLoading.show(status: 'Loading...');
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel _user = UserModel(
        id: _userCredential.user?.uid,
        name: name,
        phone: phone,
        email: _userCredential.user?.email,
      );
      if (await Database().createNewUser(_user)) {
        _userController.user = _user;
        Get.offAndToNamed('/');
      }
    } catch (e) {
      Get.snackbar("Error creating account ", e.toString());
    }
    EasyLoading.dismiss();
  }

  void login(String email, String password) async {
    EasyLoading.show(status: 'Loading...');
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      _userController.user =
          await Database().getUser(_userCredential.user!.uid);
      Get.offAndToNamed('/');
    } catch (e) {
      Get.snackbar("Error sign in ", e.toString());
    }
    EasyLoading.dismiss();
  }

  void forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Password Reset',
          'An Email has been sent to your email for password reset');
    } catch (e) {
      Get.snackbar('Error for forgot password', e.toString());
    }
  }

  void signout() async {
    try {
      await _auth.signOut();
      _userController.clear();
      Get.offAndToNamed('/');
    } catch (e) {
      Get.snackbar("Something went wrong..", e.toString());
    }
  }
}
