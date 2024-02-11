import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_enter_screens/app_info_screen.dart';
import 'package:income_pulse_117/app_enter_screens/pulse_web_screen.dart';
import 'package:income_pulse_117/main.dart';

class SecondAppScreen extends StatelessWidget {
  const SecondAppScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 37),
                  child: Image.asset(
                    'assets/images/spl_image_2.png',
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 28.h,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 26),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By clicking “Continue”, you agree to our ',
                  style: TextStyle(
                    fontSize: 12.h,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.normal,
                  ),
                  children: [
                    TextSpan(
                      text: 'Privacy policy',
                      //'политикой конфиденциальности ',
                      style: TextStyle(
                        fontSize: 12.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff528FFC),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const PulseWebScreen(
                                title: 'Privacy policy',
                                url:
                                    'https://docs.google.com/document/d/1aOj5DbGhxOOucsbQ0YtKfFjoRt-8j60Bb4fhxDRa12U/edit?usp=sharing',
                              ),
                            ),
                          );
                        },
                    ),
                    const TextSpan(
                      text: ' and ',
                    ),
                    TextSpan(
                      text: 'User agreement',
                      style: TextStyle(
                        fontSize: 12.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff528FFC),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const PulseWebScreen(
                                title: 'User agreement',
                                url:
                                    'https://docs.google.com/document/d/1aOj5DbGhxOOucsbQ0YtKfFjoRt-8j60Bb4fhxDRa12U/edit?usp=sharing',
                              ),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              CupertinoButton(
                color: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AppInfoScreen(),
                    ),
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
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
