import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/pages/signup.dart';
import 'package:hairfly/widgets/background.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _forgot = TextEditingController();
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: () {
                                      Get.defaultDialog(
                                        contentPadding:
                                            const EdgeInsets.all(20),
                                        title: 'Please enter your email',
                                        titleStyle: const TextStyle(
                                            fontSize: 20, color: Colors.black),
                                        content: SizedBox(
                                          width: Get.width * 0.3,
                                          child: TextField(
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                                prefixIcon: Icon(Icons.email),
                                                hintText: 'Your Email'),
                                            controller: _forgot,
                                          ),
                                        ),
                                        confirm: TextButton(
                                          onPressed: () {
                                            _authController
                                                .forgotPassword(_forgot.text);
                                            Get.back();
                                          },
                                          child: const Text('Confirm'),
                                        ),
                                        cancel: TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _authController.login(
                                        _email.text, _pass.text);
                                  }
                                },
                                child: const Text(
                                  'Sign In',
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.offAndToNamed('/signup');
                              },
                              child: const Text(
                                'Create an account',
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
