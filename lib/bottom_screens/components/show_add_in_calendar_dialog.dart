import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:income_pulse_117/app_helpers/shared_keys.dart';
import 'package:income_pulse_117/bottom_screens/components/income_data_model.dart';
import 'package:income_pulse_117/main.dart';
import 'package:income_pulse_117/models/money_save_hive_model/money_save_hive_model.dart';
import 'package:income_pulse_117/repositories/money_save_repo.dart';
import 'package:intl/intl.dart';

Future<void> showAddInCalendarDialog(
    BuildContext context, DateTime date) async {
  final currancy = prefs.getString(AppSharedKeys.currancy) ?? '\$';
  final isPrem = prefs.getBool(AppSharedKeys.prem) ?? false;
  String amount = '';
  String? operationType;
  String? categoryType;
  String? walletType;

  List<String> operationTypeList = [
    'Income',
    'Expense',
  ];

  late List<String> categoryTypeList = operationType == null
      ? []
      : operationType == 'Income'
          ? incomesTypeList.map<String>((e) => e.name).toList()
          : expensesTypeList.map<String>((e) => e.name).toList();

  List<String> walletTypeList = [
    if (isPrem) 'Save',
    'Cash',
    'Visa Card',
  ];

  bool allOk() =>
      amount.isNotEmpty &&
      operationType != null &&
      categoryType != null &&
      walletType != null;

  final border = UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white.withOpacity(0.5),
      width: 2,
    ),
  );
  await showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10.0),
      ),
    ),
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 12.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      DateFormat('dd/MM/yyyy').format(date),
                      style: TextStyle(
                        fontSize: 12.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                      thickness: 2,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontSize: 12.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        amount = value;
                      },
                      style: TextStyle(
                        fontSize: 12.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefix: Text(
                          '$currancy ',
                          style: TextStyle(
                            fontSize: 12.h,
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        border: border,
                        enabledBorder: border,
                        disabledBorder: border,
                        focusedBorder: border,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Operation Type',
                      style: TextStyle(
                        fontSize: 12.h,
                        fontFamily: fontFamily,
                        fontWeight: FontWeight.w900,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    DropdownButtonFormField<String>(
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        border: border,
                        enabledBorder: border,
                        disabledBorder: border,
                        focusedBorder: border,
                      ),
                      value: operationType,
                      hint: Text(
                        'Select operation type',
                        style: TextStyle(
                          fontSize: 12.h,
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      items: operationTypeList
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 12.h,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? val) {
                        operationType = val;
                        categoryType = null;
                        categoryTypeList = operationType == 'Income'
                            ? incomesTypeList
                                .map<String>((e) => e.name)
                                .toList()
                            : expensesTypeList
                                .map<String>((e) => e.name)
                                .toList();
                        setState(() {});
                      },
                    ),
                    if (operationType != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.h),
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 12.h,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w900,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              focusedBorder: border,
                            ),
                            value: categoryType,
                            hint: Text(
                              'Select category',
                              style: TextStyle(
                                fontSize: 12.h,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            items: categoryTypeList
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 12.h,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? val) {
                              categoryType = val;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Wallet',
                            style: TextStyle(
                              fontSize: 12.h,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w900,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: border,
                              enabledBorder: border,
                              disabledBorder: border,
                              focusedBorder: border,
                            ),
                            value: walletType,
                            hint: Text(
                              'Select wallet',
                              style: TextStyle(
                                fontSize: 12.h,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            items: walletTypeList
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 12.h,
                                        fontFamily: fontFamily,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (String? val) {
                              walletType = val;
                              setState(() {});
                            },
                          ),
                          SizedBox(height: 12.h),
                          InkWell(
                            onTap: allOk()
                                ? () async {
                                    final moneyModel = MoneySaveHiveModel(
                                      date: date,
                                      summ: int.parse(amount),
                                      incomeType: operationType!,
                                      iconType: categoryType!,
                                      cachType: walletType!,
                                    );
                                    await MoneySaveRepo.setMoney(moneyModel);
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xff1DB954),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 16.h,
                                  fontFamily: fontFamily,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
