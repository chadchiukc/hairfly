import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/controllers/calendar.dart';
import 'package:hairfly/models/user.dart';
import 'package:hairfly/utils/database.dart';
import 'package:table_calendar/table_calendar.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);
  final AuthController _authController = Get.find();
  final CalendarCtrl _calendarCtrl = Get.put(CalendarCtrl());
  GetStorage box = GetStorage();

  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () => Get.defaultDialog(
                    title: '',
                    content: SizedBox(
                      width: Get.width * 0.6,
                      height: Get.height * 0.6,
                      child: Obx(
                        () => TableCalendar(
                          calendarStyle: const CalendarStyle(
                            outsideDaysVisible: false,
                            isTodayHighlighted: false,
                            weekendTextStyle: TextStyle(color: Colors.red),
                          ),
                          headerStyle:
                              const HeaderStyle(formatButtonVisible: false),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          focusedDay: _calendarCtrl.focusedDay.value,
                          firstDay: _calendarCtrl.firstDay,
                          lastDay: _calendarCtrl.lastDay,
                          calendarFormat: CalendarFormat.month,
                          // holidayPredicate: (day) =>
                          //     day.weekday == DateTime.saturday ||
                          //     day.weekday == DateTime.sunday,
                          selectedDayPredicate: (day) {
                            return isSameDay(
                                _calendarCtrl.selectedDay.value, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            _calendarCtrl.selectedDay.value = selectedDay;
                            _calendarCtrl.focusedDay.value = focusedDay;
                          },
                        ),
                      ),
                    ),
                  ),
              child: Text('Calendar')),
          Obx(() => DropdownButton(
              value: _calendarCtrl.selectedValue.value == ''
                  ? null
                  : _calendarCtrl.selectedValue.value,
              hint: const Text('Select services'),
              onChanged: (value) =>
                  _calendarCtrl.selectedValue.value = value.toString(),
              items: items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList())),
          ElevatedButton(
              onPressed: () => Database().getFromFirestore('shops'),
              child: Text('GetShops')),
        ],
      ),
    );
  }
}
