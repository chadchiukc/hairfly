import 'package:flutter/material.dart';
import 'package:hairfly/utils/constant.dart';

Widget myMapListTile(IconData leading, Widget widget) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          leading,
          color: kAppBarColor,
        ),
        Padding(padding: const EdgeInsets.only(left: 10.0), child: widget),
      ],
    ),
  );
}

Widget myShopListTile(IconData leading, Widget widget,
    {bool enlargeIcon = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 5.0, top: 3, bottom: 3),
        child: Icon(
          leading,
          color: kAppBarColor,
          size: enlargeIcon ? 25 : 20,
        ),
      ),
      widget,
    ],
  );
}
