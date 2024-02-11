import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/show_add_in_calendar_dialog.dart';
import 'package:income_pulse_117/helper_screens/about_screen.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selecedDate = DateTime.now();
  List<MoneySaveHiveModel> moneyList = [];
  String currancy = '';

  getData() {
    moneyList = MoneySaveRepo.getMoney()
        .where((e) => isSameDay(e.date, selecedDate))
        .toList();
    currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
  }

  @override
  void didUpdateWidget(covariant CalendarScreen oldWidget) {
    getData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Stack(
                children: [
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
                      headerPadding: const EdgeInsets.only(top: 20, bottom: 30),
                      rightChevronPadding: EdgeInsets.only(right: 30.w),
                      leftChevronPadding: EdgeInsets.only(left: 30.w),
                    ),
                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible: false,
                      withinRangeTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      defaultTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      weekendTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xff589C5F),
                        shape: BoxShape.circle,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      todayDecoration: BoxDecoration(
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
                    selectedDayPredicate: (day) => isSameDay(selecedDate, day),
                    calendarFormat: CalendarFormat.month,
                    rangeSelectionMode: RangeSelectionMode.toggledOff,
                    onDaySelected: (selectedDayFrom, focusedDay) {
                      selecedDate = selectedDayFrom;
                      getData();
                      setState(() {});
                    },
                    onPageChanged: (focusedDay) {
                      focusedDay = focusedDay;
                    },
                  ),
                  Positioned(
                    right: 0.w,
                    top: 30.h,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const AboutScreen(),
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/settings_icon.png',
                        height: 24.h,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.separated(
                  itemCount: moneyList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 24.h),
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${DateFormat.Hm().format(moneyList[index].date)} - ${moneyList[index].incomeType}',
                        style: TextStyle(
                          fontSize: 13.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffCCCCCC),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${moneyList[index].incomeType == 'Income' ? '+' : '-'}${moneyList[index].summ}$currancy',
                        style: TextStyle(
                          fontSize: 18.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: moneyList[index].incomeType == 'Income'
                              ? const Color(0xff00F20A)
                              : const Color(0xffFF0000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () async {
                  await showAddInCalendarDialog(context, selecedDate);
                  getData();
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff1DB954),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
