import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/prem_component.dart';
import 'package:income_pulse_117/bottom_screens/components/saved_statistic.dart';
import 'package:income_pulse_117/bottom_screens/components/show_select_calendar_dialog.dart';
import 'package:income_pulse_117/helper_screens/about_screen.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/main.dart';
import 'package:intl/intl.dart';

class BottomPremiumScreen extends StatefulWidget {
  const BottomPremiumScreen({super.key});

  @override
  State<BottomPremiumScreen> createState() => _BottomPremiumScreenState();
}

class _BottomPremiumScreenState extends State<BottomPremiumScreen> {
  bool isIBuy = false;
  int myTarget = 0;
  bool isTarget = false;
  String selectedDate = '15-22 January';
  String currancy = '\$';

  DateTime nowDate = DateTime.now().subtract(const Duration(days: 6));
  late final nowDates = getNext7Days(nowDate);
  late String calendarDates = formatDateRange(nowDates);
  String type = 'WEEK';
  late List<DateTime> dates = getNext7Days(nowDate);

  final targetController = TextEditingController();
  @override
  void initState() {
    isIBuy = prefs.getBool(AppSharedKeys.prem) ?? false;
    myTarget = prefs.getInt(AppSharedKeys.target) ?? 0;
    currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
    isTarget = myTarget == 0;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
        appBar: isIBuy
            ? isTarget
                ? null
                : AppBar(
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
                        final result = await showSelectCalendarDialog(
                            context, nowDate, type);
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
                          calendarDates =
                              DateFormat.yMMMM().format(result.date);

                          setState(() {});
                        } else if (result.type == 'YEAR') {
                          dates = List.from(
                              getAllMonthsFromSelectedDate(result.date));
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
                  )
            : AppBar(
                title: const Text(''),
                automaticallyImplyLeading: false,
                actions: [
                  InkWell(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MainBottomScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return child;
                        },
                      ),
                      (pred) => false,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: isIBuy
                ? isTarget
                    ? Column(
                        children: [
                          Text(
                            'How much money\nwould you like to back up?',
                            style: TextStyle(
                              fontSize: 16.h,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 13.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: TextFormField(
                              controller: targetController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(
                                fontSize: 16.h,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Text(
                                    currancy,
                                    style: TextStyle(
                                      fontSize: 16.h,
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                hintText: '500',
                                hintStyle: TextStyle(
                                  fontSize: 16.h,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          CupertinoButton(
                            color: Colors.transparent,
                            padding: EdgeInsets.zero,
                            onPressed: () async {
                              if (targetController.text.isNotEmpty) {
                                await prefs.setInt(
                                  AppSharedKeys.target,
                                  int.parse(targetController.text),
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const MainBottomScreen(index: 4),
                                  ),
                                  (pred) => false,
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff1DB954),
                              ),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16.h,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                        ],
                      )
                    : SavedStatistic(
                        dates: dates,
                        periodType: type,
                      )
                : const PremComponent(),
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
