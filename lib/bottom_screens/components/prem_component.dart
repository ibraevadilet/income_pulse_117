import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/main.dart';

class PremComponent extends StatelessWidget {
  const PremComponent({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Image.asset('assets/images/prem_image.png'),
        ),
        const SizedBox(height: 17),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(23),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(23),
              border: Border.all(
                color: const Color(0xff5A5A5A),
              ),
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                SizedBox(height: 3.h),
                Text(
                  'Premium',
                  style: TextStyle(
                    fontSize: 20.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 35.h),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/check_icon.png',
                      height: 20.h,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'Enhanced features.',
                      style: TextStyle(
                        fontSize: 16.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 33.h),
                FittedBox(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/check_icon.png',
                        height: 20.h,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Setting aside money for purposes',
                        style: TextStyle(
                          fontSize: 16.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 33.h),
                FittedBox(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/check_icon.png',
                        height: 20.h,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Monitor earnings by percentage',
                        style: TextStyle(
                          fontSize: 16.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  color: Colors.transparent,
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    await prefs.setBool(AppSharedKeys.prem, true);
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const MainBottomScreen(),
                      ),
                      (pred) => false,
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
                      'Unlock for 0.99\$',
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
        ),
      ],
    );
  }
}
