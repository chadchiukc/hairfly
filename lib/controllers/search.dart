import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/models/shop.dart';
import 'package:hairfly/utils/database.dart';
import 'package:hairfly/utils/routes.dart';

class SearchCtrl extends GetxController {
  List<dynamic> searchList = [];
  var isFetched = false.obs;
  final ShopCtrl _shopCtrl = Get.find();
  TextEditingController textEditingController = TextEditingController();
  var filteredShopList = <ShopModel>[].obs;
  var filteredByTagTempShopList = <ShopModel>[];
  RxList<String> selectedTag = <String>[].obs;

  @override
  void onInit() async {
    searchList = await Database().getService();
    filteredByTagTempShopList = _shopCtrl.shopList;
    isFetched.value = true;
    filterShop(null);
    super.onInit();
  }

  void filterShop(String? searchText) {
    if (searchText != null) {
      filteredShopList.value = filteredByTagTempShopList
          .where((e) =>
              e.name!.toLowerCase().contains(searchText.toLowerCase()) ||
              e.address!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    } else {
      filteredShopList.value = filteredByTagTempShopList;
    }
  }

  void filterShopByTag(List<String> tagList) {
    if (tagList.isNotEmpty) {
      var lists = [];
      for (var element in tagList) {
        lists.add(_shopCtrl.shopList
            .where((e) => e.services!.containsKey(element))
            .toList());
      }
      filteredByTagTempShopList = lists
          .map((l) => Set.from(l))
          .reduce((v, e) => v.intersection(e))
          .toList()
          .cast<ShopModel>();
      filterShop(textEditingController.text);
    } else {
      filteredByTagTempShopList = _shopCtrl.shopList;
      filterShop(textEditingController.text);
    }
  }

  void exploreToSearch(String tag) {
    selectedTag.clear();
    selectedTag.add(tag);
    filterShopByTag(selectedTag);
    Get.offAllNamed(Routes.search);
  }
}
