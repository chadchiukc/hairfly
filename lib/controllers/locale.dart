import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocaleCtrl extends GetxController {
  var localeIdx = 0;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    if (box.read('locale') != null && box.read('locale') == 1) {
      localeIdx = 1;
    }
    super.onInit();
  }

  @override
  void onReady() {
    changeLocale(localeIdx);
    super.onReady();
  }

  void changeLocale(int index) {
    localeIdx = index;
    if (index == 0) {
      Get.updateLocale(const Locale('en', 'US'));
      box.write('locale', 0);
    } else {
      Get.updateLocale(const Locale('zh', 'HK'));
      box.write('locale', 1);
    }
  }
}
