import 'package:codezilla/google_login/google_login.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'screen/Authntication/login/login_screen.dart';
import 'screen/Authntication/register/signin_screen.dart';
import 'screen/editscan_screen/editscanscreen.dart';
import 'screen/home/homescreen.dart';
import 'screen/qr_scan_page/qr_scan_page.dart';
import 'screen/selectLanguageScreen/selectlanguage.dart';
import 'screen/splashscreen/spleshscreen.dart';

class AppRouter {
  static const selectLanguageScreen = '/selectLanguageScreen';
  static const homeScreen = '/homeScreen';
  static const editscanScreen = '/editscanScreen';
  static const qrScannerPage = '/qrScannerPage';
  static const loginScreen = '/loginScreen';
  static const splashScreen = '/splashScreen';
  static const registerScreen = '/registerScreen';


  static List<GetPage> getPages = [
    GetPage(
      name: selectLanguageScreen,
      page: () => const SelectLanguageScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: editscanScreen,
      page: () => EditscanScreen(),
    ),
    // GetPage(
    //   name: loginScreen,
    //   page: () => LoginScreen(),
    // ),
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: registerScreen,
      page: () => RegisterScreen(),
    ),
    // GetPage(
    //   name: qrScannerPage,
    //   page: () => const QrScannerPage(),
    // ),
  ];
}
