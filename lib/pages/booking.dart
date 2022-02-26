import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/models/service.dart';
import 'package:hairfly/pages/not_exist.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/image_network.dart';
import 'package:hairfly/widgets/list_tile.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BookingPage extends StatelessWidget {
  BookingPage({Key? key}) : super(key: key);
  final shopId = Get.parameters['id'];
  // String shopId = '2nJn5YjMfD2vI1qKtzob';
  final ShopCtrl _shopCtrl = Get.find();
  final LocaleCtrl _localeCtrl = Get.find();

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
        child: Obx(() {
          _shopCtrl.selectServicesToList(shopId);
          return !_shopCtrl.isFetch.value
              ? const Center(child: CircularProgressIndicator())
              : _shopCtrl.selectedShop.value == null
                  ? NotExistPage()
                  : Scaffold(
                      backgroundColor: Colors.transparent,
                      body: CustomScrollView(
                        slivers: [
                          SliverPersistentHeader(
                            pinned: false,
                            delegate: MySliverAppBar(
                                borderRadius: false,
                                expandedHeight: 140.0,
                                logoRadius: 70,
                                backwardable: true),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                ((context, index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                SizedBox(
                                                    height: 300,
                                                    child: myImage(
                                                        _shopCtrl.selectedShop
                                                            .value!.img!,
                                                        'shop')),
                                                Positioned(
                                                  bottom: 10,
                                                  left: 5,
                                                  child: Card(
                                                      elevation: 10,
                                                      shadowColor: kAppBarColor,
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            _shopCtrl
                                                                .selectedShop
                                                                .value!
                                                                .name!,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        25),
                                                          ))),
                                                ),
                                              ]),
                                          Container(
                                              decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      150, 241, 237, 237)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  _shopCtrl.selectedShop.value!
                                                      .description!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          SizedBox(
                                              height: 110,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  myShopListTile(
                                                                      Icons
                                                                          .home,
                                                                      GestureDetector(
                                                                          onTap: () =>
                                                                              {
                                                                                MapsLauncher.launchCoordinates(_shopCtrl.selectedShop.value!.latLon!.latitude, _shopCtrl.selectedShop.value!.latLon!.longitude)
                                                                              },
                                                                          child:
                                                                              Text(
                                                                            _localeCtrl.localeIdx == 0
                                                                                ? _shopCtrl.selectedShop.value!.address!
                                                                                : _shopCtrl.selectedShop.value!.addressZh!,
                                                                            maxLines:
                                                                                3,
                                                                            style: const TextStyle(
                                                                                overflow: TextOverflow.clip,
                                                                                fontSize: 14,
                                                                                decoration: TextDecoration.underline),
                                                                          )),
                                                                      enlargeIcon:
                                                                          true),
                                                                  myShopListTile(
                                                                      Icons
                                                                          .phone,
                                                                      Text(
                                                                          _shopCtrl
                                                                              .selectedShop
                                                                              .value!
                                                                              .tel!
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize:
                                                                                  14)),
                                                                      enlargeIcon:
                                                                          true),
                                                                  myShopListTile(
                                                                      Icons
                                                                          .alarm,
                                                                      Text(
                                                                          _shopCtrl
                                                                              .selectedShop
                                                                              .value!
                                                                              .openHour!
                                                                              .toString(),
                                                                          style: const TextStyle(
                                                                              fontSize:
                                                                                  14)),
                                                                      enlargeIcon:
                                                                          true),
                                                                ]),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 5,
                                                          right: 5,
                                                          child: Column(
                                                            children: [
                                                              RatingBarIndicator(
                                                                rating: _shopCtrl
                                                                    .shopRating(_shopCtrl
                                                                        .selectedShop
                                                                        .value!
                                                                        .rating),
                                                                itemBuilder: (context,
                                                                        index) =>
                                                                    const Icon(
                                                                  Icons.cut,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                itemSize: 20,
                                                              ),
                                                              Text(
                                                                _shopCtrl.toNumOfReviewString(
                                                                    _shopCtrl.shopReviwer(_shopCtrl
                                                                        .selectedShop
                                                                        .value!
                                                                        .rating),
                                                                    'review',
                                                                    'reviews'),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      color: kAppBarColor,
                                                      child: TextButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            'book'.tr,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ])),
                                childCount: 1),
                          ),
                          SliverList(
                              delegate: SliverChildBuilderDelegate((_, idx) {
                            return Container(
                              // color: const Color.fromARGB(255, 244, 190, 104),
                              color: Color.fromARGB(255, 246, 243, 215),
                              child: Column(children: [
                                Center(
                                    child: Text(
                                  'priceList'.tr,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                )),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'service'.tr,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'price'.tr,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Divider(
                                    height: 3,
                                    thickness: 3,
                                  ),
                                ),
                                ..._shopCtrl.selectedShopServices
                                    .map((ServiceModel e) => Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.25,
                                              vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                e.name,
                                                style: const TextStyle(
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                              Text(e.price.toString(),
                                                  style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic))
                                            ],
                                          ),
                                        ))
                                    .toList()
                              ]),
                            );
                          }, childCount: 1))
                        ],
                      ),
                    );
        }));
  }
}
