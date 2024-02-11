import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:income_pulse_117/bottom_screens/components/categories_for_schedules_screen.dart';
import 'package:income_pulse_117/bottom_screens/components/income_data_model.dart';
import 'package:income_pulse_117/bottom_screens/components/save_key_board_screen.dart';
import 'package:income_pulse_117/main.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  String addType = 'Income';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'Add on operation',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              addType = 'Income';
                            });
                          },
                          child: Text(
                            'Income',
                            style: TextStyle(
                              fontSize: 16.h,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w900,
                              color: addType == 'Income'
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              decoration: addType == 'Income'
                                  ? TextDecoration.underline
                                  : null,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              addType = 'Expense';
                            });
                          },
                          child: Text(
                            'Expense',
                            style: TextStyle(
                              fontSize: 16.h,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w900,
                              color: addType == 'Expense'
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              decoration: addType == 'Expense'
                                  ? TextDecoration.underline
                                  : null,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              addType = 'Scheduled';
                            });
                          },
                          child: Text(
                            'Scheduled',
                            style: TextStyle(
                              fontSize: 16.h,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w900,
                              color: addType == 'Scheduled'
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                              decoration: addType == 'Scheduled'
                                  ? TextDecoration.underline
                                  : null,
                              decorationThickness: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 19.h),
                    addType == 'Scheduled'
                        ? Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const CategoriesForSchedulesScreen(
                                        incomeType: 'Income',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Income',
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
                              const SizedBox(height: 24),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          const CategoriesForSchedulesScreen(
                                        incomeType: 'Expense',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Expense',
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
                            ],
                          )
                        : MasonryGridView.count(
                            mainAxisSpacing: 26,
                            crossAxisSpacing: 20,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: addType == 'Income'
                                ? incomesTypeList.length
                                : expensesTypeList.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              final InvestType investType = addType == 'Income'
                                  ? incomesTypeList[index]
                                  : expensesTypeList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => SaveKeyBoardScreen(
                                        incomeType: addType,
                                        iconType: investType.name,
                                        date: DateTime.now(),
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
