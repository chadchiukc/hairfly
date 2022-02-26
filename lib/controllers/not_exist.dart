import 'dart:async';

import 'package:get/get.dart';
import 'package:hairfly/utils/routes.dart';

class NotExistCtrl extends GetxController {
  var counter = 0.obs;

  @override
  void onInit() async {
    // Timer.periodic(Duration(seconds: 1), ((timer) => print(timer.tick)));
    await Future.delayed(
        const Duration(seconds: 2), () => Get.offAllNamed(Routes.home));
    super.onInit();
  }
}
