import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';

class MoneySaveRepo {
  static List<MoneySaveHiveModel> getMoney() {
    return moneyBox.values.toList();
  }

  static Future<void> setMoney(MoneySaveHiveModel moneyModel) async {
    await moneyBox.add(moneyModel);
  }

  static Future<void> clearMoney() async {
    await moneyBox.clear();
  }
}
