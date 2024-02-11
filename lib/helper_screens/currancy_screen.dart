import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/main.dart';

class CurrancyScreen extends StatefulWidget {
  const CurrancyScreen({super.key});

  @override
  State<CurrancyScreen> createState() => _CurrancyScreenState();
}

class _CurrancyScreenState extends State<CurrancyScreen> {
  String savedCurrancy = '\$';

  @override
  void initState() {
    savedCurrancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setttings'),
        titleTextStyle: TextStyle(
          fontSize: 16.h,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Main currency :',
              style: TextStyle(
                fontSize: 16.h,
                fontFamily: fontFamily,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        savedCurrancy = '\$';
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 24.h,
                          width: 24.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff272727),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Container(
                            height: 6.h,
                            width: 6.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: savedCurrancy == '\$'
                                  ? Colors.white
                                  : const Color(0xff272727),
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'US Dollar',
                          style: TextStyle(
                            fontSize: 16.h,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  InkWell(
                    onTap: () {
                      setState(() {
                        savedCurrancy = '€';
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 24.h,
                          width: 24.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff272727),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Container(
                            height: 6.h,
                            width: 6.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: savedCurrancy == '€'
                                  ? Colors.white
                                  : const Color(0xff272727),
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'EURO',
                          style: TextStyle(
                            fontSize: 16.h,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  InkWell(
                    onTap: () {
                      setState(() {
                        savedCurrancy = '₽';
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          height: 24.h,
                          width: 24.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xff272727),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Container(
                            height: 6.h,
                            width: 6.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: savedCurrancy == '₽'
                                  ? Colors.white
                                  : const Color(0xff272727),
                              border: Border.all(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Russian ruble',
                          style: TextStyle(
                            fontSize: 16.h,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 36.h),
            CupertinoButton(
              color: Colors.transparent,
              padding: EdgeInsets.zero,
              onPressed: () async {
                prefs.setString(AppSharedKeys.currancy, savedCurrancy);
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const MainBottomScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color(0xff1DB954),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
