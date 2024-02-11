import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/bottom_screens/components/graphic_widget.dart';
import 'package:income_pulse_117/bottom_screens/components/income_icons.dart';
import 'package:income_pulse_117/bottom_screens/components/money_type_widget.dart';
import 'package:income_pulse_117/bottom_screens/components/my_money_widget.dart';
import 'package:income_pulse_117/bottom_screens/components/show_select_calendar_dialog.dart';
import 'package:income_pulse_117/helper_screens/about_screen.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';
import 'package:intl/intl.dart';

class MainBalanceScreen extends StatefulWidget {
  const MainBalanceScreen({super.key});

  @override
  State<MainBalanceScreen> createState() => _MainBalanceScreenState();
}

class _MainBalanceScreenState extends State<MainBalanceScreen> {
  DateTime nowDate = DateTime.now().subtract(const Duration(days: 6));
  late final nowDates = getNext7Days(nowDate);
  late String calendarDates = formatDateRange(nowDates);
  String type = 'WEEK';
  late List<DateTime> dates = getNext7Days(nowDate);


  String moneyType = 'Incomes';

  @override
  void initState() {
    final maoneyList = MoneySaveRepo.getMoney();
    // print(maoneyList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20.h,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        leading: Opacity(
          opacity: 0,
          child: IgnorePointer(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.asset(
                'assets/images/settings_icon.png',
                height: 24.h,
              ),
            ),
          ),
        ),
        title: InkWell(
          onTap: () async {
            final result =
                await showSelectCalendarDialog(context, nowDate, type);
            setState(() {
              nowDate = result.date;
              type = result.type;
            });
            if (result.type == 'WEEK') {
              dates = List.from(getNext7Days(result.date));
              calendarDates = formatDateRange(dates);
              setState(() {});
            } else if (result.type == 'MONTH') {
              dates = List.from(getAllDaysInMonth(result.date));
              calendarDates = DateFormat.yMMMM().format(result.date);

              setState(() {});
            } else if (result.type == 'YEAR') {
              dates = List.from(getAllMonthsFromSelectedDate(result.date));
              print(dates);
              calendarDates = DateFormat.y().format(result.date);
              setState(() {});
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(calendarDates),
              const SizedBox(width: 5),
              Icon(
                Icons.keyboard_arrow_down,
                color: const Color(0xffC5C5C5),
                size: 30.h,
              )
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const AboutScreen(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                'assets/images/settings_icon.png',
                height: 24.h,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 50),
            children: [
              const MyMoneyWidget(),
              SizedBox(height: 10.h),
              MoneyTypeWidget(
                onChange: (moneyTypeFrom) {
                  setState(() {
                    moneyType = moneyTypeFrom;
                  });
                },
              ),
              SizedBox(height: 14.h),
              GraphicWidget(
                dates: dates,
                periodType: type,
                incomeType: moneyType,
              ),
              SizedBox(height: 16.h),
              IconsWidget(moneyType: moneyType),
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> getNext7Days(DateTime startDate) {
    List<DateTime> next7Days = [];
    for (int i = 0; i < 7; i++) {
      DateTime nextDate = startDate.add(Duration(days: i));
      next7Days.add(nextDate);
    }
    return next7Days;
  }

  List<DateTime> getAllDaysInMonth(DateTime selectedDate) {
    DateTime firstDayOfMonth =
        DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime lastDayOfMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);

    List<DateTime> daysInMonth = [];
    for (DateTime date = firstDayOfMonth;
        date.isBefore(lastDayOfMonth.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      daysInMonth.add(date);
    }

    return daysInMonth;
  }

  List<DateTime> getAllMonthsFromSelectedDate(DateTime selectedDate) {
    List<DateTime> months = [];
    DateTime currentDate = selectedDate;

    while (currentDate.month <= 12) {
      // String monthName = DateFormat('MMMM').format(currentDate);
      months.add(currentDate);

      // Увеличиваем месяц на 1
      currentDate =
          DateTime(currentDate.year, currentDate.month + 1, currentDate.day);

      // Выходим из цикла, если достигнут конец года
      if (currentDate.month == 1) {
        break;
      }
    }
    print(months);
    return months;
  }

  String formatDateRange(List<DateTime> dates) {
    if (dates.isEmpty) return '';

    DateFormat dayFormat = DateFormat('d');
    DateFormat monthFormatFull = DateFormat('MMMM');
    DateFormat monthFormatShort = DateFormat.MMM();

    Set<String> uniqueMonths =
        dates.map((date) => monthFormatFull.format(date)).toSet();
    String startDay = dayFormat.format(dates.first);
    String startMonth = uniqueMonths.length == 1
        ? monthFormatFull.format(dates.first)
        : monthFormatShort.format(dates.first);

    String endDay = dayFormat.format(dates.last);
    String endMonth = uniqueMonths.length == 1
        ? monthFormatFull.format(dates.last)
        : monthFormatShort.format(dates.last);

    if (startMonth == endMonth) {
      return '$startDay-$endDay $startMonth';
    } else {
      return '$startDay $startMonth - $endDay $endMonth';
    }
  }
}
