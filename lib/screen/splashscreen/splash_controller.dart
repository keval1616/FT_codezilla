

import 'package:codezilla/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onReady() {
    visible.value = true;

    _startApp();
    super.onReady();
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  RxBool visible = false.obs;

  void _startApp() async {
    if (kDebugMode) {
      print("=========================$auth");
    }
    Future.delayed(const Duration(seconds: 5), () async {
      if (auth.currentUser == null) {
        Get.offAllNamed(AppRouter.loginScreen);
      } else {
        Get.offAllNamed(AppRouter.selectLanguageScreen);
      }
    });
  }
}