import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/map.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/utils/cached_tile_provider.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/routes.dart';
import 'package:hairfly/utils/zoom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:hairfly/widgets/image_network.dart';
import 'package:hairfly/widgets/list_tile.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);
  final MapCtrl _mapCtrl = Get.put(MapCtrl());
  final ShopCtrl _shopCtrl = Get.find();
  final LocaleCtrl _localeCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterMap(
        // mapController: _mapCtrl.mapController,
        options: MapOptions(
            onMapCreated: ((mapController) =>
                _mapCtrl.mapController = mapController),
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            nePanBoundary: kNePanBoundary,
            swPanBoundary: kSwPanBoundary,
            center: kCenter,
            zoom: kZoom.toDouble(),
            minZoom: kMinZoom.toDouble(),
            maxZoom: kMaxZoom.toDouble(),
            plugins: [ZoomButtonsPlugin()]),
        nonRotatedLayers: [
          ZoomButtonsPluginOption(
            padding: 0,
            minZoom: kMinZoom,
            maxZoom: kMaxZoom,
            zoomInColor: const Color.fromARGB(0, 255, 255, 255),
            zoomOutColor: const Color.fromARGB(0, 255, 255, 255),
          ),
        ],
        layers: [
          TileLayerOptions(
            opacity: 0.6,
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
            tileProvider: const CachedTileProvider(),
          ),
          MarkerLayerOptions(
              markers: _shopCtrl.shopList.asMap().keys.toList().map((e) {
            var _shop = _shopCtrl.shopList[e];
            return Marker(
              height: 800,
              width: 320,
              anchorPos: AnchorPos.align(AnchorAlign.top),
              point: _shop.latLon!,
              builder: (_) => Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _shopCtrl.selectedShopIndex.value != e
                        ? const SizedBox.shrink()
                        // detail box for the selected shop on map
                        : Card(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10, left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        shadowColor: Theme.of(context)
                                            .appBarTheme
                                            .backgroundColor,
                                        child: SizedBox(
                                            height: Get.height * 0.2 * 2 / 3,
                                            width: Get.height * 0.2,
                                            child: myImage(_shop.img!, 'shop')),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          //shop name
                                          Card(
                                            elevation: 10,
                                            child: Text(
                                              _shop.name!,
                                              overflow: TextOverflow.ellipsis,
                                              style: kShopNameInMap,
                                            ),
                                          ),
                                          // rating bar
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: RatingBarIndicator(
                                              rating: _shopCtrl
                                                  .shopRating(_shop.rating),
                                              itemBuilder: (context, index) =>
                                                  const Icon(
                                                Icons.cut,
                                                color: Colors.amber,
                                              ),
                                              itemSize: 20,
                                            ),
                                          ),
                                          Text(
                                            _shopCtrl.toNumOfReviewString(
                                                _shopCtrl.shopReviwer(_shopCtrl
                                                    .shopList[e].rating),
                                                'review',
                                                'reviews'),
                                            style: const TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  myMapListTile(
                                    Icons.home,
                                    GestureDetector(
                                      onTap: () => {
                                        MapsLauncher.launchCoordinates(
                                            _shopCtrl
                                                .shopList[e].latLon!.latitude,
                                            _shopCtrl
                                                .shopList[e].latLon!.longitude)
                                      },
                                      child: Text(
                                        _localeCtrl.localeIdx == 0
                                            ? _shop.address!
                                            : _shop.addressZh!,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ),
                                  myMapListTile(
                                    Icons.phone,
                                    Text(
                                      _shop.tel!.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.arrow_back),
                                          onPressed: () {
                                            _shopCtrl.cancelShopOnMap(() =>
                                                _mapCtrl.animatedMapMove(
                                                    kCenter, kZoom.toDouble()));
                                          }),
                                      TextButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                '${Routes.booking}/${_shop.id}');
                                          },
                                          child: Text('detail'.tr)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            elevation: 5,
                            shadowColor: Colors.grey,
                          ),
                    // the shop's icon displayed on the map
                    // the icon will not be visible if other is selected
                    _shopCtrl.selectedShopIndex.value != -1 &&
                            _shopCtrl.selectedShopIndex.value != e
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            child: const Icon(
                              Icons.pin_drop,
                            ),
                            onTap: () {
                              _shopCtrl.selectShopOnMap(
                                  e,
                                  () => _mapCtrl.animatedMapMove(
                                      kCenter, kZoom.toDouble()),
                                  () => _mapCtrl.animatedMapMove(
                                      LatLng(
                                          _shop.latLon!.latitude + kLatOffset,
                                          _shop.latLon!.longitude),
                                      15));
                            },
                          ),
                  ],
                ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
