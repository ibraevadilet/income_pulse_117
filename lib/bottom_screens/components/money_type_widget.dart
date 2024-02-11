import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/main.dart';

class MoneyTypeWidget extends StatefulWidget {
  const MoneyTypeWidget({super.key, required this.onChange});
  final Function(String moneyType) onChange;
  @override
  State<MoneyTypeWidget> createState() => _MoneyTypeWidgetState();
}

class _MoneyTypeWidgetState extends State<MoneyTypeWidget> {
  String selectedMoneyType = 'Incomes';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                selectedMoneyType = 'Incomes';
              });
              widget.onChange(selectedMoneyType);
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xff303036),
                border: selectedMoneyType == 'Incomes'
                    ? Border.all(
                        color: const Color(0xff1DB954),
                        width: 3,
                      )
                    : null,
              ),
              child: Text(
                'Incomes',
                style: TextStyle(
                  fontSize: 16.h,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: selectedMoneyType == 'Incomes'
                      ? const Color(0xff1DB954)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 27.w),
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                selectedMoneyType = 'Expenses';
              });
              widget.onChange(selectedMoneyType);
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xff303036),
                border: selectedMoneyType == 'Expenses'
                    ? Border.all(
                        color: const Color(0xff1DB954),
                        width: 3,
                      )
                    : null,
              ),
              child: Text(
                'Expenses',
                style: TextStyle(
                  fontSize: 16.h,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w700,
                  color: selectedMoneyType == 'Expenses'
                      ? const Color(0xff1DB954)
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
