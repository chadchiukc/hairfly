import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/models/status.dart';
import 'package:hairfly/utils/database.dart';

class StatusCtrl extends GetxController {
  final AuthController _authController = Get.find();
  var isFetched = false.obs;
  var bookingList = <StatusModel>[].obs;
  final statusWording = [
    'bookSt'.tr,
    'pendSt'.tr,
    'completeSt'.tr,
    'ratingSt'.tr
  ];

  @override
  void onInit() async {
    await fetchBooking();
    isFetched.value = true;
    super.onInit();
  }

  Future<void> fetchBooking() async {
    bookingList.clear();
    EasyLoading.show(status: 'loading'.tr);
    try {
      QuerySnapshot _booking =
          await Database().getBooking(_authController.user!);
      for (var element in _booking.docs) {
        bookingList.add(StatusModel.fromSnapShot(element));
      }
    } catch (e) {
      Get.snackbar("error".tr, e.toString());
    }
    EasyLoading.dismiss();
  }
}
