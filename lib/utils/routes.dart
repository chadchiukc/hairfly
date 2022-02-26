import 'package:get/get.dart';
import 'package:hairfly/pages/booking.dart';
import 'package:hairfly/pages/home.dart';
import 'package:hairfly/pages/login.dart';
import 'package:hairfly/pages/profile.dart';
import 'package:hairfly/pages/signup.dart';
import 'package:hairfly/utils/middleware.dart';

routes() => [
      GetPage(
        name: Routes.home,
        page: () => HomePage(),
        transition: Transition.fade,
        // middlewares: [allMiddleware()],
      ),
      GetPage(
        name: Routes.login,
        page: () => LoginPage(),
        transition: Transition.fade,
        middlewares: [LoginMiddleware()],
      ),
      GetPage(
        name: Routes.signup,
        page: () => SignUpPage(),
        transition: Transition.fade,
        middlewares: [LoginMiddleware()],
      ),
      GetPage(
        name: Routes.profile,
        page: () => ProfilePage(),
        transition: Transition.fade,
        middlewares: [AuthMiddleware()],
      ),
      GetPage(
        name: '${Routes.booking}/:id',
        page: () => BookingPage(),
        transition: Transition.fade,
      ),
    ];

class Routes {
  static const home = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const profile = '/profile';
  static const booking = '/booking';
}
