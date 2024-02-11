import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/bottom_bar_for_other.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';

class SaveKeyBoardScreen extends StatefulWidget {
  const SaveKeyBoardScreen({
    super.key,
    required this.incomeType,
    required this.iconType,
    required this.date,
  });
  final String incomeType;
  final String iconType;
  final DateTime date;
  @override
  State<SaveKeyBoardScreen> createState() => _SaveKeyBoardScreenState();
}

class _SaveKeyBoardScreenState extends State<SaveKeyBoardScreen> {
  String nalElectronType = 'Cach';
  String summa = '0';
  String currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
  bool isPremiumHave = prefs.getBool(AppSharedKeys.prem) ?? false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color(0xff303036),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          if (isPremiumHave)
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    nalElectronType = 'Save';
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: nalElectronType == 'Save'
                                        ? const Color(0xff6F6F70)
                                        : Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/save_icon.png',
                                        height: 35,
                                        color: nalElectronType == 'Save'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Save',
                                        style: TextStyle(
                                          fontSize: 12.h,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.w900,
                                          color: nalElectronType == 'Save'
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  nalElectronType = 'Cach';
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: nalElectronType == 'Cach'
                                      ? const Color(0xff6F6F70)
                                      : Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/cach_image.png',
                                      height: 35,
                                      color: nalElectronType == 'Cach'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Cash',
                                      style: TextStyle(
                                        fontSize: 12.h,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w900,
                                        color: nalElectronType == 'Cach'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  nalElectronType = 'Visa Card';
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: nalElectronType == 'Visa Card'
                                      ? const Color(0xff6F6F70)
                                      : Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/card_image.png',
                                      height: 35,
                                      color: nalElectronType == 'Visa Card'
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Visa Card',
                                      style: TextStyle(
                                        fontSize: 12.h,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w900,
                                        color: nalElectronType == 'Visa Card'
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                      height: 1,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      '$summa $currancy',
                      style: TextStyle(
                        fontSize: 46.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                      height: 1,
                    ),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          NumberWidget(
                            number: 1,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          NumberWidget(
                            number: 2,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          NumberWidget(
                            number: 3,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          NumberWidget(
                            number: 4,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          NumberWidget(
                            number: 5,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          NumberWidget(
                            number: 6,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          NumberWidget(
                            number: 7,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          NumberWidget(
                            number: 8,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          NumberWidget(
                            number: 9,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          ClearWidget(
                            onTap: () {
                              summa = '0';
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          NumberWidget(
                            number: 0,
                            onTap: (number) {
                              if (summa == '0') {
                                summa = number;
                              } else {
                                summa += number;
                              }
                              setState(() {});
                            },
                          ),
                          SizedBox(width: 8.w),
                          SaveWidget(
                            onTap: () async {
                              if (summa != '0') {
                                final moneyModel = MoneySaveHiveModel(
                                  date: widget.date,
                                  summ: int.parse(summa),
                                  incomeType: widget.incomeType,
                                  iconType: widget.iconType,
                                  cachType: nalElectronType,
                                );
                                await MoneySaveRepo.setMoney(moneyModel);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const MainBottomScreen(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: const BottomBarForOther(),
    );
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({super.key, required this.number, required this.onTap});
  final int number;
  final Function(String number) onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(number.toString()),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xff6F6F70),
          ),
          child: Text(
            number.toString(),
            style: TextStyle(
              fontSize: 22.h,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ClearWidget extends StatelessWidget {
  const ClearWidget({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xff6F6F70),
          ),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 35.h,
          ),
        ),
      ),
    );
  }
}

class SaveWidget extends StatelessWidget {
  const SaveWidget({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xff6F6F70),
          ),
          child: Icon(
            Icons.check,
            size: 35.h,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
