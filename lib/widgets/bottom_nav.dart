import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/bottom_nav.dart';

class BottomNav extends StatelessWidget {
  BottomNav({Key? key}) : super(key: key);
  final NavCtrl _navCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
            Theme.of(context).appBarTheme.backgroundColor!,
            Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.1),
          ])),
      child: ConvexAppBar(
          height: 40,
          color: Colors.black,
          backgroundColor: Colors.transparent,
          // backgroundColor:
          // Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.5),
          onTap: (index) => _navCtrl.idx = index,
          style: TabStyle.reactCircle,
          items: const [
            TabItem(icon: Icon(Icons.home)),
            TabItem(icon: Icon(Icons.search)),
            TabItem(icon: Icon(Icons.edit)),
            TabItem(icon: Icon(Icons.message)),
            TabItem(icon: Icon(Icons.person)),
          ]),
    );
  }
}
