import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_enter_screens/pulse_web_screen.dart';
import 'package:income_pulse_117/helper_screens/currancy_screen.dart';
import 'package:income_pulse_117/main.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              const SizedBox(height: 12),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const CurrancyScreen(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white.withOpacity(0.04),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Currency',
                        style: TextStyle(
                          fontSize: 16.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 19.h),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const PulseWebScreen(
                        title: 'Privacy Policy',
                        url:
                            'https://docs.google.com/document/d/1aOj5DbGhxOOucsbQ0YtKfFjoRt-8j60Bb4fhxDRa12U/edit?usp=sharing',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white.withOpacity(0.04),
                  ),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 19.h),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const PulseWebScreen(
                        title: 'Terms of Use',
                        url:
                            'https://docs.google.com/document/d/1aOj5DbGhxOOucsbQ0YtKfFjoRt-8j60Bb4fhxDRa12U/edit?usp=sharing',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white.withOpacity(0.04),
                  ),
                  child: Text(
                    'Terms of Use',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 19.h),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const PulseWebScreen(
                        title: 'Support',
                        url:
                            'https://docs.google.com/document/d/1aOj5DbGhxOOucsbQ0YtKfFjoRt-8j60Bb4fhxDRa12U/edit?usp=sharing',
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white.withOpacity(0.04),
                  ),
                  child: Text(
                    'Support',
                    style: TextStyle(
                      fontSize: 16.h,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
