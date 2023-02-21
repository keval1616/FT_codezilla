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

  // var locales = [
  //   const Locale('en', ''),
  //   const Locale('ar', ''),
  // ];

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
// Future<Position> getGeoLocationPosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;
//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the
//     // App to enable the location services.
//     await Geolocator.openLocationSettings();
//     return Future.error('Location services are disabled.');
//   }
//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//
//       return Future.error('Location permissions are denied');
//     }
//   }
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately.
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }
//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
// }
}
