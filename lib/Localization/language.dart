import 'dart:ui';

import 'package:codezilla/Localization/arSA.dart';
import 'package:codezilla/Localization/enUS.dart';
import 'package:get/get.dart';

//RxBool isEnglishLanguage = false.obs;

class LocalizationService extends Translations {
  // final globalController = Get.find<GlobalController>();
  // Default locale
  static final locale = Locale('en', 'US');

  static final locale1 = Locale('ar', 'SA');
  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');
// Supported languages
// Needs to be same order with locales
  static final langs = ['English', 'عربي'];

// Supported locales
// Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', 'SA'),
  ];

// Keys and their translations
// Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS, // lang/en_us.dart
    'ar_SA': arSA, // lang/tr_tr.dart
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}