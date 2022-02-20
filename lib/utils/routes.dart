import 'package:get/get.dart';
import 'package:hairfly/pages/home.dart';
import 'package:hairfly/pages/login.dart';
import 'package:hairfly/pages/signup.dart';
// import 'package:hairfly/utils/auth_middleware.dart';

routes() => [
      GetPage(
        name: '/',
        page: () => HomePage(),
        // middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: '/login',
        page: () => LoginPage(),
        transition: Transition.fadeIn,
        // middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: '/signup',
        page: () => SignUpPage(),
        transition: Transition.fade,
        // middlewares: [AuthMiddleware()],
      ),
    ];
