import 'package:flutter/material.dart';

Widget myHeading(String text, {Widget? trailing}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, top: 20, bottom: 5, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Roboto'),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    ),
  );
}
