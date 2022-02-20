
// Could not be used as the redirecting will be faster than bindstream

// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:hairfly/controllers/auth.dart';

// class AuthMiddleware extends GetMiddleware {
//   final AuthController _authController = Get.find();

//   @override
//   RouteSettings? redirect(String? route) {
//     print('------------------Middleware-----------------------');
//     print(_authController.authenticated);
//     print('------------------Middleware-----------------------');
//     return _authController.authenticated.value || route == '/login'
//         ? null
//         : const RouteSettings(name: '/login');
//   }
// }
