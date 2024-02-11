import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/income_data_model.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';

class IconsWidget extends StatefulWidget {
  const IconsWidget({super.key, required this.moneyType});
  final String moneyType;
  @override
  State<IconsWidget> createState() => _IconsWidgetState();
}

class _IconsWidgetState extends State<IconsWidget> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 20,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.moneyType == 'Incomes'
          ? incomesTypeList.length
          : expensesTypeList.length,
      crossAxisCount: 2,
      itemBuilder: (context, index) => IconItemWidget(
        model: widget.moneyType == 'Incomes'
            ? incomesTypeList[index]
            : expensesTypeList[index],
        moneyType: widget.moneyType,
      ),
    );
  }
}

class IconItemWidget extends StatefulWidget {
  const IconItemWidget({
    super.key,
    required this.model,
    required this.moneyType,
  });

  final InvestType model;
  final String moneyType;

  @override
  State<IconItemWidget> createState() => _IconItemWidgetState();
}

class _IconItemWidgetState extends State<IconItemWidget> {
  int summ = 0;
  String currancy = '';

  @override
  void didUpdateWidget(covariant IconItemWidget oldWidget) {
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
        if ('${e.incomeType}s' == widget.moneyType) {
          summ += e.summ;
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
