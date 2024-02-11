import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:income_pulse_117/app_enter_screens/second_app_screen.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';

class FirstAppScreen extends StatefulWidget {
  const FirstAppScreen({super.key});

  @override
  State<FirstAppScreen> createState() => _FirstAppScreenState();
}

class _FirstAppScreenState extends State<FirstAppScreen> {
  @override
  void initState() {
    initFirstScreen();
    super.initState();
  }

  initFirstScreen() async {
    await Future.delayed(const Duration(milliseconds: 1450));
    // final isFirst = prefs.getBool(AppSharedKeys.first) ?? false;
    const isFirst = false;
    if (!isFirst) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SecondAppScreen(),
        ),
      );
      await Future.delayed(const Duration(seconds: 8));
      try {
        final InAppReview inAppReview = InAppReview.instance;
        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      } catch (e) {
        throw Exception(e);
      }
    } else {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const MainBottomScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/images/spl_image.png',
          ),
        ),
      ),
    );
  }
}
