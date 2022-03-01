import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/search.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:hairfly/widgets/shop_card.dart';
import 'package:outline_search_bar/outline_search_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final SearchCtrl _searchCtrl = Get.find();
  final LocaleCtrl _localeCtrl = Get.find();
  final ShopCtrl _shopCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: Get.width * 0.08,
              desktop: Get.width * 0.16)),
      decoration: kBackground,
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            leading: const SizedBox.shrink(),
            leadingWidth: 0,
            backgroundColor: kAppBarColor.withOpacity(0.6),
            elevation: 5,
            toolbarHeight: 110,
            title: Obx((() => _searchCtrl.isFetched.value
                ? Column(
                    children: [
                      OutlineSearchBar(
                        debounceDelay: 500,
                        onClearButtonPressed: (_) =>
                            _searchCtrl.filterShop(null),
                        onTypingFinished: (value) =>
                            _searchCtrl.filterShop(value),
                        onSearchButtonPressed: (value) =>
                            _searchCtrl.filterShop(value),
                        elevation: 10,
                        textEditingController:
                            _searchCtrl.textEditingController,
                      ),
                      CustomCheckBoxGroup(
                        buttonValuesList: _searchCtrl.searchList,
                        buttonLables: _searchCtrl.searchList.cast<String>(),
                        checkBoxButtonValues: (values) {
                          _searchCtrl.selectedTag.value = values.cast<String>();
                          _searchCtrl.filterShopByTag(values.cast<String>());
                        },
                        selectedColor: Colors.pink,
                        unSelectedColor: Colors.white,
                        defaultSelected: _searchCtrl.selectedTag,
                        spacing: 0,
                        enableShape: true,
                        horizontal: false,
                        elevation: 5,
                        autoWidth: true,
                        // enableButtonWrap: true,
                        height: 30,
                      ),
                    ],
                  )
                : const SizedBox.shrink()))),
        body: Obx(
          () => ListView.builder(
              itemCount: _searchCtrl.filteredShopList.length,
              itemBuilder: (context, idx) {
                var _shop = _searchCtrl.filteredShopList[idx];
                return shopCard(
                    context: context,
                    shop: _shop,
                    localeCtrl: _localeCtrl,
                    shopCtrl: _shopCtrl);
              }),
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
