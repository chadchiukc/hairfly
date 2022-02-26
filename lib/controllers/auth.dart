import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/bottom_nav.dart';
import 'package:hairfly/controllers/user.dart';
import 'package:hairfly/models/user.dart';
import 'package:hairfly/utils/database.dart';
import 'package:hairfly/utils/routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final UserController _userController = Get.put(UserController());
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final NavCtrl _navCtrl = Get.find();
  var isReady = false.obs;

  // final isVerified = false.obs;

  String? get user => _firebaseUser.value?.uid;
  // bool get verified => _firebaseUser.value?.emailVerified ?? false;

  @override
  void onReady() async {
    _userController.syncFirebase(_firebaseUser.value?.uid);
    if (_firebaseUser.value?.uid == null) {
      once(_firebaseUser, (_) {
        _userController.syncFirebase(_firebaseUser.value?.uid);
      });
    }
    Future.delayed(const Duration(seconds: 1), (() {
      isReady.value = true;
    }));
    super.onReady();
  }

  @override
  void onInit() async {
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> signUp(String name, int phone, String email, String password,
      String gender) async {
    EasyLoading.show(status: 'loading'.tr);
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel _user = UserModel(
        id: _userCredential.user?.uid,
        name: name,
        phone: phone,
        email: _userCredential.user?.email,
        privilege: 'customer',
        gender: gender,
      );
      // sendEmailVerification();
      if (await Database().createNewUser(_user)) {
        _userController.user = _user;
        Get.offAllNamed(Routes.login);
      }
    } on FirebaseAuthException catch (e) {
      var error = 'tryAgain'.tr;
      if (e.code == 'weak-password') {
        error = 'weakPassword'.tr;
      } else if (e.code == 'email-already-in-use') {
        error = 'emailExist'.tr;
      }
      Get.snackbar("errorCreatingAcc".tr, error);
    } catch (e) {
      Get.snackbar("errorCreatingAcc".tr, 'tryAgain'.tr);
    }
    EasyLoading.dismiss();
  }

  Future<bool> login(String email, String password) async {
    EasyLoading.show(status: 'loading'.tr);
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      _userController.user =
          await Database().getUser(_userCredential.user!.uid);
      EasyLoading.dismiss();
      return true;
    } catch (e) {
      Get.snackbar("wrontMsg".tr, e.toString());
      EasyLoading.dismiss();
      return false;
    }
  }

  void forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Password Reset',
          'An Email has been sent to your email for password reset');
    } catch (e) {
      Get.snackbar('wrongMsg'.tr, e.toString());
    }
  }

  void signout({bool navToHome = false}) async {
    try {
      if (navToHome) {
        Get.offAndToNamed(Routes.home);
        _navCtrl.idx = 0;
      }
      await _auth.signOut();
      _userController.clear();
    } catch (e) {
      Get.snackbar("wrongMsg".tr, e.toString());
    }
  }

  Future<void> sendEmailVerification({bool showDialog = false}) async {
    User? user = _auth.currentUser;
    try {
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        if (showDialog) {
          Get.defaultDialog(
              title: 'emailVerification'.tr,
              middleText: 'emailSent'.tr,
              textConfirm: 'confirm'.tr,
              onConfirm: Get.back);
        }
      }
    } catch (e) {
      Get.snackbar('wrongMsg'.tr, e.toString());
    }
  }
}
