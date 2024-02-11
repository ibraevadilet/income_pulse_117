import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/bottom_screens/components/bottom_bar_for_other.dart';
import 'package:income_pulse_117/bottom_screens/components/save_key_board_screen.dart';
import 'package:income_pulse_117/main.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ChooseADateForSchedulesScreen extends StatefulWidget {
  const ChooseADateForSchedulesScreen({
    super.key,
    required this.addType,
    required this.iconType,
  });
  final String addType;
  final String iconType;

  @override
  State<ChooseADateForSchedulesScreen> createState() =>
      _ChooseADateForSchedulesScreenState();
}

class _ChooseADateForSchedulesScreenState
    extends State<ChooseADateForSchedulesScreen> {
  DateTime selecedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const BottomBarForOther(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xff303036),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Text(
                      'Choose date',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 41.h),
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
                          color: Colors.white,
                        ),
                        titleCentered: true,
                        titleTextFormatter: (date, locale) =>
                            DateFormat.yMMMM('en').format(date),
                        formatButtonVisible: false,
                        headerPadding:
                            const EdgeInsets.only(top: 20, bottom: 30),
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
                      focusedDay: selecedDate,
                      selectedDayPredicate: (day) =>
                          isSameDay(selecedDate, day),
                      calendarFormat: CalendarFormat.month,
                      rangeSelectionMode: RangeSelectionMode.toggledOff,
                      onDaySelected: (selectedDayFrom, focusedDay) {
                        selecedDate = selectedDayFrom;
                        setState(() {});
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SaveKeyBoardScreen(
                              incomeType: widget.addType,
                              iconType: widget.iconType,
                              date: selecedDate,
                            ),
                          ),
                        );
                      },
                      onPageChanged: (focusedDay) {
                        focusedDay = focusedDay;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
