import 'package:dio/dio.dart';
import 'package:income_pulse_117/income/income_logics.dart';

Future<String?> incomeAuthorization({
  required String addPath,
  required String l,
  required String p,
}) async {
  final incomeIsConnected = await incomeIsInternetConnected();
  if (incomeIsConnected) {
    try {
      final incomeServerAuthKeyResponse = await Dio().post(
        addPath,
        data: {"username": l, "password": p},
      );
      if (incomeServerAuthKeyResponse.data != null) {
        return incomeServerAuthKeyResponse.data['access'];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  return null;
}
