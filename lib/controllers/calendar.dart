import 'package:get/get.dart';

class CalendarCtrl extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  DateTime firstDay = DateTime.now();
  Rx<DateTime> selectedDay = DateTime.now().obs;
  DateTime lastDay = DateTime.now().add(const Duration(days: 90));
  // Rx<String?> selectedValue = null.obs;
  var selectedValue = ''.obs;
}
