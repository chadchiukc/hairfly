import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hairfly/models/shop.dart';
import 'package:hairfly/utils/database.dart';

class ShopCtrl extends GetxController {
  var shopList = <ShopModel>[].obs;
  var filteredShopList = <ShopModel>[].obs;
  var selectedShop = ShopModel().obs;
  var selectedShopIndex = (-1).obs; //for selection on the map
  var isFetch = false.obs;

  @override
  void onInit() async {
    await queryShops();
    isFetch.value = true;
    super.onInit();
  }

  // set selectShopIndex(int idx) => selectedShopIndex.value = idx;
  // int get selectedShopIndex => _selectedShopIndex.value;

  Future<void> queryShops() async {
    // EasyLoading.show(status: 'loading'.tr);
    try {
      QuerySnapshot _shops = await Database().getFromFirestore('shop');
      for (var element in _shops.docs) {
        shopList.add(ShopModel.fromSnapShot(element));
      }
    } catch (e) {
      Get.snackbar("error".tr, 'tryAgain'.tr);
    }
    // EasyLoading.dismiss();
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

  void filterShop(String? searchText) {
    if (searchText != null) {
      for (var element in shopList) {
        if (element.address!.toLowerCase().contains(searchText.toLowerCase())) {
          filteredShopList.add(element);
        }
      }
    } else {
      filteredShopList.value = shopList;
    }
  }

  // void selectShop(int index) {
  //   selectedShop.value = ShopModel(
  //     id: shopList[index].id,
  //     address: shopList[index].address,
  //     latLon: shopList[index].latLon,
  //     img: shopList[index].img,
  //     name: shopList[index].name,
  //     openHour: shopList[index].openHour,
  //   );
  // }

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
}
