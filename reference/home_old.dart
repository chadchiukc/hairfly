// import 'package:flutter/material.dart';
// import 'appbar_control.dart';
// import 'package:get/get.dart';
// import 'package:hairfly/controllers/carousel.dart';
// import 'package:hairfly/controllers/locale.dart';
// import 'package:hairfly/pages/home/map.dart';
// import 'package:hairfly/utils/constant.dart';
// import 'package:hairfly/utils/database.dart';
// import 'appbar.dart';
// import 'package:hairfly/widgets/background.dart';
// import 'package:hairfly/widgets/bottom_nav.dart';
// import 'package:hairfly/widgets/card.dart';
// import 'package:hairfly/pages/home/carousel.dart';
// import 'package:hairfly/widgets/heading.dart';

// class HomeOldPage extends StatelessWidget {
//   HomeOldPage({Key? key}) : super(key: key);
//   final AppBarCtrl _appBarCtrl = Get.put(AppBarCtrl());
//   final LocaleCtrl _localeCtrl = Get.put(LocaleCtrl());

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: kBackground,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(fit: StackFit.expand, children: [
//           NestedScrollView(
//             controller: _appBarCtrl.scrollCtrl,
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return [
//                 MyAppBar(),
//               ];
//             },
//             body: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   myHeading(
//                     'explore'.tr,
//                   ),
//                   Center(
//                     child: SizedBox(
//                       width: context.width * 0.9,
//                       height: context.height * 0.3,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Expanded(
//                             flex: 5,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Expanded(
//                                   child: MyCard(
//                                     'haircuts'.tr,
//                                     'assets/images/cut.png',
//                                     imageRatio: 2.2,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Expanded(
//                                           flex: 3,
//                                           child: MyCard(
//                                             'color'.tr,
//                                             'assets/images/color.png',
//                                             imageRatio: 1.5,
//                                           )),
//                                       Expanded(
//                                           flex: 2,
//                                           child: MyCard(
//                                             'treatment'.tr,
//                                             'assets/images/treatment.png',
//                                           )),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                               flex: 3,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   Expanded(
//                                       child: MyCard(
//                                     'perm'.tr,
//                                     'assets/images/perm.png',
//                                     imageRatio: 1.5,
//                                   )),
//                                   Expanded(
//                                       child: MyCard(
//                                     'join'.tr,
//                                     'assets/images/sale.png',
//                                     imageRatio: 1.5,
//                                   )),
//                                 ],
//                               )),
//                         ],
//                       ),
//                     ),
//                   ),
//                   myHeading('recommend'.tr),
//                   MyCarousel(),
//                   ElevatedButton(
//                       onPressed:
//                           // Database().downloadURLExample('a');
//                           _localeCtrl.changeLocale,
//                       child: const Text('a')),
//                   Card(
//                     color: Colors.transparent,
//                     elevation: 10,
//                     shadowColor: Theme.of(context).appBarTheme.backgroundColor,
//                     child: Center(
//                       child: SizedBox(
//                           width: context.width * 0.9,
//                           height: Get.height * 0.35,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(15),
//                               child: MapPage())),
//                     ),
//                   ),
//                   SizedBox(
//                     height: Get.height * 0.05,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]),
//         bottomNavigationBar: BottomNav(),
//       ),
//     );
//   }
// }
