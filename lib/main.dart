import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:income_pulse_117/app_enter_screens/first_app_screen.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

const fontFamily = 'Montserrat';
late final SharedPreferences prefs;
late Box<MoneySaveHiveModel> moneyBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Apphud.start(apiKey: 'app_MpqHUXMQa7vNG8n4ZfvEXJ4QzrzfSk');
  await Hive.initFlutter();
  Hive.registerAdapter(MoneySaveHiveModelAdapter());
  prefs = await SharedPreferences.getInstance();
  moneyBox = await Hive.openBox<MoneySaveHiveModel>('money');
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pulse Power',
        home: child,
        theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xff272727),
            shadowColor: Colors.black,
          ),
          scaffoldBackgroundColor: const Color(0xff272727),
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
        ),
      ),
      child: const FirstAppScreen(),
    );
  }
}
