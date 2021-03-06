import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/status.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:hairfly/widgets/status_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

class StatusPage extends StatelessWidget {
  StatusPage({Key? key}) : super(key: key);
  final StatusCtrl _statusCtrl = Get.put(StatusCtrl());

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
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: MySliverAppBar(expandedHeight: 150.0, logoRadius: 80),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    ((context, index) => Obx(
                          () => !_statusCtrl.isFetched.value
                              ? SizedBox(
                                  height: Get.height * 0.4,
                                  child: const Center(
                                      child: CircularProgressIndicator()))
                              : _statusCtrl.bookingList.isEmpty
                                  ? SizedBox(
                                      height: Get.height * 0.6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'noBooking'.tr,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Icon(
                                            Icons.cancel_presentation,
                                            size: 200,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 50),
                                        // StatusCard(
                                        //   statusWording:
                                        //       _statusCtrl.statusWording,
                                        //   status: _statusCtrl.bookingList[0],
                                        // ),
                                        ..._statusCtrl.bookingList
                                            .map((element) => StatusCard(
                                                statusWording:
                                                    _statusCtrl.statusWording,
                                                status: element))
                                            .toList()
                                      ],
                                    ),
                        )),
                    childCount: 1))
          ],
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
