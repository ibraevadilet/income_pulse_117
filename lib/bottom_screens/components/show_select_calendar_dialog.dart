// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/bottom_screens/components/custom_alert_widget.dart';
import 'package:income_pulse_117/bottom_screens/components/show_week_calendar.dart';
import 'package:income_pulse_117/main.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

Future<DateTypeModel> showSelectCalendarDialog(
  BuildContext context,
  DateTime selecedDateFrom,
  String typeFrom,
) async {
  DateTime selecedDate = selecedDateFrom;
  String type = typeFrom;
  await showDialog(
    context: context,
    builder: (context) => CustomAlert(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24.h),
          Text(
            'Select chart period',
            style: TextStyle(
              fontSize: 16.h,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 25.h),
          InkWell(
            onTap: () async {
              final result = await showWeekCalendar(context, selecedDate);
              if (selecedDate.isAtSameMomentAs(result)) {
                Navigator.pop(context);
                return;
              } else {
                selecedDate = result;
                type = 'WEEK';
                Navigator.pop(context);
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Week',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          InkWell(
            onTap: () async {
              DateTime? monthFromPicker = await showMonthPicker(
                customDivider: Center(
                  child: Text(
                    'Select of the month',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                context: context,
                firstDate: DateTime(DateTime.now().year - 30),
                lastDate: DateTime(DateTime.now().year, DateTime.now().month),
                initialDate: DateTime.now(),
                locale: const Locale('en_EN'),
              );
              if (monthFromPicker != null) {
                selecedDate = monthFromPicker;
                type = 'MONTH';
              }
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Month',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),
          InkWell(
            onTap: () async {
              DateTime? monthFromPicker = await showMonthPicker(
                customDivider: Center(
                  child: Text(
                    'Select the month\nFor Beginning of year',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                context: context,
                firstDate: DateTime(DateTime.now().year - 30),
                lastDate: DateTime(DateTime.now().year, DateTime.now().month),
                initialDate: DateTime.now(),
                locale: const Locale('en_EN'),
              );
              if (monthFromPicker != null) {
                selecedDate = monthFromPicker;
                type = 'YEAR';
              }
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Year',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
    ),
  );
  return DateTypeModel(
    date: selecedDate,
    type: type,
  );
}

class DateTypeModel {
  final DateTime date;
  final String type;
  DateTypeModel({
    required this.date,
    required this.type,
  });
}
