import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Test2 extends StatelessWidget {
  const Test2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //   return RatingBarIndicator(
    //     rating: 2.75,
    //     itemBuilder: (context, index) => Icon(
    //       Icons.cut,
    //       color: Colors.amber,
    //     ),
    //     itemSize: 30,
    //   );
    // }
    return Center(
      child: RatingBar.builder(
          initialRating: 3,
          minRating: 0,
          allowHalfRating: true,
          itemCount: 5,
          // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
                Icons.cut,
                color: Colors.amber,
              ),
          onRatingUpdate: (rating) {
            print(rating);
          }),
    );
  }
}
