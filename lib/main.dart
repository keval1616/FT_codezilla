import 'dart:async';

import 'package:codezilla/app_route.dart';
import 'package:codezilla/pref/app_Prefrance.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'service/localization_service.dart';
import 'utils/data_connection_checker.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await AppPref().isPreferenceReady;

  runApp(const MyApp());


}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<StreamSubscription> _streams = [];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver;
    _internetAvailability();
    // getGeoLocationPosition();
    debugPrint(
        "------------------>>>>>>>>>>>>${Get.deviceLocale!.languageCode}");
    super.initState();
  }

  @override
  void dispose() {
    for (var element in _streams) {
      element.cancel();
    }
    WidgetsBinding.instance.removeObserver;
    super.dispose();
  }
  bool isInternetAvailable = false;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRouter.selectLanguageScreen,
      getPages: AppRouter.getPages,
      translations: Messages(),
      locale: Locale('en','US'),
      // home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      // themeMode: (AppPref().isDark ? ThemeMode.dark : ThemeMode.light),
      // locale: Locale(AppPref().languageCode),
      // fallbackLocale: LocalizationService.fallbackLocale,
      // translations: LocalizationService(),
    );
  }


  _internetAvailability() async {
    _streams.add(Connectivity()
        .onConnectivityChanged
        .listen((event) => _checkInternetStatus(event)));
    if (GetPlatform.isIOS) {
      _checkInternetStatus(await Connectivity().checkConnectivity());
    }
  }

  _checkInternetStatus(ConnectivityResult result) async {
    print(result);
    if (result == ConnectivityResult.none) {
      isInternetAvailable = false;
      print(isInternetAvailable);
    } else {
      isInternetAvailable = await DataConnectionChecker().hasConnection;
      print(isInternetAvailable);
    }
  }

}
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'hello': 'Hello World',
      "CodeZilla Wallet": "CodeZilla Wallet",
    },
    'hi_IN': {
      'hello': 'नमस्ते दुनिया',
      "CodeZilla Wallet" :'नमस्ते दुनिया'
    }
  };
}