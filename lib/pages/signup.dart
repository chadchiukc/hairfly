import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/pages/login.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getValueForScreenType(
                  context: context,
                  mobile: Get.width * 0.2,
                  tablet: Get.width * 0.3,
                  desktop: Get.width * 0.35,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: Get.height * 0.2),
                      const CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Text('- Welcome to hair fly -'),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(
                                    Icons.email_rounded,
                                  )),
                              controller: _email,
                              validator: (value) {
                                if (!GetUtils.isEmail(value!)) {
                                  return 'Please enter a valid email address';
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'User Name',
                                  prefixIcon: Icon(
                                      Icons.supervised_user_circle_rounded)),
                              controller: _name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a user name';
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.fingerprint_rounded)),
                              controller: _pass,
                              obscureText: true,
                              validator: (value) {
                                if (value!.length < 6) {
                                  return 'Please enter a password with at least 6 digits';
                                }
                              },
                            ),
                            TextFormField(
                              maxLength: 8,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  hintText: 'Phone No',
                                  prefixIcon: Icon(Icons.phone)),
                              controller: _phone,
                              validator: (value) {
                                if (value!.length != 8) {
                                  return 'Please enter a 8-digit phone number';
                                }
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
                                        _pass.text);
                                  }
                                },
                                child: const Text(
                                  'Sign Up',
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAndToNamed('/login');
                              },
                              child: const Text(
                                'Sign in here',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
