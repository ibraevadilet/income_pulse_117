import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';

class MyMoneyWidget extends StatefulWidget {
  const MyMoneyWidget({super.key});

  @override
  State<MyMoneyWidget> createState() => _MyMoneyWidgetState();
}

class _MyMoneyWidgetState extends State<MyMoneyWidget> {
  String currancy = '';
  int cach = 0;
  int card = 0;
  @override
  void initState() {
    currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
    final moneyList = MoneySaveRepo.getMoney();
    for (var e in moneyList) {
      if (e.cachType == 'Cach') {
        if (e.incomeType == 'Income') {
          cach += e.summ;
        } else {
          cach -= e.summ;
        }
      } else if (e.cachType == 'Visa Card') {
        if (e.incomeType == 'Income') {
          card += e.summ;
        } else {
          card -= e.summ;
        }
      }
    }

    super.initState();
  }

  String formatNumberWithCommas(int number) {
    String result = number.toString();
    String formattedNumber = '';

    while (result.length > 3) {
      formattedNumber =
          ' ${result.substring(result.length - 3)}$formattedNumber';
      result = result.substring(0, result.length - 3);
    }

    formattedNumber = result + formattedNumber;

    return formattedNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, bottom: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xff303036),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/cach_image.png',
                  width: 40.w,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Cach',
                  style: TextStyle(
                    fontSize: 14.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffA4A4A4),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$currancy ',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffE0E0E0),
                      ),
                    ),
                    Text(
                      formatNumberWithCommas(cach),
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(width: 27.w),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 10, bottom: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xff303036),
            ),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/card_image.png',
                  width: 40.w,
                ),
                SizedBox(height: 12.h),
                Text(
                  'Card',
                  style: TextStyle(
                    fontSize: 14.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xffA4A4A4),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$currancy ',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffE0E0E0),
                      ),
                    ),
                    Text(
                      formatNumberWithCommas(card),
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
