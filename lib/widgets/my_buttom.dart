import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget confirmButton(Function() callback, {String? text}) {
  return ElevatedButton(
    onPressed: callback,
    child: Text(
      text ?? 'confirm'.tr,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(const Size(100, 40)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ))),
  );
}

Widget cancelButtom(Function() callback, {String? text}) {
  return TextButton(
    onPressed: callback,
    child: Text(
      text ?? 'cancel'.tr,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(const Size(100, 40)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.pink, width: 2),
        ),
      ),
    ),
  );
  // return ButtonStyleButton()
}
