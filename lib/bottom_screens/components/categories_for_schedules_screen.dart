import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:income_pulse_117/bottom_screens/components/bottom_bar_for_other.dart';
import 'package:income_pulse_117/bottom_screens/components/choose_a_date_for_schedules_screen.dart';
import 'package:income_pulse_117/bottom_screens/components/income_data_model.dart';
import 'package:income_pulse_117/main.dart';

class CategoriesForSchedulesScreen extends StatelessWidget {
  const CategoriesForSchedulesScreen({super.key, required this.incomeType});
  final String incomeType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const BottomBarForOther(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xff303036),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15.h),
                    Text(
                      'Categories for Schedule ',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 41.h),
                    MasonryGridView.count(
                      mainAxisSpacing: 26,
                      crossAxisSpacing: 20,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: incomeType == 'Income'
                          ? incomesTypeList.length
                          : expensesTypeList.length,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        final InvestType investType = incomeType == 'Income'
                            ? incomesTypeList[index]
                            : expensesTypeList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    ChooseADateForSchedulesScreen(
                                  addType: incomeType,
                                  iconType: investType.name,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                investType.icon,
                                height: 36.h,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                investType.name,
                                style: TextStyle(
                                  fontSize: 10.h,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
