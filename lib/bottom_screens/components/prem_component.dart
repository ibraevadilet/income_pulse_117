import 'package:apphud/apphud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/main.dart';

class PremComponent extends StatefulWidget {
  const PremComponent({super.key});

  @override
  State<PremComponent> createState() => _PremComponentState();
}

class _PremComponentState extends State<PremComponent> {
  bool isBuying = false;
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
                    setState(() {
                      isBuying = true;
                    });
                    final apphudPaywalls = await Apphud.paywalls();
                    print(apphudPaywalls);

                    await Apphud.purchase(
                      product: apphudPaywalls?.paywalls.first.products?.first,
                    ).whenComplete(
                      () async {
                        if (await Apphud.hasPremiumAccess() ||
                            await Apphud.hasActiveSubscription()) {
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
                                        MaterialPageRoute(
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
                                    'Your purchase is not found. Write to support: https://docs.google.com/forms/d/e/1FAIpQLSe2dY5sixywVpTYU9K34aEqYi67rDquTx9XMeDZWeU2de_rag/viewform?usp=sf_link'),
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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainBottomScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
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
