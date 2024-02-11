import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/main.dart';

class BottomBarForOther extends StatelessWidget {
  const BottomBarForOther({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: const Color(0xff4F4F4F),
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 15,
        selectedFontSize: 15,
        currentIndex: 2,
        onTap: (indexFrom) async {
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MainBottomScreen(index: indexFrom),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child;
              },
            ),
            (route) => false,
          );
        },
        selectedLabelStyle: TextStyle(
          fontSize: 13.h,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        selectedItemColor: Colors.white,
        unselectedLabelStyle: TextStyle(
          fontSize: 13.h,
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          color: const Color(0xffAFAFAF),
        ),
        unselectedItemColor: const Color(0xffAFAFAF),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Image.asset(
              'assets/images/bottom_1_in_active.png',
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/images/bottom_1_active.png',
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Operation',
            icon: Image.asset(
              'assets/images/bottom_2_in_active.png',
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/images/bottom_2_active.png',
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Image.asset(
                'assets/images/bottom_3_add.png',
                width: 24,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Calendar',
            icon: Image.asset(
              'assets/images/bottom_4_in_active.png',
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/images/bottom_4_active.png',
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Premium',
            icon: Image.asset(
              'assets/images/bottom_5_in_active.png',
              width: 24,
            ),
            activeIcon: Image.asset(
              'assets/images/bottom_5_active.png',
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
