import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'appbar_control.dart';
import 'package:hairfly/utils/constant.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({Key? key}) : super(key: key);
  final AppBarCtrl _appBarCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverAppBar(
        backgroundColor: Colors.transparent,
        pinned: false,
        // to smoothen the transition for the app bar
        // backgroundColor: _appBarCtrl.offset > kOpacityThreshold
        //     ? Theme.of(context).appBarTheme.backgroundColor!.withOpacity(
        //         (_appBarCtrl.offset - kOpacityThreshold) /
        //             (100 - kOpacityThreshold))
        //     // .withOpacity(0.9)
        //     : Colors.transparent,
        expandedHeight: kAppBarHeight,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          expandedTitleScale: 1,
          titlePadding: const EdgeInsets.all(5),
          // titlePadding: _appBarCtrl.isScrolled ? null : const EdgeInsets.all(5),
          title: AnimatedOpacity(
            opacity: _appBarCtrl.offset > 20 ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            child: const CircleAvatar(
              radius: kAppBarHeight / 2,
              backgroundColor: kLogoBorderColor,
              child: CircleAvatar(
                radius: kAppBarHeight / 2 - 5,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          background: SizedBox(
            height: 10,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'assets/images/appbar.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
