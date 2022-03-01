import 'package:flutter/material.dart';

Widget statusList(String text1, String text2, {Widget? text2Widget}) {
  return Flexible(
    child: Row(
      children: [
        SizedBox(width: 70, child: Text(text1)),
        text2Widget ?? Text(text2),
      ],
    ),
  );
}
