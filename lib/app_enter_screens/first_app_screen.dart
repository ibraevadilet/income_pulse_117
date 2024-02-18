import 'package:flutter/material.dart';
import 'package:income_pulse_117/income/income_cash.dart';

class FirstAppScreen extends StatefulWidget {
  const FirstAppScreen({super.key});

  @override
  State<FirstAppScreen> createState() => _FirstAppScreenState();
}

class _FirstAppScreenState extends State<FirstAppScreen> {
  bool? incomePreepb;
  @override
  void initState() {
    incomeCash(context, (val) {
      setState(() {
        incomePreepb = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232B45),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1000),
          opacity: incomePreepb == null ? 0 : 1,
          child: Image.asset(
            incomePreepb != null && incomePreepb!
                ? 'assets/images/logoPo.png'
                : 'assets/images/spl_image.png',
          ),
        ),
      ),
    );
  }
}
