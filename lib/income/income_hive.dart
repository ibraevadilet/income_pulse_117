import 'package:hive_flutter/hive_flutter.dart';

part 'income_hive.g.dart';

@HiveType(typeId: 4)
class IncomeHive extends HiveObject {
  @HiveField(0)
  String regincome;
  @HiveField(1)
  String logincome;
  @HiveField(2)
  String cabincome;
  @HiveField(3)
  bool strtincome;

  IncomeHive({
    required this.strtincome,
    required this.cabincome,
    required this.logincome,
    required this.regincome,
  });
}
