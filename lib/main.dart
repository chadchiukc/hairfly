import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/controllers/bottom_nav.dart';
import 'package:hairfly/controllers/carousel.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/firebase_options.dart';
import 'package:hairfly/pages/home.dart';
import 'package:hairfly/pages/rating.dart';
import 'package:hairfly/pages/profile.dart';
import 'package:hairfly/pages/test.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/root.dart';
import 'package:hairfly/utils/routes.dart';
import 'package:hairfly/utils/translation.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  setPathUrlStrategy();
  Get.put(AuthController());
  Get.put(NavCtrl());
  Get.put(ShopCtrl());
  Get.put(CarouselCtrl());
  Get.put(LocaleCtrl());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(),
      locale: const Locale('en', 'US'),
      title: 'HairFly',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.pink,
        appBarTheme: const AppBarTheme(color: kAppBarColor),
      ),
      builder: EasyLoading.init(),
      home: HomePage(),
      getPages: routes(),
    );
  }
}
