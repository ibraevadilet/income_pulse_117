import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_enter_screens/info_cnt.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/helper_screens/buy_screen.dart';
import 'package:income_pulse_117/main.dart';

class AppInfoScreen extends StatefulWidget {
  final String linkImage;
  const AppInfoScreen({super.key, required this.linkImage});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  final controller = PageController();
  int pageIndex = 0;
  late List<InfoCnt> tokenInformation;
  @override
  void initState() {
    if (widget.linkImage.isEmpty) {
      tokenInformation = listInfo;
    } else {
      tokenInformation = listInfoPocket;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.linkImage.isEmpty
          ? const Color(0xff272727)
          : const Color(0xff232B45),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: tokenInformation.length,
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
                itemBuilder: ((context, index) => InfoWidget(
                      model: tokenInformation[index],
                    )),
              ),
            ),
            SizedBox(height: 24.h),
            CupertinoButton(
              color: Colors.transparent,
              padding: EdgeInsets.zero,
              onPressed: () async {
                if (pageIndex == 4) {
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
                margin: EdgeInsets.symmetric(horizontal: 16.r),
                padding: const EdgeInsets.all(14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: widget.linkImage.isEmpty
                      ? const Color(0xff1DB954)
                      : const Color(0xff4E8AFF),
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
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    Key? key,
    required this.model,
  }) : super(key: key);
  final InfoCnt model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: Image.asset(model.images),
          ),
          SizedBox(height: 30.h),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.h,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            model.subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.h,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
