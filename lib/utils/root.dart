// only be used when the first page need a auth as well

// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:hairfly/controllers/auth.dart';
// import 'package:hairfly/controllers/user.dart';
// import 'package:hairfly/pages/home.dart';
// import 'package:hairfly/pages/login.dart';

// class Root extends StatelessWidget {
//   final AuthController _authController = Get.find();
//   final UserController _userController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return _authController.user == null
//           ? LoginPage()
//           : _userController.user.privilege == 'shopAdmin'
//               ? HomePage()
//               : HomePage();
//     });
//   }
// }
