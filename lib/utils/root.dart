import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/controllers/user.dart';
import 'package:hairfly/pages/home.dart';
import 'package:hairfly/pages/login.dart';

class Root extends StatelessWidget {
  final AuthController _authController = Get.find();
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (_authController.user != null && _userController.user.id == null) {
      // _userController.syncFirebase(_authController.user!);
      // }
      return _authController.user == null
          ? LoginPage()
          : _userController.user.privilege == 'admin'
              ? HomePage()
              : HomePage();
    });
  }
}
