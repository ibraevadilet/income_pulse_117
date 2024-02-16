import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';
import 'package:country_codes/country_codes.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

Future<bool> incomeIsUsingVpn() async {
  var incomeConnectivityResult = await (Connectivity().checkConnectivity());

  return incomeConnectivityResult == ConnectivityResult.vpn;
}

Future<String> incomeCountryCode() async {
  await CountryCodes.init();

  final Locale? incomeDeviceLocale = CountryCodes.getDeviceLocale();

  if (incomeDeviceLocale != null && incomeDeviceLocale.countryCode != null) {
    return incomeDeviceLocale.countryCode!.toLowerCase();
  }
  return '';
}

Future<bool> incomeIsSemulator(BuildContext context) async {
  DeviceInfoPlugin incomeDeviceInfoPlugin = DeviceInfoPlugin();
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    IosDeviceInfo incomeIosDeviceInfo = await incomeDeviceInfoPlugin.iosInfo;
    return !incomeIosDeviceInfo.isPhysicalDevice;
  }
  return false;
}

Future<int> incomeBatteryLevel() async {
  final Battery incomeBattery = Battery();
  try {
    int incomeBatteryLevel = await incomeBattery.batteryLevel;

    return incomeBatteryLevel;
  } catch (e) {}
  return 0;
}

Future<bool> incomeIsCharging() async {
  final Battery incomeBattery = Battery();
  try {
    bool incomeIsCharging = false;
    incomeBattery.onBatteryStateChanged.listen((BatteryState state) {
      if (state == BatteryState.charging) {
        incomeIsCharging = true;
      }
    });
    return incomeIsCharging;
  } catch (e) {
    throw Exception(e);
  }
}

Future<bool> incomeIsInternetConnected() async {
  final FlutterNetworkConnectivity incomeFlutterNetworkConnectivity =
      FlutterNetworkConnectivity(
    isContinousLookUp: true,
    lookUpDuration: const Duration(seconds: 5),
  );
  bool incomeIsNetworkConnectedOnCall =
      await incomeFlutterNetworkConnectivity.isInternetConnectionAvailable();
  return incomeIsNetworkConnectedOnCall;
}

Future<void> incomeBrowse(String ur) async {
  final url = Uri.parse(ur).normalizePath();
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}

Future<String> incomeGetTime() async {
  tzdata.initializeTimeZones();

  tz.TZDateTime moscowTime = tz.TZDateTime.now(tz.getLocation('Europe/Moscow'));
  return DateTime(moscowTime.year, moscowTime.month, moscowTime.day,
          moscowTime.hour, moscowTime.minute)
      .toString();
}
