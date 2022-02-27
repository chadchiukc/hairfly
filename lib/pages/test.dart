import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hairfly/controllers/auth.dart';
import 'package:hairfly/controllers/booking.dart';
import 'package:hairfly/models/user.dart';
import 'package:hairfly/utils/database.dart';
import 'package:table_calendar/table_calendar.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);
  final AuthController _authController = Get.find();
  final BookingCtrl _bookingCtrl = Get.put(BookingCtrl());

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
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => Get.defaultDialog(
                      title: '',
                      content: SizedBox(
                        width: 500,
                        height: 400,
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
                            focusedDay: _bookingCtrl.focusedDay.value,
                            firstDay: _bookingCtrl.firstDay,
                            lastDay: _bookingCtrl.lastDay,
                            calendarFormat: CalendarFormat.month,
                            // holidayPredicate: (day) =>
                            //     day.weekday == DateTime.saturday ||
                            //     day.weekday == DateTime.sunday,
                            selectedDayPredicate: (day) {
                              return isSameDay(
                                  _bookingCtrl.selectedDay.value, day);
                            },
                            onDaySelected: (selectedDay, focusedDay) {
                              print(selectedDay);
                              print(focusedDay);
                              _bookingCtrl.selectedDay.value = selectedDay;
                              _bookingCtrl.focusedDay.value = focusedDay;
                            },
                          ),
                        ),
                      ),
                    ),
                child: Text('Calendar')),
            Obx(() => DropdownButton(
                value: _bookingCtrl.selectedValue.value == ''
                    ? null
                    : _bookingCtrl.selectedValue.value,
                hint: const Text('Select services'),
                onChanged: (value) =>
                    _bookingCtrl.selectedValue.value = value.toString(),
                items: items
                    .map((item) =>
                        DropdownMenuItem(value: item, child: Text(item)))
                    .toList())),
          ],
        ),
      ),
    );
  }
}
