import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/map.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/utils/cached_tile_provider.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/zoom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:hairfly/widgets/image_network.dart';
import 'package:hairfly/widgets/map_list_tile.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MapPage extends StatelessWidget {
  MapPage({Key? key}) : super(key: key);
  final MapCtrl _mapCtrl = Get.put(MapCtrl());
  final ShopCtrl _shopCtrl = Get.find();
  final LocaleCtrl _localeCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterMap(
        mapController: _mapCtrl.mapController,
        options: MapOptions(
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
              markers: _shopCtrl.shopList
                  .asMap()
                  .keys
                  .toList()
                  .map(
                    (e) => Marker(
                      height: 800,
                      width: 320,
                      anchorPos: AnchorPos.align(AnchorAlign.top),
                      point: _shopCtrl.shopList[e].latLon!,
                      builder: (_) => Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _shopCtrl.selectedShopIndex.value != e
                                ? const SizedBox.shrink()
                                // detail box for the selected shop on map
                                : Card(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Card(
                                                elevation: 5,
                                                shadowColor: Theme.of(context)
                                                    .appBarTheme
                                                    .backgroundColor,
                                                child: SizedBox(
                                                    height: 120,
                                                    width: 180,
                                                    child: myImage(
                                                        _shopCtrl
                                                            .shopList[e].img!,
                                                        'shop')),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  //shop name
                                                  Card(
                                                    elevation: 10,
                                                    child: Text(
                                                      _shopCtrl
                                                          .shopList[e].name!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: kShopNameInMap,
                                                    ),
                                                  ),
                                                  // rating bar
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: RatingBarIndicator(
                                                      rating: _shopCtrl
                                                          .shopRating(_shopCtrl
                                                              .shopList[e]
                                                              .rating),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              const Icon(
                                                        Icons.cut,
                                                        color: Colors.amber,
                                                      ),
                                                      itemSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    '('
                                                            '${_shopCtrl.shopReviwer(_shopCtrl.shopList[e].rating)} ' +
                                                        'review'.trPlural(
                                                            'reviews',
                                                            _shopCtrl.shopReviwer(
                                                                _shopCtrl
                                                                    .shopList[e]
                                                                    .rating)) +
                                                        ')',
                                                    style: const TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          mapListTile(
                                            Icons.home,
                                            GestureDetector(
                                              onTap: () => {
                                                MapsLauncher.launchCoordinates(
                                                    _shopCtrl.shopList[e]
                                                        .latLon!.latitude,
                                                    _shopCtrl.shopList[e]
                                                        .latLon!.longitude)
                                              },
                                              child: Text(
                                                _localeCtrl.localeIdx == 0
                                                    ? _shopCtrl
                                                        .shopList[e].address!
                                                    : _shopCtrl
                                                        .shopList[e].addressZh!,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                            ),
                                          ),
                                          mapListTile(
                                            Icons.phone,
                                            Text(
                                              _shopCtrl.shopList[e].tel!
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  icon: const Icon(
                                                      Icons.arrow_back),
                                                  onPressed: () {
                                                    _shopCtrl.cancelShopOnMap(
                                                        () => _mapCtrl
                                                            .animatedMapMove(
                                                                kCenter,
                                                                kZoom
                                                                    .toDouble()));
                                                  }),
                                              TextButton(
                                                  onPressed: () {},
                                                  child:
                                                      Text('book_on_map'.tr)),
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
                                                  _shopCtrl.shopList[e].latLon!
                                                          .latitude +
                                                      kLatOffset,
                                                  _shopCtrl.shopList[e].latLon!
                                                      .longitude),
                                              15));
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()),
        ],
      ),
    );
  }
}
