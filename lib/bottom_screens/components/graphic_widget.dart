import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class GraphicWidget extends StatefulWidget {
  const GraphicWidget({
    super.key,
    required this.dates,
    required this.periodType,
    required this.incomeType,
  });
  final List<DateTime> dates;
  final String periodType;
  final String incomeType;

  @override
  State<GraphicWidget> createState() => _GraphicWidgetState();
}

class _GraphicWidgetState extends State<GraphicWidget> {
  List<DateTime> dates = [];
  String selectedDate = '';

  int biggestSumm = 0;
  DateTime biggestDateTime = DateTime.now();
  String biggestDateTimeYear = '';
  List<MoneySaveHiveModel> moneyList = [];

  getDates() {
    switch (widget.periodType) {
      case 'WEEK':
        dates = List.from(widget.dates);
        break;

      case 'MONTH':
        dates = [
          widget.dates.first,
          widget.dates[7],
          widget.dates[12],
          widget.dates[23],
          widget.dates.last,
        ];
        break;

      case 'YEAR':
        dates = List.from(widget.dates);
        break;
    }

    selectedDate = formatDate(dates.first);
    moneyList = List.from(MoneySaveRepo.getMoney());
    biggestSumm = 0;

    if (widget.periodType != 'YEAR') {
      List<MoneySaveHiveModel> filteredData = moneyList
          .where((entry) => dates.any((date) =>
              isSameDay(entry.date, date) &&
              '${entry.incomeType}s' == widget.incomeType))
          .toList();

      if (filteredData.isNotEmpty) {
        for (var e in filteredData) {
          final inOneDate =
              filteredData.where((el) => isSameDay(el.date, e.date)).toList();
          if (inOneDate.length > biggestSumm) {
            biggestSumm = inOneDate.length;
          }
        }
      } else {
        biggestSumm = 0;
      }
    } else {
      List<DateTime> allDates = [];

      for (DateTime firstDate in dates) {
        DateTime currentDate = firstDate;
        while (currentDate.month == firstDate.month) {
          allDates.add(currentDate);
          currentDate = currentDate.add(const Duration(days: 1));
        }
      }

      List<MoneySaveHiveModel> filteredData = moneyList
          .where((entry) => allDates.any((date) =>
              isSameDay(entry.date, date) &&
              '${entry.incomeType}s' == widget.incomeType))
          .toList();

      if (filteredData.isNotEmpty) {
        for (var e in filteredData) {
          final inOneDate = filteredData
              .where((el) => formatDate(el.date) == formatDate(e.date))
              .toList();
          if (inOneDate.length > biggestSumm) {
            biggestSumm = inOneDate.length;
          }
        }
      } else {
        biggestSumm = 0;
      }
    }
  }

  String formatDate(DateTime date) {
    switch (widget.periodType) {
      case 'WEEK':
        return weekFormat.format(date);

      case 'MONTH':
        return monthFormat.format(date);

      case 'YEAR':
        return yearMonthFormat.format(date);

      default:
        return '';
    }
  }

  @override
  void didUpdateWidget(covariant GraphicWidget oldWidget) {
    getDates();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    getDates();
    super.initState();
  }

  int container100 = 220;

  final weekFormat = DateFormat.E();
  final monthFormat = DateFormat('MMM d');
  final yearMonthFormat = DateFormat('MMM');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
      height: 400.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff303036),
      ),
      child: widget.periodType == 'YEAR'
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: dates.map<Widget>(
                  (e) {
                    final isEqual = selectedDate == formatDate(e);

                    double containerHeight = 0;
                    int maxSumm = 0;
                    double persont = 0;
                    List<MoneySaveHiveModel> filteredData = moneyList
                        .where((entry) =>
                            formatDate(entry.date) == formatDate(e) &&
                            '${entry.incomeType}s' == widget.incomeType)
                        .toList();
                    if (filteredData.isNotEmpty) {
                      maxSumm = filteredData.length;
                      persont = maxSumm / biggestSumm;
                      containerHeight = container100 * persont;
                    }

                    return Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isEqual)
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xff171724),
                                ),
                                child: Text(
                                  'Avg ${(persont * 100).ceilToDouble()}%',
                                  style: TextStyle(
                                    fontSize: 10.h,
                                    fontFamily: fontFamily,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedDate = formatDate(e);
                                });
                              },
                              child: isEqual
                                  ? Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xff454459)
                                            .withOpacity(0.3),
                                      ),
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        width: 8,
                                        height: container100.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xff454459),
                                        ),
                                        child: Stack(
                                          children: [
                                            IntrinsicHeight(
                                              child: Container(
                                                width: 8,
                                                height: containerHeight,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      const Color(0xff1DB954),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.bottomCenter,
                                      width: 8,
                                      height: container100.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xff454459),
                                      ),
                                      child: IntrinsicHeight(
                                        child: Container(
                                          width: 8,
                                          height: containerHeight,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color(0xff1DB954),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 15),
                            Text(formatDate(e)),
                          ],
                        ),
                        const SizedBox(width: 12),
                      ],
                    );
                  },
                ).toList(),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: dates.map<Widget>(
                (e) {
                  final isEqual = selectedDate == formatDate(e);
                  double containerHeight = 0;
                  int maxSumm = 0;
                  double persont = 0;
                  List<MoneySaveHiveModel> filteredData = moneyList
                      .where((entry) =>
                          isSameDay(entry.date, e) &&
                          '${entry.incomeType}s' == widget.incomeType)
                      .toList();
                  if (filteredData.isNotEmpty) {
                    maxSumm = filteredData.length;
                    persont = maxSumm / biggestSumm;
                    containerHeight = container100 * persont;
                  }
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isEqual)
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0xff171724),
                            ),
                            child: Text(
                              'Avg ${(persont * 100).ceilToDouble()}%',
                              style: TextStyle(
                                fontSize: 10.h,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedDate = formatDate(e);
                            });
                          },
                          child: isEqual
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff454459)
                                        .withOpacity(0.3),
                                  ),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: 8,
                                    height: container100.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xff454459),
                                    ),
                                    child: Stack(
                                      children: [
                                        IntrinsicHeight(
                                          child: Container(
                                            width: 8,
                                            height: containerHeight,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: const Color(0xff1DB954),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.bottomCenter,
                                  width: 8,
                                  height: container100.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xff454459),
                                  ),
                                  child: IntrinsicHeight(
                                    child: Container(
                                      width: 8,
                                      height: containerHeight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xff1DB954),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 15),
                        Text(formatDate(e)),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
    );
  }
}
