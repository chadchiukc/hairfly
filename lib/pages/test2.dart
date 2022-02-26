import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/crop.dart';
import 'package:hairfly/controllers/profile_image.dart';

class Test2Page extends StatelessWidget {
  Test2Page({Key? key}) : super(key: key);
  final ProfileImageCtrl _profileImageCtrl = Get.put(ProfileImageCtrl());
  final CropCtrl _cropCtrl = Get.put(CropCtrl());
  CropController _cropController = CropController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Flexible(
          child: Column(
            children: [
              Obx(() {
                // _cropController.withCircleUi = true;
                return _profileImageCtrl.isFileReady &&
                        _profileImageCtrl.profileFile.value != null
                    ? SizedBox(
                        height: 300,
                        child: Crop(
                            // controller: _cropController,
                            controller: _cropCtrl.cropController,
                            withCircleUi: true,
                            image: _profileImageCtrl.profileFile.value!,
                            onCropped: (data) => print(data.length)),
                      )
                    : Center(child: Text('123'));
              }),
              Flexible(
                  child: ElevatedButton(
                      onPressed: _cropCtrl.cropController.cropCircle,
                      child: Text('1233')))
            ],
          ),
        ),
      ),
    );
  }
}
