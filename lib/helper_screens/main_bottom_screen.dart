import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/bottom_screens/add_screen.dart';
import 'package:income_pulse_117/bottom_screens/bottom_premium_screen.dart';
import 'package:income_pulse_117/bottom_screens/calendar_screen.dart';
import 'package:income_pulse_117/bottom_screens/main_balance_screen.dart';
import 'package:income_pulse_117/bottom_screens/operation_screen.dart';
import 'package:income_pulse_117/main.dart';

class MainBottomScreen extends StatefulWidget {
  const MainBottomScreen({super.key, this.index = 0});
  final int index;

  @override
  State<MainBottomScreen> createState() => _MainBottomScreenState();
}

class _MainBottomScreenState extends State<MainBottomScreen> {
  late int currantIndex = widget.index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: botttomPages[currantIndex],
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: const Color(0xff4F4F4F),
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 15,
          selectedFontSize: 15,
          currentIndex: currantIndex,
          onTap: (indexFrom) async {
            setState(() {
              currantIndex = indexFrom;
            });
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
      ),
    );
  }

  final List<Widget> botttomPages = [
    const MainBalanceScreen(),
    const OperationScreen(),
    const AddScreen(),
    const CalendarScreen(),
    const BottomPremiumScreen(),
  ];
}
