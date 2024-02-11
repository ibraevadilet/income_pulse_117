// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'money_save_hive_model.g.dart';

@HiveType(typeId: 2)
class MoneySaveHiveModel extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int summ;

  @HiveField(2)
  String incomeType;

  @HiveField(3)
  String iconType;

  @HiveField(4)
  String cachType;

  MoneySaveHiveModel({
    required this.date,
    required this.summ,
    required this.incomeType,
    required this.iconType,
    required this.cachType,
  });

  @override
  String toString() {
    return 'Money(date: $date, summ: $summ, incomeType: $incomeType, iconType: $iconType, cachType: $cachType)';
  }
}
