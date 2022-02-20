import 'package:flutter/material.dart';
import 'package:hairfly/utils/constant.dart';

Widget mapListTile(IconData leading, Widget widget) {
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
