import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/carousel.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/search.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/pages/home/map.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:hairfly/widgets/explore_card.dart';
import 'package:hairfly/pages/home/carousel.dart';
import 'package:hairfly/widgets/heading.dart';
import 'package:hairfly/widgets/shop_card.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final LocaleCtrl _localeCtrl = Get.find();
  final CarouselCtrl _carouselCtrl = Get.find();
  final ShopCtrl _shopCtrl = Get.find();
  final SearchCtrl _searchCtrl = Get.find();

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
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: MySliverAppBar(expandedHeight: 150.0, logoRadius: 80),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 40),
                myHeading(
                  'explore'.tr,
                  trailing: Card(
                      elevation: 10,
                      shadowColor: kAppBarColor,
                      color: Colors.transparent,
                      child: ToggleSwitch(
                          minWidth: 45,
                          minHeight: 30,
                          initialLabelIndex: _localeCtrl.localeIdx,
                          cornerRadius: 20.0,
                          inactiveFgColor: Colors.black,
                          activeFgColor: Colors.black,
                          inactiveBgColor: Colors.transparent,
                          totalSwitches: 2,
                          labels: const ['EN', '繁'],
                          activeBgColor: const [Colors.white, kAppBarColor],
                          onToggle: (index) {
                            _localeCtrl.changeLocale(index!);
                          })),
                ),
                Center(
                  child: SizedBox(
                      width: context.width * 0.9,
                      height: context.height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ExploreCard(
                                    'haircuts'.tr,
                                    'assets/images/cut.png',
                                    imageRatio: 2.2,
                                    callback: () =>
                                        _searchCtrl.exploreToSearch('haircut'),
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: ExploreCard(
                                          'color'.tr,
                                          'assets/images/color.png',
                                          imageRatio: 1.5,
                                          callback: () => _searchCtrl
                                              .exploreToSearch('color'),
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: ExploreCard(
                                          'treatment'.tr,
                                          'assets/images/treatment.png',
                                          callback: () => _searchCtrl
                                              .exploreToSearch('treatment'),
                                        ))
                                  ],
                                ))
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                      child: ExploreCard(
                                    'perm'.tr,
                                    'assets/images/perm.png',
                                    imageRatio: 1.5,
                                    callback: () =>
                                        _searchCtrl.exploreToSearch('perm'),
                                  )),
                                  Expanded(
                                      child: ExploreCard(
                                    'join'.tr,
                                    'assets/images/join.png',
                                    imageRatio: 1.5,
                                    callback: () {
                                      Get.defaultDialog(
                                          title: 'joinUsTitle'.tr,
                                          middleText: 'joinUsMiddleText'.tr);
                                    },
                                  ))
                                ],
                              ))
                        ],
                      )),
                ),
                myHeading(
                  'recommend'.tr,
                  trailing: Card(
                      elevation: 10,
                      shadowColor: kAppBarColor,
                      color: Colors.transparent,
                      child: ToggleSwitch(
                          minWidth: 45,
                          minHeight: 30,
                          initialLabelIndex: _carouselCtrl.gender.value,
                          cornerRadius: 20.0,
                          inactiveFgColor: Colors.white,
                          inactiveBgColor: Colors.black.withOpacity(0.1),
                          totalSwitches: 2,
                          icons: const [Icons.male, Icons.female],
                          activeBgColors: const [
                            [Colors.white, Colors.blue],
                            [Colors.white, Colors.pink]
                          ],
                          onToggle: (index) {
                            _carouselCtrl.changeGender(index ?? 0);
                          })),
                ),
                MyCarousel(),
                myHeading('shopsOnMap'.tr),
                Card(
                    color: Colors.transparent,
                    elevation: 10,
                    shadowColor: Theme.of(context).appBarTheme.backgroundColor,
                    child: Center(
                      child: SizedBox(
                          width: Get.width * 0.9,
                          height: Get.height * 0.35,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: MapPage())),
                    ))
              ]),
            ),
            Obx(
              () => SliverList(
                delegate: SliverChildBuilderDelegate((_, idx) {
                  var _shop = _shopCtrl.shopList[idx];
                  return shopCard(
                      context: context,
                      shop: _shop,
                      localeCtrl: _localeCtrl,
                      shopCtrl: _shopCtrl);
                }, childCount: _shopCtrl.shopList.length),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  ((context, index) => SizedBox(
                        height: Get.height * 0.1,
                      )),
                  childCount: 1),
            ),
          ],
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
