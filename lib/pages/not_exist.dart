import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/not_exist.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NotExistPage extends StatelessWidget {
  const NotExistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(NotExistCtrl());
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
                        child: Column(
                          children: [
                            Text(
                              'notExtist'.tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            const Icon(
                              Icons.cancel_presentation,
                              size: 200,
                              color: Colors.grey,
                            )
                          ],
                        ))),
                    childCount: 1))
          ],
        ),
      ),
    );
  }
}
