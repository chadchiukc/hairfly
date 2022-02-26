import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/bottom_nav.dart';
import 'package:hairfly/utils/constant.dart';

class BottomNav extends StatelessWidget {
  BottomNav({Key? key}) : super(key: key);
  final NavCtrl _navCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
        selectedItemColor: kAppBarColor,
        backgroundColor: Colors.white,
        marginR: EdgeInsets.symmetric(
            horizontal: context.width * 0.15, vertical: 10),
        paddingR: const EdgeInsets.symmetric(vertical: 2),
        boxShadow: const [
          BoxShadow(
              color: kAppBarColor,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 8))
        ],
        currentIndex: _navCtrl.getIndex,
        onTap: (index) => _navCtrl.navigation(index),
        items: [
          DotNavigationBarItem(icon: const Icon(Icons.home)),
          DotNavigationBarItem(icon: const Icon(Icons.search)),
          DotNavigationBarItem(icon: const Icon(Icons.message)),
          DotNavigationBarItem(icon: const Icon(Icons.person)),
        ]);
    // Container(
    //   decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //           begin: Alignment.topRight,
    //           end: Alignment.bottomLeft,
    //           colors: [
    //         kAppBarColor,
    //         kAppBarColor.withOpacity(0.1),
    //       ])),
    //   child: ConvexAppBar(
    //       controller: _navCtrl.tabController,
    //       height: 40,
    //       color: Colors.black,
    //       backgroundColor: Colors.transparent,
    //       onTap: (index) => _navCtrl.navigation(index),
    //       style: TabStyle.reactCircle,
    //       items: const [
    //         TabItem(icon: Icon(Icons.home)),
    //         TabItem(icon: Icon(Icons.search)),
    //         TabItem(icon: Icon(Icons.message)),
    //         TabItem(icon: Icon(Icons.person)),
    //       ]),
    // );
  }
}
