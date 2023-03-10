import 'dart:ui';

import 'package:codezilla/Localization/enUS.dart';
import 'package:codezilla/pref/app_Prefrance.dart';
import 'package:get/get.dart';


class LocalizationService extends Translations {
  // Default locale
  static const locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('ar', 'eg');

  // Supported languages
  // Needs to be same order with locales
  static final langs = ['English', 'ગુજરાતી', 'Türkçe'];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('gu', 'IN'),
    const Locale('tr', 'TR'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': enUS, // lang/en_us.dart
    // 'gu': guIn, // lang/en_arb.dart
    // 'tr_TR': trTR, // lang/tr_tr.dart
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
    AppPref().languageCode = locale.languageCode;
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  String getLanguageFromLocal() {
    for (int i = 0; i < locales.length; i++) {
      if (AppPref().languageCode == locales[i].languageCode) return langs[i];
    }
    return "English";
  }
}
