import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 22.w),
      contentPadding: EdgeInsets.symmetric(horizontal: 23.w),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}
