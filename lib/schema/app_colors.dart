import 'package:codezilla/pref/app_Prefrance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppColor {
  const AppColor._();
  static bool isDarkTheme() {
    return Get.isDarkMode;
  }

  static changeThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      AppPref().isDark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      AppPref().isDark = true;
    }
  }

  static Color blackWhiteColor() {
    return isDarkTheme()
        ? DarkTheme.chipSelectedDark
        : LightTheme.chipSelectedDark;
  }

  /* ======================Single Color=================*/

  static const conrainer = Color(0xFFF6F6F6);
  static const buttonbaground = Color(0xFFF2F3F5);
  static const deletbottoncolor = Color(0xFFF79090);
  static const red = Color(0xFFEB5757);
  static const greenUnread = Color(0xff07C9D3);

  /*========================ischool wallet =====================*/

  static const lightPink = Color(0xffEBB0FF);
  static const lightYellow = Color(0xffFDDD86);
  static const primaryColor = Color(0xff3E359E);
  static const lightPrimaryColor = Color(0xffE7E6FE);
  static const greyDark1 = Color(0xFFE7E7E7);
  static const greyDark2 = Color(0xFF7C7C7C);
  static const greyDark4 = Color(0xFF525252);
  static const lightgrey = Color(0xFFEFEFEF);
  static const lightRed = Color(0xFFFFE9E9);
  static const lightGrey = Color(0xFFF2F2F2);
  static const green = Color(0xFF47C233);
  static const graybutton = Color(0xffDCDCDC);
  static const textfieldbg = Color(0XFF3C49DD);

  /*===========================home screen ischool==========*/
  static const lightgreen = Color(0xffDEEFDC);
  static const lightpink = Color(0xffEDDCEF);
  static const lightCoffee = Color(0xffEFDCDC);
  static const lightPitch = Color(0xffF8B6B2);
  static const bgColor = Color(0xffF5F6FE);
  static const dealsTextColor = Color(0xff07C9D3);
  static const offtext = Color(0xff7573EC);
  static const expirescolor = Color(0xff0162FD);
  static const exclusivecolor = Color(0xff8A65F1);
  static const graytextcolr = Color(0xff636363);
  static const grayColor = Color(0xff979797);
  static const darkblue = Color(0xff3E369D);
  static const accountLitTile = Color(0xffF7F7F7);
  static const accountTextFieldHintColor = Color(0xff6A6E83);
  static const accountTextFieldColor = Color(0xffB8BDDB);

/*===========================Auto Service Screen==========*/
  static const greyDark3 = Color(0xff8C8C8C);
}

class DarkTheme {
  static const chipSelectedDark = Color(0xffFFFFFF);
}

class LightTheme {
  static const chipSelectedDark = Color(0xff000000);
}
