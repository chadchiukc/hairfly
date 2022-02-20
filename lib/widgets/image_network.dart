import 'package:flutter/material.dart';

Widget myImage(String imagePath, String imageFolder, {bool isJpg = false}) {
  var baseUrl =
      'https://firebasestorage.googleapis.com/v0/b/hairfly-69e89.appspot.com/o/$imageFolder%2f';
  var param = '?alt=media&token=3163b29b-9579-4510-953c-0cbc87f5dce1';
  imagePath = isJpg ? '$imagePath.jpg' : imagePath;

  return FadeInImage(
    fit: BoxFit.cover,
    placeholderErrorBuilder: (context, error, stackTrace) => Image.asset(
      'assets/images/placeholder.png',
      fit: BoxFit.cover,
    ),
    imageErrorBuilder: (context, error, stackTrace) =>
        Image.asset('assets/images/placeholder.png', fit: BoxFit.cover),
    placeholder: const AssetImage('assets/images/placeholder.png'),
    image: NetworkImage('$baseUrl$imagePath$param'),
  );
}
