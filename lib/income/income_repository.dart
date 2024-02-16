import 'package:hive_flutter/hive_flutter.dart';
import 'package:income_pulse_117/income/income_hive.dart';

class IncomeRepository {
  Future<IncomeHive?> incomeLocalGet() async {
    final incomeLocal = await Hive.openBox<IncomeHive>('incomeLocal');
    return incomeLocal.get('incomeLocal');
  }

  Future<void> incomeLocalSet(IncomeHive incomeLocalGet) async {
    final incomeLocal = await Hive.openBox<IncomeHive>('incomeLocal');
    await incomeLocal.put('incomeLocal', incomeLocalGet);
  }
}
