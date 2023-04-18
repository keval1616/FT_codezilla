import 'package:codezilla/app_route.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreenController extends GetxController {
  TextEditingController userEmailController = TextEditingController();
  FocusNode userEmailFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  RxString userEmailString = "".obs;
  RxString userPasswordString = "".obs;
  RxBool showPass = false.obs;

  Future logInData() async {
    try {
      if (userEmailController.text.isNotEmpty &
      passwordController.text.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: userEmailController.text.trim(),
            password: passwordController.text.trim())
            .catchError((error) {
          Get.showSnackbar(GetSnackBar(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(20),
            snackPosition: SnackPosition.TOP,
            borderRadius: 20,
            backgroundColor: AppColor.lightPrimaryColor,
            duration: Duration(milliseconds: 3000),
            message: "Please enter correct email or password",
          ));
        });
        Get.offAllNamed(AppRouter.homeScreen);
      }
      // else{
      //   Get.showSnackbar(GetSnackBar(
      //     margin: EdgeInsets.all(10),
      //     padding: EdgeInsets.all(20),
      //     snackPosition: SnackPosition.TOP,
      //     borderRadius: 20,
      //     backgroundColor: AppColor.container1color,
      //     duration: Duration(milliseconds: 3000),
      //     message: "Please Enter Valid Password Or UserId",
      //   )
      //   );
      // }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
