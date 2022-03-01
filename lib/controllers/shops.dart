import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hairfly/models/service.dart';
import 'package:hairfly/models/shop.dart';
import 'package:hairfly/utils/database.dart';

class ShopCtrl extends GetxController {
  var shopList = <ShopModel>[].obs;

  Rx<ShopModel?> selectedShop = null.obs;
  var selectedShopIndex = (-1).obs; //for selection on the map
  var isFetch = false.obs;
  RxList<ServiceModel> selectedShopServices = <ServiceModel>[].obs;

  ShopModel? get getShop => selectedShop.value;

  @override
  void onInit() async {
    await queryShops();
    isFetch.value = true;
    super.onInit();
  }

  Future<void> queryShops() async {
    try {
      QuerySnapshot _shops = await Database().getFromFirestore('shop');
      for (var element in _shops.docs) {
        shopList.add(ShopModel.fromSnapShot(element));
      }
    } catch (e) {
      Get.snackbar("error".tr, 'tryAgain'.tr);
    }
  }

  void selectShopOnMap(
      int idx, Function callbackForSameIdx, Function callbackForDiffIdx) {
    if (selectedShopIndex.value != idx) {
      callbackForDiffIdx();
      selectedShopIndex.value = idx;
    } else {
      callbackForSameIdx();
      selectedShopIndex.value = -1;
    }
  }

  void cancelShopOnMap(Function callback) {
    callback();
    selectedShopIndex.value = -1;
  }

  double shopRating(List<dynamic>? list) {
    if (list == null) {
      return -1;
    }
    return (list.reduce((value, element) => value + element) / list.length)
        .toDouble();
  }

  int shopReviwer(List<dynamic>? list) {
    return list?.length ?? 0;
  }

  String toNumOfReviewString(int num, String singleTr, String pluralTr) {
    return '($num' ' ' + singleTr.trPlural(pluralTr, num) + ')';
  }

  // for bottomsheet booking
  List<ServiceModel> convertServicesToList(Map? services) {
    if (services == null) {
      return [];
    }
    List<ServiceModel> serviceList = [];
    services.forEach((key, value) {
      serviceList.add(ServiceModel(key, value));
    });
    return serviceList;
  }

  void selectShop(String? shopId) {
    selectedShop.value = null;
    if (shopId != null) {
      selectedShopServices.clear();
      selectedShop = shopList.firstWhereOrNull((shop) => shop.id == shopId).obs;
      if (selectedShop.value?.services != null) {
        selectedShop.value?.services!.forEach((key, value) {
          selectedShopServices.add(ServiceModel(key, value));
        });
      }
    }
  }
}
