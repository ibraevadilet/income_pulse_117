import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_pulse_117/income/income_hive.dart';
import 'package:income_pulse_117/income/income_logics.dart';
import 'package:income_pulse_117/income/income_repository.dart';
import 'package:webview_flutter/webview_flutter.dart';

class IncomeDiagramPage extends StatefulWidget {
  final String incomeLink;
  final String incomeUtms;

  const IncomeDiagramPage({
    Key? key,
    required this.incomeLink,
    required this.incomeUtms,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IncomeDiagramPageState();
  }
}

class _IncomeDiagramPageState extends State<IncomeDiagramPage> {
  late WebViewController incomeWbController;
  late String incomeWvlnk;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    incomeWvlnk = '${widget.incomeLink}${widget.incomeUtms}';
    log(incomeWvlnk);
    incomeWbController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (url) async {
            final incomeCurrentUrl = url.url ?? '';

            if (incomeCurrentUrl.contains('cabinet')) {
              final localObject = await IncomeRepository().incomeLocalGet();
              if (localObject != null) {
                final newLocalObject = IncomeHive(
                  regincome: localObject.regincome,
                  strtincome: localObject.strtincome,
                  logincome: localObject.logincome,
                  cabincome: incomeCurrentUrl,
                );
                await IncomeRepository().incomeLocalSet(newLocalObject);
              }
            }
            final openInBrowser = incomeCurrentUrl.contains('.xlsx') ||
                incomeCurrentUrl.contains('.pdf') ||
                incomeCurrentUrl.contains('app/po-trade-broker') ||
                incomeCurrentUrl.contains('openbrowser=1');
            if (openInBrowser) {
              incomeBrowse(incomeCurrentUrl);
            }
            if (incomeCurrentUrl.contains('logout')) {
              final localObject = await IncomeRepository().incomeLocalGet();
              if (localObject != null) {
                final newLocalObject = IncomeHive(
                  regincome: localObject.regincome,
                  strtincome: localObject.strtincome,
                  logincome: localObject.logincome,
                  cabincome: '',
                );
                await IncomeRepository().incomeLocalSet(newLocalObject);
              }
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(incomeWvlnk))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X) AppleWebKit'
          '/605.1.15 (KHTML, like Gecko) Version/17.2 Mobile/15E148 Safari/604.1, webview_aso_ios_3');

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 5));
    });
    _enableRotation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await incomeWbController.canGoBack()) {
          await incomeWbController.goBack();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top,
            bottom: MediaQuery.of(context).viewPadding.bottom,
          ),
          child: WebViewWidget(
            controller: incomeWbController,
          ),
        ),
      ),
    );
  }

  void _enableRotation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
