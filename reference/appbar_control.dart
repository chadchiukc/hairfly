import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/utils/constant.dart';

class AppBarCtrl extends GetxController {
  var scrollCtrl = ScrollController();
  // final _isScrolled = false.obs;
  final _offset = 0.obs;

  // bool get isScrolled => _isScrolled.value;
  int get offset => _offset.value;

  @override
  void onInit() {
    scrollCtrl.addListener(() {
      _offset.value = offsetPercentage();
      // _isScrolled.value = checkScrolled();
    });
    super.onInit();
  }

  @override
  void onClose() {
    scrollCtrl.dispose();
    super.onClose();
  }

  bool checkScrolled() {
    return scrollCtrl.hasClients &&
        scrollCtrl.offset > (kAppBarHeight - kToolbarHeight);
  }

  int offsetPercentage() {
    return scrollCtrl.offset > 100 ? 100 : scrollCtrl.offset.toInt();
  }
}
