import 'package:flutter/material.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/shops.dart';
import 'package:hairfly/models/status.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/routes.dart';
import 'package:hairfly/widgets/divider.dart';
import 'package:hairfly/widgets/status_list.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:timelines/timelines.dart';
import 'package:get/get.dart';

class StatusCard extends StatelessWidget {
  final ShopCtrl _shopCtrl = Get.find();
  final LocaleCtrl _localeCtrl = Get.find();

  final List<String> statusWording;
  // final String shopId;
  final StatusModel status;

  StatusCard({
    Key? key,
    required this.statusWording,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _shop =
        _shopCtrl.shopList.firstWhereOrNull((shop) => shop.id == status.shopId);
    return Card(
      elevation: 15,
      shadowColor: kAppBarColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed('${Routes.booking}/${_shop!.id}',
                          arguments: Get.currentRoute);
                    },
                    child: Text(
                      '${_shop?.name}',
                      style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.clip,
                          decoration: TextDecoration.underline),
                    )),
                Text('createBy'.tr +
                    DateFormat('dd-MM-yyyy').format(status.bookByDatetime!)),
              ],
            ),
          ),
          myDivider(),
          Row(
            children: [
              SizedBox(
                width: 130,
                child: FixedTimeline.tileBuilder(
                  theme: TimelineTheme.of(context).copyWith(
                      nodePosition: 0.2,
                      indicatorTheme: IndicatorTheme.of(context)
                          .copyWith(color: Colors.purple, size: 20),
                      connectorTheme: ConnectorTheme.of(context)
                          .copyWith(thickness: 4, color: kAppBarColor)),
                  builder: TimelineTileBuilder.connectedFromStyle(
                    connectionDirection: ConnectionDirection.before,
                    contentsBuilder: (context, index) =>
                        Text(statusWording[index]),
                    connectorStyleBuilder: (context, index) {
                      return (index <= status.status!)
                          ? ConnectorStyle.solidLine
                          : ConnectorStyle.dashedLine;
                    },
                    indicatorStyleBuilder: (context, index) =>
                        index <= status.status!
                            ? IndicatorStyle.dot
                            : IndicatorStyle.outlined,
                    itemExtent: 50.0,
                    itemCount: 4,
                  ),
                ),
              ),
              const SizedBox(
                height: 210,
                child: VerticalDivider(
                  thickness: 3,
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      statusList(
                        'address'.tr,
                        '',
                        text2Widget: Flexible(
                          child: GestureDetector(
                              onTap: () => {
                                    MapsLauncher.launchCoordinates(
                                        _shop!.latLon!.latitude,
                                        _shop.latLon!.longitude)
                                  },
                              child: Text(
                                _localeCtrl.localeIdx == 0
                                    ? _shop!.address!
                                    : _shop!.addressZh!,
                                maxLines: 3,
                                style: const TextStyle(
                                    overflow: TextOverflow.clip,
                                    decoration: TextDecoration.underline),
                              )),
                        ),
                      ),
                      statusList('tel'.tr, _shop.tel?.toString() ?? ''),
                      statusList(
                          'bookingServices'.tr, status.services!.toString(),
                          text2Widget: Flexible(
                            child: Wrap(
                              children: status.services!
                                  .map((e) => Card(
                                        child: Text(e),
                                        elevation: 4,
                                        shadowColor: kAppBarColor,
                                      ))
                                  .toList(),
                            ),
                          )),
                      statusList(
                          'bookingDate'.tr,
                          DateFormat('EEEE, dd-MM-yyyy')
                              .format(status.bookingDatetime!)),
                      statusList('bookingTime'.tr,
                          DateFormat.Hm().format(status.bookingDatetime!)),
                      statusList('price:'.tr, status.price?.toString() ?? ''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
