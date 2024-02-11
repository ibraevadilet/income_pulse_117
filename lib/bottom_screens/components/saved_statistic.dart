import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/income_data_model.dart';
import 'package:income_pulse_117/bottom_screens/components/my_money_widget.dart';
import 'package:income_pulse_117/bottom_screens/components/save_statistic_widget.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';
import 'package:table_calendar/table_calendar.dart';

class SavedStatistic extends StatefulWidget {
  const SavedStatistic({
    super.key,
    required this.dates,
    required this.periodType,
  });
  final List<DateTime> dates;
  final String periodType;

  @override
  State<SavedStatistic> createState() => _SavedStatisticState();
}

class _SavedStatisticState extends State<SavedStatistic> {
  int myTarget = 0;
  int allSumm = 0;
  Map<String, double> dataMap = {};
  String currancy = '';
  List<DateTime> dates = [];

  @override
  void didUpdateWidget(covariant SavedStatistic oldWidget) {
    getData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    allSumm = 0;
    dates.clear();
    dataMap.clear();
    myTarget = prefs.getInt(AppSharedKeys.target) ?? 0;
    currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
    final moneyList = MoneySaveRepo.getMoney();

    if (widget.periodType != 'YEAR') {
      dates = List.from(widget.dates);
    } else {
      for (DateTime firstDate in widget.dates) {
        DateTime currentDate = firstDate;
        while (currentDate.month == firstDate.month) {
          dates.add(currentDate);
          currentDate = currentDate.add(const Duration(days: 1));
        }
      }
    }
    print(dates);
    List<MoneySaveHiveModel> filteredData = moneyList
        .where((entry) => dates.any((date) =>
            isSameDay(entry.date, date) && entry.incomeType == 'Income'))
        .toList();

    print(filteredData);
    for (var e in filteredData) {
      if (e.incomeType == 'Income') {
        if (e.cachType == 'Save') {
          allSumm += e.summ;
          dataMap.addEntries(
            [
              MapEntry(
                e.iconType,
                e.summ.toDouble(),
              ),
            ],
          );
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 50),
        children: [
          const MyMoneyWidget(),
          SizedBox(height: 30.h),
          SizedBox(
            height: 250,
            child: SaveStatisticWidget(
              percent: ((allSumm / myTarget) * 100).floorToDouble(),
              dataMap: allSumm == 0 ? {'Empty': 0} : dataMap,
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            'Saved',
            style: TextStyle(
              fontSize: 15.h,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            '$allSumm$currancy',
            style: TextStyle(
              fontSize: 28.h,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 18.h),
          MasonryGridView.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: incomesTypeList.length,
            crossAxisCount: 2,
            itemBuilder: (context, index) => SaveIconsItemWidget(
              model: incomesTypeList[index],
            ),
          )
        ],
      ),
    );
  }
}

class SaveIconsItemWidget extends StatefulWidget {
  const SaveIconsItemWidget({
    super.key,
    required this.model,
  });

  final InvestType model;

  @override
  State<SaveIconsItemWidget> createState() => _SaveIconsItemWidgetState();
}

class _SaveIconsItemWidgetState extends State<SaveIconsItemWidget> {
  int summ = 0;
  String currancy = '';

  @override
  void didUpdateWidget(covariant SaveIconsItemWidget oldWidget) {
    getData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    summ = 0;
    currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
    final moneyList = MoneySaveRepo.getMoney();
    for (var e in moneyList) {
      if (e.iconType == widget.model.name) {
        if (e.incomeType == 'Income') {
          if (e.cachType == 'Save') {
            summ += e.summ;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xff303036),
      ),
      child: Row(
        children: [
          Image.asset(
            widget.model.icon,
            height: 40.h,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    widget.model.name,
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  '$summ$currancy',
                  style: TextStyle(
                    fontSize: 12.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff1DB954),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
