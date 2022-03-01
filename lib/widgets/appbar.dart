import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/routes.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double logoRadius;
  final Widget? widget;
  final ImageProvider? imageProvider;
  final bool editable;
  final bool backwardable;
  final Function()? editCallback;
  final bool borderRadius;
  // String returnUrl = Get.parameters['return'] ?? '/';
  final returnUrl = Get.arguments ?? Routes.home;
  // final returnUrl = Get.arguments ?? Routes.home;

  MySliverAppBar(
      {required this.expandedHeight,
      this.widget,
      this.imageProvider,
      this.logoRadius = 130,
      this.editable = false,
      this.backwardable = false,
      this.borderRadius = true,
      this.editCallback});

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
            borderRadius: borderRadius
                ? const BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  )
                : null,
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
                  backgroundColor: Colors.transparent,
                  radius: logoRadius - 10,
                  backgroundImage: imageProvider ??
                      const AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ),
        ),
        !editable
            ? const SizedBox.shrink()
            : Positioned(
                right: context.width / 2 - logoRadius + 30,
                top: expandedHeight - logoRadius + 10 - shrinkOffset,
                child: GestureDetector(
                  onTap: editCallback,
                  child: AnimatedOpacity(
                    opacity: shrinkOffset > 30 ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 222, 139, 166),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                  ),
                )),
        !backwardable
            ? const SizedBox.shrink()
            : Positioned(
                top: expandedHeight - 90 - shrinkOffset,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    if (returnUrl == Routes.profile ||
                        returnUrl == Routes.status) {
                      Get.offAllNamed(Routes.home);
                    } else {
                      Get.offNamed(returnUrl);
                    }
                  },
                  child: AnimatedOpacity(
                    opacity: shrinkOffset > 30 ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    child: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 224, 159, 181),
                        child: Icon(
                          Icons.arrow_back_ios_new_sharp,
                          color: Colors.white,
                        )),
                  ),
                )),
      ],
    );
  }
}
