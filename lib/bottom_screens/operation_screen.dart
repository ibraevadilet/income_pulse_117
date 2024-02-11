// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/income_data_model.dart';
import 'package:income_pulse_117/helper_screens/about_screen.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class GroupedData {
  DateTime date;
  List<DateTime> groupedDates;

  GroupedData({required this.date, required this.groupedDates});

  @override
  String toString() => 'GroupedData(date: $date, groupedDates: $groupedDates)';
}

class OperationScreen extends StatefulWidget {
  const OperationScreen({super.key});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  List<MoneySaveHiveModel> maoneyList = [];
  List<GroupedData> groupedDataList = [];

  @override
  void didUpdateWidget(covariant OperationScreen oldWidget) {
    getDates();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    maoneyList = MoneySaveRepo.getMoney();
    getDates();
    super.initState();
  }

  getDates() {
    List<DateTime> allDates =
        List.from(maoneyList.map<DateTime>((e) => e.date).toList());

    Map<DateTime, List<DateTime>> groupedDataMap = {};

    for (DateTime date in allDates) {
      DateTime truncatedDate = DateTime(date.year, date.month, date.day);

      if (!groupedDataMap.containsKey(truncatedDate)) {
        groupedDataMap[truncatedDate] = [];
      }

      groupedDataMap[truncatedDate]!.add(date);
    }

    groupedDataList = groupedDataMap.entries
        .map((entry) => GroupedData(date: entry.key, groupedDates: entry.value))
        .toList();
    groupedDataList = groupedDataList.reversed.toList();
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
        title: const Text('The latest actions'),
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
      body: groupedDataList.isEmpty
          ? Center(
              child: Text(
                'No actions yet',
                style: TextStyle(
                  fontSize: 21.h,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 150),
              itemCount: groupedDataList.length,
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isSameDay(groupedDataList[index].date, DateTime.now())
                        ? 'Today'
                        : isSameDay(
                            groupedDataList[index].date,
                            DateTime.now().subtract(
                              const Duration(days: 1),
                            ),
                          )
                            ? 'Yesterday'
                            : DateFormat('dd MMM yyyy').format(
                                groupedDataList[index].date,
                              ),
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: const Color(0xff303036),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: groupedDataList[index].groupedDates.length,
                      itemBuilder: (context, newIndex) => ActionsWidget(
                        date: groupedDataList[index].groupedDates[newIndex],
                      ),
                      separatorBuilder: (context, index) => Container(
                        alignment: Alignment.center,
                        height: 25,
                        child: const Divider(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ActionsWidget extends StatefulWidget {
  const ActionsWidget({super.key, required this.date});
  final DateTime date;

  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {
  @override
  void didUpdateWidget(covariant ActionsWidget oldWidget) {
    getData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  List<MoneySaveHiveModel> moneyList = [];
  late MoneySaveHiveModel model;
  bool isIncome = false;
  String currancy = '';

  getData() {
    moneyList = List.from(MoneySaveRepo.getMoney());
    model = moneyList.singleWhere((e) => e.date.isAtSameMomentAs(widget.date));
    isIncome = model.incomeType == 'Income';
    currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          shape: const Border(),
          context: context,
          builder: (context) => SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 23.h),
                Text(
                  '${isIncome ? '+' : '-'}${model.summ}$currancy',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w700,
                    color: isIncome
                        ? const Color(0xff1DB954)
                        : const Color(0xffD43838),
                  ),
                ),
                SizedBox(height: 5.h),
                const Divider(),
                Text(
                  '${model.incomeType} , ${model.iconType}',
                  style: TextStyle(
                    fontSize: 12.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  DateFormat('dd MMMM yyyy').format(model.date),
                  style: TextStyle(
                    fontSize: 12.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  DateFormat.Hm().format(model.date),
                  style: TextStyle(
                    fontSize: 12.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff1DB954),
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 16.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
      child: Row(
        children: [
          Image.asset(
            isIncome
                ? incomesTypeList
                    .singleWhere((e) => e.name == model.iconType)
                    .icon
                : expensesTypeList
                    .singleWhere((e) => e.name == model.iconType)
                    .icon,
            height: 51.h,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.iconType,
                style: TextStyle(
                  fontSize: 16.h,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                isIncome ? 'Profit' : 'Losses',
                style: TextStyle(
                  fontSize: 16.h,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff717171),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '${isIncome ? '+' : '-'}${model.summ}$currancy',
            style: TextStyle(
              fontSize: 16.h,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w700,
              color:
                  isIncome ? const Color(0xff1DB954) : const Color(0xffD43838),
            ),
          ),
        ],
      ),
    );
  }
}
