import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/controllers/locale.dart';
import 'package:hairfly/controllers/profile_image.dart';
import 'package:hairfly/controllers/user.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:hairfly/widgets/profile_card.dart';
import 'package:responsive_builder/responsive_builder.dart';

// a workaround for the sliver list updating issue
// need to fix again later
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final UserController _userController = Get.find();
  final AuthController _authController = Get.find();
  final ProfileImageCtrl _profileImageCtrl = Get.put(ProfileImageCtrl());
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController genderCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameCtrl.text = _userController.user.name ?? '';
    genderCtrl.text = _userController.user.gender ?? '';
    phoneCtrl.text = _userController.user.phone?.toString() ?? '';
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: getValueForScreenType(
              context: context,
              mobile: 0,
              tablet: Get.width * 0.08,
              desktop: Get.width * 0.16)),
      decoration: kBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            Obx(
              () {
                return SliverPersistentHeader(
                  pinned: true,
                  delegate: MySliverAppBar(
                    expandedHeight: 200.0,
                    imageProvider: _profileImageCtrl.versionNo.value == 0 &&
                            _profileImageCtrl.profileFile.value == null
                        ? const AssetImage('assets/images/profile.jpeg')
                        // : FileImage(_profileImageCtrl.profileFile.value!)
                        // as ImageProvider,
                        : MemoryImage(_profileImageCtrl.profileFile.value!)
                            as ImageProvider,
                    editable: true,
                    editCallback: () => _profileImageCtrl
                        .imageCropUpload(_userController.userId),
                  ),
                );
              },
            ),
            Obx(() {
              return _userController.changeNo.value < 0
                  ? const SizedBox.shrink()
                  : SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(
                          height: 140,
                        ),
                        profileCard(
                            'profileEmail'.tr, _userController.user.email,
                            editable: false),
                        profileCard('profileName'.tr, _userController.user.name,
                            editCallback: () {
                          _userController.updateUser(UpdateKey.name,
                              iconData: Icons.supervised_user_circle_rounded,
                              textEditingController: nameCtrl);
                        }),
                        profileCard('profileGender'.tr,
                            _userController.genderInFull!.tr, editCallback: () {
                          _userController.updateUser(UpdateKey.gender);
                        }),
                        profileCard('profilePhone'.tr,
                            _userController.user.phone.toString(),
                            editCallback: () {
                          _userController.updateUser(UpdateKey.phone,
                              iconData: Icons.phone,
                              textEditingController: phoneCtrl);
                        }),
                        Center(
                          child: ElevatedButton(
                              onPressed: () =>
                                  _authController.signout(navToHome: true),
                              child: Text('signOut'.tr)),
                        ),
                      ]),
                    );
            }),
          ],
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
