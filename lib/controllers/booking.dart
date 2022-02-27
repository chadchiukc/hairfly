import 'package:get/get.dart';
import 'package:intl/date_symbol_data_http_request.dart';
import 'package:intl/intl.dart';

class BookingCtrl extends GetxController {
  Rx<DateTime> focusedDay = DateTime.now().obs;
  DateTime firstDay = DateTime.now();
  Rx<DateTime> selectedDay = DateTime.now().obs;
  DateTime? confirmedDay;
  DateTime lastDay = DateTime.now().add(const Duration(days: 90));
  // Rx<String?> selectedValue = null.obs;
  var selectedValue = ''.obs;
  var noOfDayUpdated = 0.obs;

  void confirmDate() async {
    confirmedDay = selectedDay.value;
    // await initializeDateFormatting('zh_HK', null);
    print(DateFormat('EEEE, d MM, yyyy', 'zh_HK').format(confirmedDay!));
    noOfDayUpdated += 1;
  }
}
