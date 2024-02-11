import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/bottom_screens/components/custom_alert_widget.dart';
import 'package:income_pulse_117/main.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

Future<DateTime> showWeekCalendar(BuildContext context, DateTime selecedDateFrom) async {
  DateTime selecedDate = selecedDateFrom;
  await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return CustomAlert(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24.h),
              Text(
                'Select beginning ',
                style: TextStyle(
                  fontSize: 16.h,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 25.h),
              TableCalendar(
                onDayLongPressed: (day, day1) {},
                locale: 'en_EN',
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerStyle: HeaderStyle(
                  leftChevronIcon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                  titleTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.MMMM('en').format(date),
                  formatButtonVisible: false,
                  headerPadding: const EdgeInsets.only(top: 20, bottom: 30),
                  rightChevronPadding: const EdgeInsets.only(right: 30),
                  leftChevronPadding: const EdgeInsets.only(left: 30),
                ),
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  withinRangeTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                  selectedTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  defaultTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  weekendTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  todayDecoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  weekdayStyle: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: selecedDateFrom,
                selectedDayPredicate: (day) => isSameDay(selecedDate, day),
                calendarFormat: CalendarFormat.month,
                rangeSelectionMode: RangeSelectionMode.toggledOff,
                onDaySelected: (selectedDayFrom, focusedDay) {
                  selecedDate = selectedDayFrom;
                  setState(() {});
                  Navigator.pop(context);
                },
                onPageChanged: (focusedDay) {
                  focusedDay = focusedDay;
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    ),
  );
  return selecedDate;
}
