import 'dart:math';

import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final double imageRatio;
  final String text;
  final String imagePath;

  const ExploreCard(
    this.text,
    this.imagePath, {
    Key? key,
    this.imageRatio = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).primaryColor,
      elevation: 15,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.only(
              top: 8, left: 8, right: 8, bottom: 2.5 * imageRatio),
          child: Stack(
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: Color.fromARGB(255, 98, 94, 94),
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Transform.rotate(
                  angle: -pi / 30,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.fill,
                    width: 50 * imageRatio,
                    height: 50 * imageRatio,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Widget myCard(String text, String imagePath, {double imageRatio = 1}) {
//   return Card(
//       elevation: 15,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       child: SizedBox(
//         child: Padding(
//           padding: EdgeInsets.only(
//               top: 8, left: 8, right: 8, bottom: 2.5 * imageRatio),
//           child: Stack(
//             children: [
//               Text(
//                 text,
//                 style:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//               ),
//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: Transform.rotate(
//                   angle: -pi / 30,
//                   child: Image.asset(
//                     imagePath,
//                     fit: BoxFit.fill,
//                     width: 50 * imageRatio,
//                     height: 50 * imageRatio,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
// }