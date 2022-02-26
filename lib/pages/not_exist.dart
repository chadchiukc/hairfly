import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotExistPage extends StatelessWidget {
  NotExistPage({Key? key}) : super(key: key);

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
                    ((context, index) => SizedBox(
                        height: Get.height * 0.7,
                        child: Center(
                            child: Text(
                          'notExtist'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )))),
                    childCount: 1))
          ],
        ),
      ),
    );
  }
}
