import 'package:flutter/material.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:hairfly/widgets/heading.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate:
                  MySliverAppBar(expandedHeight: 200.0, widget: myHeading('1')),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 140,
                ),
                listCardWidget(
                    text1: 'Full Name:', text2: 'George John Carter'),
                listCardWidget(text1: 'Father\'s Name:', text2: 'John Carter'),
                listCardWidget(text1: 'Gender:', text2: 'Male'),
                listCardWidget(text1: 'Marital Status:', text2: 'Single'),
                listCardWidget(
                    text1: 'Full Name:', text2: 'George John Carter'),
                listCardWidget(text1: 'Father\'s Name:', text2: 'John Carter'),
                listCardWidget(text1: 'Gender:', text2: 'Male'),
                listCardWidget(text1: 'Marital Status:', text2: 'Single'),
                listCardWidget(
                    text1: 'Full Name:', text2: 'George John Carter'),
                listCardWidget(text1: 'Father\'s Name:', text2: 'John Carter'),
                listCardWidget(text1: 'Gender:', text2: 'Male'),
                listCardWidget(text1: 'Marital Status:', text2: 'Single'),
              ]),
            )
          ],
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }

  Widget listCardWidget({required String text1, required text2}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
                fit: FlexFit.tight,
                child: Text(
                  text1,
                  style: const TextStyle(fontSize: 18),
                )),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Text(
                text2,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
