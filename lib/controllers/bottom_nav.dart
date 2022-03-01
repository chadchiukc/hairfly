import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/utils/routes.dart';

class NavCtrl extends GetxController with GetTickerProviderStateMixin {
  late final TabController tabController;
  final RxInt _idx = 0.obs;

  int get getIndex => _idx.value;

  set idx(idx) => _idx.value = idx;

  final _navPages = [
    Routes.home,
    Routes.search,
    Routes.status,
    Routes.profile,
  ];

  @override
  void onInit() {
    tabController = TabController(
        length: _navPages.length, vsync: this, initialIndex: _idx.value);
    super.onInit();
  }

  void navigation(int index) {
    if (_idx.value != index) {
      Get.offNamed(_navPages[index]);
      _idx.value = index;
    }
  }

  void routingCallback(Routing? routing) {
    var currentRoute = routing?.current ?? '/';
    switch (currentRoute) {
      case Routes.home:
        _idx.value = 0;
        break;
      case Routes.profile:
        _idx.value = 3;
        break;
      case Routes.status:
        _idx.value = 2;
        break;
      case Routes.search:
        _idx.value = 1;
        break;
      default:
    }
  }
}
