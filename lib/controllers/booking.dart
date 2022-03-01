import 'package:get/get.dart';
import 'package:hairfly/models/service.dart';
import 'package:hairfly/widgets/my_buttom.dart';
import 'package:intl/intl.dart';

class BookingCtrl extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  DateTime firstDay = DateTime.now();
  Rx<DateTime> selectedDay = DateTime.now().obs;
  DateTime? confirmedDay;
  DateTime lastDay = DateTime.now().add(const Duration(days: 90));
  Rx<String> displayDate = '- - - - - - -'.obs;
  bool isDateSelected = false;

  DateTime? confirmedTime;
  bool isTimeSelected = false;
  Rx<DateTime> selectedTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0)
      .obs;
  Rx<String> displayTime = '- - - - - - -'.obs;
  DateTime minimumDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0);
  DateTime maximumDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 0);
  Rx<DateTime> initialDate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 0)
      .obs;
  var selectedService = [];
  RxInt displayValue = 0.obs;
  var selectedDateTime;

  void confirmDate() async {
    confirmedDay = selectedDay.value;
    displayDate.value = DateFormat('EEEE, d-MM-yyyy').format(confirmedDay!);
    isDateSelected = true;
  }

  void confirmTime() async {
    confirmedTime = selectedTime.value;
    displayTime.value = DateFormat.Hm().format(confirmedTime!);
    initialDate.value = selectedTime.value;
    isTimeSelected = true;
  }

  void changeMinMaxTimeRange(String openHour) {
    var openHr = 11;
    var openMin = 00;
    var endHr = 22;
    var endMin = 00;
    if (openHour.contains('-')) {
      openHr = int.parse(openHour.split('-')[0].substring(0, 2));
      openMin = int.parse(openHour.split('-')[0].substring(2));
      endHr = int.parse(openHour.split('-')[1].substring(0, 2));
      endMin = int.parse(openHour.split('-')[1].substring(2));

      // booking is available before 30min of shop closing
      if (endMin < 15) {
        endHr - 1;
        endMin = 30;
      } else if (endMin < 30) {
        endHr - 1;
        endMin = 45;
      } else if (endMin < 45) {
        endMin = 00;
      } else {
        endMin = 15;
      }
      minimumDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, openHr, openMin);
      maximumDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, endHr, endMin);
    }
  }

  List<String> servicesToLabel(List<ServiceModel> serviceList) {
    List<String> list = [];
    for (var element in serviceList) {
      list.add('${element.name.tr} \$${element.price.toString()}');
    }
    return list;
  }

  List<String> servicesToValue(List<ServiceModel> serviceList) {
    List<String> list = [];
    for (var element in serviceList) {
      list.add(element.name);
    }
    return list;
  }

  void selectService(List services, Map? servicePriceRef) {
    if (services.isEmpty) {
      displayValue.value = 0;
    } else if (servicePriceRef != null) {
      selectedService = services;
      List<int> priceList = [];
      for (var element in selectedService) {
        priceList.add(servicePriceRef[element]);
      }

      displayValue.value =
          priceList.reduce((value, element) => value + element);
    }
  }

  bool confirmBooking() {
    var now = DateTime.now();
    if (confirmedDay != null &&
        confirmedTime != null &&
        selectedService.isNotEmpty) {
      selectedDateTime = DateTime(confirmedDay!.year, confirmedDay!.month,
          confirmedDay!.day, confirmedTime!.hour, confirmedTime!.minute);
      if (now.isBefore(selectedDateTime)) {
        return true;
      } else {
        Get.defaultDialog(
            title: 'wrongMsg'.tr,
            middleText: 'wrongTime'.tr,
            confirm: confirmButton(() {
              Get.back();
            }));
      }
    } else {
      Get.defaultDialog(
          title: 'wrongMsg'.tr,
          middleText: 'selectReminder'.tr,
          confirm: confirmButton(() {
            Get.back();
          }));
    }
    return false;
  }
}
