import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/pages/signup.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/routes.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _forgot = TextEditingController();
  final AuthController _authController = Get.find();
  String returnUrl = Get.parameters['return'] ?? '/';

  @override
  Widget build(BuildContext context) {
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
            SliverPersistentHeader(
              pinned: false,
              delegate: MySliverAppBar(
                  expandedHeight: 150.0, logoRadius: 80, backwardable: true),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  ((context, index) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.1,
                          horizontal: Get.width * 0.1),
                      // getValueForScreenType(
                      //   context: context,
                      //   mobile: EdgeInsets.symmetric(
                      //       vertical: Get.height * 0.1,
                      //       horizontal: Get.width * 0.1),
                      //   tablet: EdgeInsets.symmetric(
                      //       vertical: Get.height * 0.1,
                      //       horizontal: Get.width * 0.3),
                      //   desktop: EdgeInsets.symmetric(
                      //       vertical: Get.height * 0.1,
                      //       horizontal: Get.width * 0.3),
                      // ),
                      child:
                          // !_authController.verified! &&
                          //         _authController.user != null
                          //     ? Column(
                          //         children: [
                          //           Text(
                          //             'emailVerification'.tr,
                          //             style: kLoginHeader,
                          //           ),
                          //           Padding(
                          //             padding: const EdgeInsets.symmetric(
                          //                 vertical: 16),
                          //             child: Text('emailSent'.tr,
                          //                 style: kLoginContent),
                          //           ),
                          //           ElevatedButton(
                          //               onPressed: () {
                          //                 _authController.sendEmailVerification(
                          //                     showDialog: true);
                          //               },
                          //               child: Text('resentVerification'.tr)),
                          //           ElevatedButton(
                          //               onPressed: _authController.signout,
                          //               child: Text('loginAnotherAccount'.tr)),
                          //         ],
                          //       )
                          //     :
                          Column(
                        children: [
                          Text(
                            'login'.tr,
                            style: kLoginHeader,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      hintText: 'email'.tr,
                                      prefixIcon: const Icon(
                                        Icons.email_rounded,
                                      )),
                                  controller: _email,
                                  validator: (value) {
                                    if (!GetUtils.isEmail(value!)) {
                                      return 'emailReminder'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: 'password'.tr,
                                      prefixIcon: const Icon(
                                          Icons.fingerprint_rounded)),
                                  controller: _pass,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value!.length < 8) {
                                      return 'passwordReminder'.tr;
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                            contentPadding:
                                                const EdgeInsets.all(20),
                                            title: 'emailInput'.tr,
                                            titleStyle: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                            content: TextField(
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                  prefixIcon:
                                                      const Icon(Icons.email),
                                                  hintText: 'emailHint'.tr),
                                              controller: _forgot,
                                            ),
                                            confirm: TextButton(
                                              onPressed: () {
                                                _authController.forgotPassword(
                                                    _forgot.text);
                                                Get.back();
                                              },
                                              child: Text('confirm'.tr),
                                            ),
                                            cancel: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: Text('cancel'.tr),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'forgotPw'.tr,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (await _authController.login(
                                            _email.text, _pass.text)) {
                                          Get.offAndToNamed(returnUrl);
                                        }
                                      }
                                    },
                                    child: Text(
                                      'login'.tr,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.offAndToNamed(
                                        '${Routes.signup}?return=' + returnUrl);
                                  },
                                  child: Text(
                                    'createAccount'.tr,
                                    style: const TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),
                  childCount: 1),
            ),
          ],
        ),
        // bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
