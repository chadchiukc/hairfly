import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hairfly/models/carousel.dart';
import 'package:hairfly/utils/database.dart';

class CarouselCtrl extends GetxController {
  var imgList = <CarouselModel>[];
  var filterImgList = <CarouselModel>[].obs;
  var gender = 0.obs;
  var isFetched = false.obs;
  GetStorage box = GetStorage();

  final CarouselController carouselCtrl = CarouselController();
  final _index = 0.obs;

  int get index => _index.value;
  set setIndex(int idx) => _index.value = idx;

  @override
  void onInit() async {
    if (box.read('gender') != null && box.read('gender') == 1) {
      gender.value = 1;
    }
    await queryCarousel();
    filterImgList = imgList
        .where((img) => img.gender == _convertIndexToGender(gender.value))
        .toList()
        .obs;
    isFetched.value = true;
    super.onInit();
  }

  Future<void> queryCarousel() async {
    try {
      QuerySnapshot _carousel = await Database().getFromFirestore('gallery');
      for (var element in _carousel.docs) {
        imgList.add(CarouselModel.fromSnapShot(element));
      }
    } catch (e) {
      Get.snackbar("error".tr, 'tryAgain'.tr);
    }
  }

  void changeGender(int newGenderIndex) {
    // 0 for male, 1 for female
    if (newGenderIndex != gender.value) {
      gender.value = newGenderIndex;
      box.write('gender', newGenderIndex);
      filterImgList.clear();
      filterImgList = imgList
          .where((img) => img.gender == _convertIndexToGender(gender.value))
          .toList()
          .obs;
    }
  }

  String _convertIndexToGender(int gender) {
    // 0 for male, 1 for female
    return gender == 0 ? 'm' : 'f';
  }
}
