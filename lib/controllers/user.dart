import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hairfly/controllers/carousel.dart';
import 'package:hairfly/models/user.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/database.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UserController extends GetxController {
  final Rx<UserModel> myUser = UserModel().obs;
  GetStorage box = GetStorage();
  var changeNo = 0.obs;
  final CarouselCtrl _carouselCtrl = Get.find();

  UserModel get user => myUser.value;

  set user(UserModel value) => myUser.value = value;
  String? get genderInFull => convertGenderToFullName(myUser.value.gender);
  String? get userId => myUser.value.id;

  void clear() {
    myUser.value = UserModel();
    box.remove('user');
  }

  void syncFirebase(String? uid) async {
    if (uid != null) {
      try {
        myUser.value = await Database().getUser(uid);
        await writeInLocal();
      } catch (e) {
        rethrow;
      }
    }
  }

  String convertGenderToFullName(String? gender) {
    //eg. m to male
    return gender == 'm' ? 'male' : 'female';
  }

  // too complex. need to rework. just a work around now
  Future<void> updateUser(
    UpdateKey key, {
    IconData? iconData,
    TextEditingController? textEditingController,
  }) async {
    final formkey = GlobalKey<FormState>();
    var _key = 'name';
    var isInt = false;
    var isGender = false;
    switch (key) {
      case UpdateKey.gender:
        _key = 'gender';
        isGender = true;
        break;
      case UpdateKey.name:
        _key = 'name';
        textEditingController?.text = user.name ?? '';
        break;
      case UpdateKey.phone:
        _key = 'phone';
        textEditingController?.text = user.phone?.toString() ?? '';
        isInt = true;
        break;
    }
    Get.defaultDialog(
        textCancel: 'cancel'.tr,
        textConfirm: 'confirm'.tr,
        title: 'edit'.tr + ' ' + _key.tr,
        onConfirm: () async {
          var needUpdate = false;
          try {
            switch (key) {
              case UpdateKey.gender:
                needUpdate = myUser.value.gender !=
                    _carouselCtrl.convertIndexToStr(_carouselCtrl.gender.value);
                myUser.value.gender =
                    _carouselCtrl.convertIndexToStr(_carouselCtrl.gender.value);
                break;
              case UpdateKey.name:
                needUpdate = myUser.value.name != textEditingController?.text;
                myUser.value.name = textEditingController?.text;
                break;
              case UpdateKey.phone:
                needUpdate = myUser.value.phone.toString() !=
                    textEditingController?.text;
                myUser.value.phone =
                    int.tryParse(textEditingController?.text ?? '');
                break;
            }
            if (needUpdate && (isGender || formkey.currentState!.validate())) {
              EasyLoading.show(status: 'loading'.tr);
              changeNo.value += 1;
              await Database().updateUser(
                  myUser.value.id!,
                  _key,
                  isInt
                      ? int.tryParse(textEditingController?.text ?? '')
                      : isGender
                          ? _carouselCtrl
                              .convertIndexToStr(_carouselCtrl.gender.value)
                          : textEditingController?.text);
              await writeInLocal();
            }
            if (isGender || formkey.currentState!.validate()) Get.back();
            EasyLoading.dismiss();
          } catch (e) {
            Get.snackbar('wrongMsg'.tr, e.toString());
            Get.back();
            EasyLoading.dismiss();
          }
        },
        content: isGender
            ? Card(
                elevation: 10,
                shadowColor: kAppBarColor,
                color: Colors.transparent,
                child: ToggleSwitch(
                    minWidth: 100,
                    minHeight: 50,
                    initialLabelIndex: _carouselCtrl.gender.value,
                    cornerRadius: 20.0,
                    inactiveFgColor: Colors.white,
                    inactiveBgColor: Colors.black.withOpacity(0.1),
                    totalSwitches: 2,
                    icons: const [Icons.male, Icons.female],
                    activeBgColors: const [
                      [Colors.white, Colors.blue],
                      [Colors.white, Colors.pink]
                    ],
                    onToggle: (index) {
                      _carouselCtrl.changeGender(index ?? 0);
                    }))
            : Form(
                key: formkey,
                child: TextFormField(
                  maxLength: isInt ? 8 : null,
                  inputFormatters:
                      isInt ? [FilteringTextInputFormatter.digitsOnly] : null,
                  decoration: InputDecoration(
                    prefixIcon: Icon(iconData),
                  ),
                  controller: textEditingController,
                  keyboardType: isInt ? TextInputType.number : null,
                  validator: (value) {
                    if (isInt && value!.length != 8) {
                      return 'phoneReminder'.tr;
                    }
                    return null;
                  },
                ),
              ));
  }

  String? validatePhone(bool isInt, String value) {
    if (isInt && value.length != 8) {
      return 'phoneReminder'.tr;
    }
    return null;
  }

  Future<void> writeInLocal() async {
    box.write('user', {
      'id': myUser.value.id,
      'name': myUser.value.name,
      'phone': myUser.value.phone,
      'email': myUser.value.email,
      'gender': myUser.value.gender,
      'privilege': 'customer',
    });
  }
}
