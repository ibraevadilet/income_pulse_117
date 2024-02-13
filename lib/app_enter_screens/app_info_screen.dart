import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_enter_screens/pulse_web_screen.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/helper_screens/buy_screen.dart';
import 'package:income_pulse_117/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../helper_screens/main_bottom_screen.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  final controller = PageController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView(
                      onPageChanged: (value) {
                        pageIndex = value;
                      },
                      controller: controller,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 64.w),
                              child: Image.asset(
                                'assets/images/on_brd1.png',
                              ),
                            ),
                            SizedBox(height: 43.h),
                            Text(
                              'Your Finances\nRecord, Analyze, Plan!',
                              style: TextStyle(
                                fontSize: 22.h,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.normal,
                                color: Colors.white.withOpacity(0.6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 64.w),
                              child: Image.asset(
                                'assets/images/on_brd2.png',
                              ),
                            ),
                            SizedBox(height: 43.h),
                            Text(
                              ' Your Wallet - Record,\nVisualize, Plan Ahead!',
                              style: TextStyle(
                                fontSize: 22.h,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.normal,
                                color: Colors.white.withOpacity(0.6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 64.w),
                              child: Image.asset(
                                'assets/images/on_brd3.png',
                              ),
                            ),
                            SizedBox(height: 43.h),
                            Text(
                              'Elevate\nyour wealth',
                              style: TextStyle(
                                fontSize: 22.h,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.normal,
                                color: Colors.white.withOpacity(0.6),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 120.h,
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                          dotWidth: 16.0.w,
                          dotHeight: 16.w,
                          spacing: 32.w,
                          activeDotColor: const Color(0xff1DB954),
                          dotColor: const Color(0xffD9D9D9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 19),
              // SmoothPageIndicator(
              //   controller: controller,
              //   count: 3,
              //   effect: const WormEffect(
              //     spacing: 32,
              //     activeDotColor: Color(0xff1DB954),
              //     dotColor: Color(0xffD9D9D9),
              //   ),
              // ),
              CupertinoButton(
                color: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  if (pageIndex == 2) {
                    prefs.setBool(AppSharedKeys.first, true);
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const BuyScreen(),
                      ),
                    );
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff1DB954),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const PulseWebScreen(
                              title: 'Privacy Policy',
                              url:
                                  'https://sites.google.com/view/income-pulse/privacy-policy',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 13.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final hasPremiumAccess =
                            await Apphud.hasPremiumAccess();
                        final hasActiveSubscription =
                            await Apphud.hasActiveSubscription();
                        if (hasPremiumAccess || hasActiveSubscription) {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool(AppSharedKeys.prem, true);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Success!'),
                              content: const Text(
                                  'Your purchase has been restored!'),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (_) =>
                                            const MainBottomScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Restore purchase'),
                              content: const Text(
                                  'Your purchase is not found. Write to support: https://sites.google.com/view/income-pulse/support-from'),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () =>
                                      {Navigator.of(context).pop()},
                                  child: const Text('Ok'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Restore',
                        style: TextStyle(
                          fontSize: 13.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const PulseWebScreen(
                              title: 'Terms of use',
                              url:
                                  'https://sites.google.com/view/income-pulse/terms-conditions',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Terms of use',
                        style: TextStyle(
                          fontSize: 13.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
