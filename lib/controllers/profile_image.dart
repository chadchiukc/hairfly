import 'dart:async';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/user.dart';
import 'package:hairfly/utils/database.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

class ProfileImageCtrl extends GetxController {
  final UserController _userController = Get.find();
  final ImagePicker _picker = ImagePicker();
  Rx<Uint8List?> profileFile = null.obs;
  var versionNo = 0.obs;
  CropController cropController = CropController();

  bool get isFileReady => profileFile.value != null;

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 1));
    profileFile = (await convertImageToList(_userController.userId)).obs;
    versionNo += 1;
    if (_userController.userId == null) {
      once(_userController.myUser, (_) async {
        profileFile = (await convertImageToList(_userController.userId)).obs;
        versionNo += 1;
      });
    }
    super.onInit();
  }

  Future<XFile?> _pickImage() async {
    try {
      return _picker.pickImage(
          source: ImageSource.gallery, maxHeight: 300, maxWidth: 300);
    } catch (e) {
      Get.snackbar('errorMsg'.tr, e.toString());
      return null;
    }
  }

  Future<XFile?> _takeImage() async {
    try {
      return _picker.pickImage(
          preferredCameraDevice: CameraDevice.front,
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300);
    } catch (e) {
      Get.snackbar('errorMsg'.tr, e.toString());
      return null;
    }
  }

  Future<Uint8List?> imageSelect({bool isPickImage = false}) async {
    XFile? img;
    if (isPickImage) {
      img = await _pickImage();
    } else {
      img = await _takeImage();
    }
    Uint8List? data = await img?.readAsBytes();
    if (data != null) {
      return data;
    }
    return null;
  }

  void imageCropUpload(String? userId) async {
    Uint8List? img;
    await Get.defaultDialog(
      title: 'profileChooseSource'.tr,
      middleText: '',
      content: Column(
        children: [
          TextButton(
              onPressed: () async {
                img = await imageSelect(isPickImage: true);
                profileBottomSheet(img, userId);
              },
              child: Text(
                'profileGallery'.tr,
                style: const TextStyle(fontSize: 20),
              )),
          TextButton(
              onPressed: () async {
                img = await imageSelect();
                profileBottomSheet(img, userId);
              },
              child: Text(
                'profileCamera'.tr,
                style: const TextStyle(fontSize: 20),
              )),
        ],
      ),
    );
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  void profileBottomSheet(Uint8List? img, String? userId) async {
    if (img != null && userId != null) {
      Get.bottomSheet(
          SizedBox(
            height: Get.height * 0.8,
            child: Column(children: [
              SizedBox(
                  height: Get.height * 0.6,
                  child: Crop(
                      // baseColor: Colors.transparent,
                      // maskColor: Colors.transparent,
                      controller: cropController,
                      withCircleUi: true,
                      image: img,
                      onCropped: (data) async {
                        try {
                          EasyLoading.show(status: 'uploading'.tr);
                          await Database().uploadProfileImage(data, userId);
                          profileFile = data.obs;
                          versionNo.value += 1;
                        } catch (e) {
                          Get.snackbar('errorMsg'.tr, e.toString());
                        }
                        EasyLoading.dismiss();
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () => Get.back(), child: Text('cancel'.tr)),
                  ElevatedButton(
                      onPressed: () {
                        cropController.crop();
                        Get.back();
                        Get.back();
                      },
                      child: Text('confirm'.tr)),
                ],
              ),
            ]),
          ),
          isDismissible: false,
          isScrollControlled: true);
    }
  }

  // void selectImageSource(String? userId) async {
  //   var isUpload = false;
  //   await Get.defaultDialog(
  //     title: 'profileChooseSource'.tr,
  //     middleText: '',
  //     content: Column(
  //       children: [
  //         TextButton(
  //             onPressed: () async {
  //               isUpload = await imageUpload(userId, isPickImage: true);
  //               profileFile =
  //                   (await convertImageToList(_userController.userId)).obs;
  //               versionNo.value += 1;
  //               if (isUpload) {
  //                 Get.back();
  //               }
  //             },
  //             child: Text(
  //               'profileGallery'.tr,
  //               style: const TextStyle(fontSize: 20),
  //             )),
  //         TextButton(
  //             onPressed: () async {
  //               isUpload = await imageUpload(userId);
  //               profileFile =
  //                   (await convertImageToList(_userController.userId)).obs;
  //               versionNo.value += 1;
  //               if (isUpload) {
  //                 Get.back();
  //               }
  //             },
  //             child: Text(
  //               'profileCamera'.tr,
  //               style: const TextStyle(fontSize: 20),
  //             )),
  //       ],
  //     ),
  //   );
  //   if (EasyLoading.isShow) {
  //     EasyLoading.dismiss();
  //   }
  // }
  // Future<bool> imageUpload(String? userId, {bool isPickImage = false}) async {
  //   XFile? img;
  //   if (isPickImage) {
  //     img = await _pickImage();
  //   } else {
  //     img = await _takeImage();
  //   }
  //   Uint8List? data = await img?.readAsBytes();
  //   try {
  //     if (data != null && userId != null) {
  //       EasyLoading.show(status: 'uploading'.tr);
  //       await Database().uploadProfileImage(data, userId);
  //       return true;
  //     }
  //   } catch (e) {
  //     Get.snackbar('errorMsg'.tr, e.toString());
  //     return false;
  //   }
  //   return false;
  // }

  // not working for web
  // Future<File?> convertImageToFile(String? imagePath) async {
  //   if (imagePath == null) {
  //     return null;
  //   }
  //   var baseUrl =
  //       'https://firebasestorage.googleapis.com/v0/b/hairfly-69e89.appspot.com/o/profile%2f';
  //   var param = '?alt=media&token=3163b29b-9579-4510-953c-0cbc87f5dce1';
  //   var url = '$baseUrl$imagePath.jpg$param';
  //   final dio.Response res = await dio.Dio().get<List<int>>(
  //     url,
  //     options: dio.Options(
  //       responseType: dio.ResponseType.bytes,
  //     ),
  //   );
  //   final Directory appDir = await getApplicationDocumentsDirectory();
  //   final File file = File(appDir.path + 'profile' + versionNo.toString());
  //   file.writeAsBytesSync(res.data as List<int>);

  //   return file;
  // }

  Future<Uint8List> convertImageToList(String? imagePath) async {
    if (imagePath == null) {
      return (await rootBundle.load('assets/images/profile.jpeg'))
          .buffer
          .asUint8List();
    }
    var baseUrl =
        'https://firebasestorage.googleapis.com/v0/b/hairfly-69e89.appspot.com/o/profile%2f';
    var param = '?alt=media&token=3163b29b-9579-4510-953c-0cbc87f5dce1';
    var url = '$baseUrl$imagePath.jpg$param';
    final dio.Response res = await dio.Dio().get<List<int>>(
      url,
      options: dio.Options(
        responseType: dio.ResponseType.bytes,
      ),
    );
    return Uint8List.fromList(res.data);
  }
}
