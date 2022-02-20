import 'package:flutter/material.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/widgets/heading.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double logoRadius;
  final Widget? widget;
  final ImageProvider? imageProvider;

  MySliverAppBar(
      {required this.expandedHeight,
      this.widget,
      this.imageProvider,
      this.logoRadius = 130});

  @override
  double get maxExtent => expandedHeight;
  @override
  double get minExtent => kToolbarHeight;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
            gradient: LinearGradient(
              colors: [
                kAppBarColor.withOpacity(0),
                kAppBarColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        widget == null
            ? const SizedBox.shrink()
            : Center(
                child: Opacity(
                    opacity: shrinkOffset / expandedHeight, child: widget),
              ),
        Positioned(
          top: expandedHeight - logoRadius / 2 - 70 - shrinkOffset,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: shrinkOffset > 30 ? 0 : 1,
            child: Card(
              elevation: 20,
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: CircleAvatar(
                radius: logoRadius,
                backgroundColor: kLogoBorderColor,
                child: CircleAvatar(
                  radius: logoRadius - 10,
                  backgroundImage: imageProvider ??
                      const AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
