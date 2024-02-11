import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_enter_screens/pulse_web_screen.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/prem_component.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/main.dart';

class BuyScreen extends StatelessWidget {
  const BuyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (context) => const MainBottomScreen(),
              ),
              (pred) => false,
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Expanded(child: PremComponent()),
              SizedBox(height: 17.h),
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
                                  'https://docs.google.com/document/d/1aOj5DbGhxOOucsbQ0YtKfFjoRt-8j60Bb4fhxDRa12U/edit?usp=sharing',
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
                                  'Your purchase is not found. Write to support: urll'),
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
                                  'https://docs.google.com/document/d/1aOj5DbGhxOOucsbQ0YtKfFjoRt-8j60Bb4fhxDRa12U/edit?usp=sharing',
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
              SizedBox(height: 17.h),
            ],
          ),
        ),
      ),
    );
  }
}
