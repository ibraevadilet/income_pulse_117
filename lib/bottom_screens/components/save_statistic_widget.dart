import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/main.dart';
import 'package:pie_chart/pie_chart.dart';

class SaveStatisticWidget extends StatelessWidget {
  const SaveStatisticWidget({
    super.key,
    required this.percent,
    required this.dataMap,
  });
  final double percent;
  final Map<String, double> dataMap;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 40,
      chartRadius: MediaQuery.of(context).size.width / 2.8,
      colorList: percent == 0
          ? [Colors.grey]
          : dataMap.entries
              .toList()
              .map<Color>(
                (e) => Color.fromRGBO(
                  Random().nextInt(256),
                  Random().nextInt(256),
                  Random().nextInt(256),
                  1.0,
                ),
              )
              .toList(),
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 36,
      centerWidget: Text(
        "$percent%",
        style: TextStyle(
          fontSize: 28.h,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
