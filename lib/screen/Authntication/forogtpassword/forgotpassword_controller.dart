

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController userEmailController = TextEditingController();
  FocusNode userEmailFocusNode = FocusNode();

  RxString userEmailString = "".obs;
  Future resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: userEmailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password reset link sent! Check your Email"),
      ));
      Get.back();
    } catch (e) {
      print(e);
    }
  }
}