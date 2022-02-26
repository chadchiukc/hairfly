// if the first page need a auth
// Could not be used as the redirecting will be faster than bindstream

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/controllers/bottom_nav.dart';
import 'package:hairfly/utils/routes.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthController _authController = Get.find();
  final NavCtrl _navCtrl = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    return _authController.user != null
        ? null
        : _authController.isReady.value
            ? const RouteSettings(name: Routes.login)
            : const RouteSettings(name: Routes.home);
  }
}

// redirect to the heom page
// if the url path is login / signup & the user is logged in
class LoginMiddleware extends GetMiddleware {
  final AuthController _authController = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    return _authController.user != null
        ? const RouteSettings(name: Routes.home)
        : null;
  }
}
