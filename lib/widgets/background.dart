import 'package:flutter/material.dart';

const kBackground = BoxDecoration(
  image: DecorationImage(
      // colorFilter: ColorFilter.mode(
      // Colors.black.withOpacity(0.3),
      // BlendMode.dstATop,
      // ),
      image: AssetImage('assets/images/background.png'),
      fit: BoxFit.cover),
);
