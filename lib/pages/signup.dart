import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/controllers/carousel.dart';
import 'package:hairfly/utils/constant.dart';
import 'package:hairfly/utils/routes.dart';
import 'package:hairfly/widgets/appbar.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:hairfly/widgets/bottom_nav.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final AuthController _authController = Get.find();
  final CarouselCtrl _carouselCtrl = Get.find();
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
                        padding: getValueForScreenType(
                          context: context,
                          mobile: EdgeInsets.symmetric(
                              vertical: Get.height * 0.1,
                              horizontal: Get.width * 0.1),
                          tablet: EdgeInsets.symmetric(
                              vertical: Get.height * 0.1,
                              horizontal: Get.width * 0.3),
                          desktop: EdgeInsets.symmetric(
                              vertical: Get.height * 0.1,
                              horizontal: Get.width * 0.3),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'signUp'.tr,
                              style: kLoginHeader,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ToggleSwitch(
                                        minWidth: 100,
                                        minHeight: 40,
                                        initialLabelIndex:
                                            _carouselCtrl.gender.value,
                                        cornerRadius: 20.0,
                                        inactiveFgColor: Colors.white,
                                        inactiveBgColor:
                                            Colors.black.withOpacity(0.1),
                                        totalSwitches: 2,
                                        icons: const [Icons.male, Icons.female],
                                        labels: ['male'.tr, 'female'.tr],
                                        activeBgColors: const [
                                          [Colors.white, Colors.blue],
                                          [Colors.white, Colors.pink]
                                        ],
                                        onToggle: (index) {
                                          _carouselCtrl
                                              .changeGender(index ?? 0);
                                        }),
                                  ),
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
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'userName'.tr,
                                        prefixIcon: const Icon(Icons
                                            .supervised_user_circle_rounded)),
                                    controller: _name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'userNameEnter'.tr;
                                      }
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
                                      if (value!.length < 6) {
                                        return 'passwordReminder'.tr;
                                      }
                                    },
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 8,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                        hintText: 'phone'.tr,
                                        prefixIcon: const Icon(Icons.phone)),
                                    controller: _phone,
                                    validator: (value) {
                                      if (value!.length != 8) {
                                        return 'phoneReminder'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _authController.signUp(
                                              _name.text,
                                              int.parse(_phone.text),
                                              _email.text,
                                              _pass.text,
                                              _carouselCtrl.convertIndexToStr(
                                                  _carouselCtrl.gender.value));
                                        }
                                      },
                                      child: Text(
                                        'signUp'.tr,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.offAndToNamed(
                                          '${Routes.login}?return=' +
                                              returnUrl);
                                    },
                                    child: Text(
                                      'signInHere'.tr,
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                  childCount: 1),
            ),
          ],
        ),
        // bottomNavigationBar: BottomNav(),
      ),
    );
  }
}
