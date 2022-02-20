import 'package:get/get.dart';

class NavCtrl extends GetxController {
  final RxInt _idx = 0.obs;

  int get getIndex => _idx.value;

  set idx(idx) => _idx.value = idx;
}
