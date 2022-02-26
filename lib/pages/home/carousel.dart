import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/carousel.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/widgets/image_network.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MyCarousel extends StatelessWidget {
  MyCarousel({Key? key}) : super(key: key);
  final CarouselCtrl _carouselCtrl = Get.find();
  final ShopCtrl _shopCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(children: [
          SizedBox(
            width: context.width,
            height: getValueForScreenType(
                context: context,
                mobile: Get.height * 0.3,
                tablet: Get.height * 0.4,
                desktop: Get.height * 0.4),
            child: !_carouselCtrl.isFetched.value
                ? const SizedBox.shrink()
                : CarouselSlider(
                    items: _carouselCtrl.filterImgList
                        .map((item) => ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            child: Stack(
                              fit: StackFit.passthrough,
                              children: [
                                SizedBox(
                                    width: getValueForScreenType(
                                        context: context,
                                        mobile: 300,
                                        tablet: 500,
                                        desktop: 500),
                                    height: getValueForScreenType(
                                        context: context,
                                        mobile: 300,
                                        tablet: 500,
                                        desktop: 500),
                                    child: myImage(item.datetime!, 'gallery',
                                        isJpg: true)),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          kAppBarColor,
                                          kAppBarColor.withOpacity(0),
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                    child: !_shopCtrl.isFetch.value
                                        ? const SizedBox.shrink()
                                        : Text(
                                            'by'.tr +
                                                _shopCtrl.shopList
                                                    .firstWhere((element) =>
                                                        element.id == item.from)
                                                    .name!,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            )))
                        .toList(),
                    carouselController: _carouselCtrl.carouselCtrl,
                    options: CarouselOptions(
                        autoPlayInterval: const Duration(seconds: 6),
                        // viewportFraction: 0.2,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        // aspectRatio: 2,
                        onPageChanged: (index, reason) {
                          _carouselCtrl.setIndex = index;
                        }),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _carouselCtrl.filterImgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () =>
                    _carouselCtrl.carouselCtrl.animateToPage(entry.key),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(
                          _carouselCtrl.index == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ]));
  }
}
