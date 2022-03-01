import 'package:crop_your_image/crop_your_image.dart';
import 'package:get/get.dart';

class CropCtrl extends GetxController {
  CropController cropController = CropController();
  var isReady = false.obs;

  @override
  void onInit() {
    isReady.value = true;
    super.onInit();
  }
}
