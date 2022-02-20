import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

const double kAppBarHeight = 120;
const int kOpacityThreshold = 50;
const Color kLogoBorderColor = Color.fromARGB(57, 239, 70, 231);
// const Color kLogoBorderColor = Color.fromARGB(148, 239, 28, 183);
const Color kAppBarColor = Color.fromARGB(200, 243, 167, 192);
var kNePanBoundary = LatLng(22.45, 114.3);
var kSwPanBoundary = LatLng(22.22, 114.0);
var kCenter = LatLng(22.302711, 114.177216);
const int kZoom = 12;
const int kMinZoom = 11;
const int kMaxZoom = 22;
const kShopNameInMap = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic);
const kLatOffset = 0.005;
