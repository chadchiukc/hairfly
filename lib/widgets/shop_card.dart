import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/models/shop.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/routes.dart';
import 'package:hairfly/widgets/image_network.dart';
import 'package:hairfly/widgets/list_tile.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_builder/responsive_builder.dart';

Widget shopCard({
  required BuildContext context,
  required ShopModel shop,
  required LocaleCtrl localeCtrl,
  required ShopCtrl shopCtrl,
}) {
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
                    borderRadius: const BorderRadius.all(Radius.circular(2)),
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
                        child: myImage(shop.img!, 'shop')),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(shop.name!,
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
                                        MapsLauncher.launchCoordinates(
                                            shop.latLon!.latitude,
                                            shop.latLon!.longitude)
                                      },
                                  child: Text(
                                    localeCtrl.localeIdx == 0
                                        ? shop.address!
                                        : shop.addressZh!,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        overflow: TextOverflow.clip,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline),
                                  ))),
                        ),
                        myShopListTile(
                            Icons.phone,
                            Text(shop.tel!.toString(),
                                style: const TextStyle(fontSize: 12))),
                        myShopListTile(
                            Icons.alarm,
                            Text(shop.openHour!.toString(),
                                style: const TextStyle(fontSize: 12))),
                        myShopListTile(
                            Icons.room_service_outlined,
                            Expanded(
                              child: Wrap(
                                  spacing: 5,
                                  children: shop.services!.keys
                                      .toList()
                                      .map((e) => Text(e,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          )))
                                      .toList()),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    RatingBarIndicator(
                                      rating: shopCtrl.shopRating(shop.rating),
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.cut,
                                        color: Colors.amber,
                                      ),
                                      itemSize: 15,
                                    ),
                                    Text(
                                      shopCtrl.toNumOfReviewString(
                                          shopCtrl.shopReviwer(shop.rating),
                                          'review',
                                          'reviews'),
                                      style: const TextStyle(
                                          fontSize: 10,
                                          fontStyle: FontStyle.italic),
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
                  onPressed: () {
                    Get.toNamed('${Routes.booking}/${shop.id}',
                        arguments: Get.currentRoute);
                  },
                  child: Text(
                    'detail'.tr,
                    style: const TextStyle(fontSize: 12),
                  )),
            )
          ],
        ),
      ));
}
