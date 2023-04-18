import 'package:codezilla/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterScreenController extends GetxController {
  TextEditingController userEmailController = TextEditingController();
  FocusNode userEmailFocusNode = FocusNode();
  TextEditingController userNameController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode confirmPasswordFocusNode = FocusNode();
  RxString userEmailString = "".obs;
  RxString confirmPasswordString = "".obs;
  RxString userNameString = "".obs;
  RxString userPasswordString = "".obs;
  RxBool showPass = false.obs;
  RxBool confirmShowPass = false.obs;
  String UserId = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  //firebse register with email and password
  Future signUpData() async {
    if (userEmailController.text.isNotEmpty &
    confirmPasswordController.text.isNotEmpty) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmailController.text.trim(),
        password: confirmPasswordController.text.trim(),
      );
      getCurrentUser();
      Get.offAllNamed(AppRouter.homeScreen);
    }
  }

  FirebaseDatabase database = FirebaseDatabase.instance;

  getCurrentUser() async {
    final auth = await FirebaseAuth.instance.currentUser;
    final uid = auth!.uid;
    UserId = uid;
    print('User ID:  $UserId');
    database.ref().child("users/${auth.uid}").set({
      'id': UserId,
      'Name': userNameString.value,
      'email': userEmailString.value
    });
  }
}
