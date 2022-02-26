import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/carousel.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/pages/profile.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/pages/home/map.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/database.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:hairfly/widgets/explore_card.dart';
import 'package:hairfly/pages/home/carousel.dart';
import 'package:hairfly/widgets/heading.dart';
import 'package:hairfly/widgets/image_network.dart';
import 'package:hairfly/widgets/list_tile.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final LocaleCtrl _localeCtrl = Get.find();
  final CarouselCtrl _carouselCtrl = Get.find();
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
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: ExploreCard(
                                          'treatment'.tr,
                                          'assets/images/treatment.png',
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
                                  )),
                                  Expanded(
                                      child: ExploreCard(
                                    'join'.tr,
                                    'assets/images/join.png',
                                    imageRatio: 1.5,
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
                  return Card(
                      elevation: 5,
                      color: Colors.white.withOpacity(0.6),
                      shadowColor: kAppBarColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  elevation: 10,
                                  color: Colors.transparent,
                                  shadowColor: kAppBarColor,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(2)),
                                    child: SizedBox(
                                        height: getValueForScreenType(
                                            context: context,
                                            mobile: Get.width * 0.4,
                                            tablet: Get.width * 0.3,
                                            desktop: Get.width * 0.25),
                                        width: getValueForScreenType(
                                            context: context,
                                            mobile: Get.width * 0.5,
                                            tablet: Get.width * 0.4,
                                            desktop: Get.width * 0.35),
                                        child: myImage(_shop.img!, 'shop')),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Text(_shop.name!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              )),
                                        ),
                                        myShopListTile(
                                          Icons.home,
                                          Flexible(
                                              child: GestureDetector(
                                                  onTap: () => {
                                                        MapsLauncher
                                                            .launchCoordinates(
                                                                _shop.latLon!
                                                                    .latitude,
                                                                _shop.latLon!
                                                                    .longitude)
                                                      },
                                                  child: Text(
                                                    _localeCtrl.localeIdx == 0
                                                        ? _shop.address!
                                                        : _shop.addressZh!,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                        overflow:
                                                            TextOverflow.clip,
                                                        fontSize: 12,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ))),
                                        ),
                                        myShopListTile(
                                            Icons.phone,
                                            Text(_shop.tel!.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12))),
                                        myShopListTile(
                                            Icons.alarm,
                                            Text(_shop.openHour!.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12))),
                                        myShopListTile(
                                            Icons.room_service_outlined,
                                            Expanded(
                                              child: Wrap(
                                                  spacing: 5,
                                                  children: _shop.services!.keys
                                                      .toList()
                                                      .map((e) => Text(e,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                          )))
                                                      .toList()),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    RatingBarIndicator(
                                                      rating:
                                                          _shopCtrl.shopRating(
                                                              _shop.rating),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              const Icon(
                                                        Icons.cut,
                                                        color: Colors.amber,
                                                      ),
                                                      itemSize: 15,
                                                    ),
                                                    Text(
                                                      _shopCtrl
                                                          .toNumOfReviewString(
                                                              _shopCtrl
                                                                  .shopReviwer(
                                                                      _shop
                                                                          .rating),
                                                              'review',
                                                              'reviews'),
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 5,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'detail'.tr,
                                    style: const TextStyle(fontSize: 12),
                                  )),
                            )
                          ],
                        ),
                      ));
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
