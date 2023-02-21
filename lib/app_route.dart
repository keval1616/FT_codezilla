import 'package:get/get_navigation/src/routes/get_route.dart';

import 'screen/editscan_screen/editscanscreen.dart';
import 'screen/home/homescreen.dart';
import 'screen/selectLanguageScreen/selectlanguage.dart';



class AppRouter {
  static const selectLanguageScreen = '/selectLanguageScreen';
  static const homeScreen = '/homeScreen';
  static const editscanScreen = '/editscanScreen';



  static List<GetPage> getPages = [
    GetPage(
      name: selectLanguageScreen,
      page: () => const SelectLanguageScreen(),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: editscanScreen,
      page: () => const EditscanScreen(),
    ),

  ];
}
