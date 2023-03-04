import 'package:get/get_navigation/src/routes/get_route.dart';

import 'screen/editscan_screen/editscanscreen.dart';
import 'screen/home/homescreen.dart';
import 'screen/qr_scan_page/qr_scan_page.dart';
import 'screen/selectLanguageScreen/selectlanguage.dart';



class AppRouter {
  static const selectLanguageScreen = '/selectLanguageScreen';
  static const homeScreen = '/homeScreen';
  static const editscanScreen = '/editscanScreen';
  static const qrScannerPage = '/qrScannerPage';



  static List<GetPage> getPages = [
    GetPage(
      name: selectLanguageScreen,
      page: () => const SelectLanguageScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () =>  HomeScreen(),
    ),
    GetPage(
      name: editscanScreen,
      page: () =>  EditscanScreen(),
    ),
    // GetPage(
    //   name: qrScannerPage,
    //   page: () => const QrScannerPage(),
    // ),

  ];
}
