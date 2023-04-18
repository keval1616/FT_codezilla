import 'dart:async';
import 'dart:convert';

import 'package:codezilla/app_route.dart';
import 'package:codezilla/pref/app_Prefrance.dart';
import 'package:codezilla/screen/home/homeController.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'service/localization_service.dart';
import 'utils/data_connection_checker.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await AppPref().isPreferenceReady;

  Get.put(HomeScreenController());
  // home.getData();
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
      initialRoute: AppRouter.splashScreen,
      getPages: AppRouter.getPages,
      translations: Messages(),
      locale: Locale('en_US'),
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
        'en': {
          'hello': 'Hello World',
          "CodeZilla Wallet": "CodeZilla Wallet",
          "CAMERA SCAN": "CAMERA SCAN",
          "#All": "#All",
          "#Restorent": "#Restorent",
          "#Websites": "#Websites",
          "#Buisness Center": "#Buisness Center",
          "#class": "#class"
        },
        'ar_SA': {
          "#All": "#الجميع",
          'hello': 'مرحبًا',
          "CodeZilla Wallet": 'كودزيلا والت ',
          "CAMERA SCAN": "مسح الكاميرا",
          "#Restorent": "#مصلح",
          "#Websites": "المواقع",
          "#Buisness Center": "مركز الأعمال ",
          "#class": "فصل"
        }
      };
}
