import 'dart:convert';
import 'dart:io';

import 'package:codezilla/model/user_model.dart';
import 'package:codezilla/screen/home/homeController.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScreenController extends GetxController {
  RxInt selectCategory = 0.obs;
  RxInt selectIcon = 0.obs;
  RxString saveIcon = "".obs;
  RxString SelectCategories = "".obs;
  RxString Selectimage = "".obs;

  RxBool addCategory = false.obs;
  RxBool selecticon = false.obs;
  File? image;
  final picker = ImagePicker();
  // RxList  CategoriesList =
  //     ["#All", "#Restorent", "#Websites", "#Buisness Center", "#class"].obs;
  List IconImageList = [
    "assets/icon/icon.png",
    "assets/icon/icon2.png",
    "assets/icon/icon3.png",
    "assets/icon/icon4.png",
    "assets/icon/icon5.png",
    "assets/icon/icon6.png",
    "assets/icon/icon7.png",
    "assets/icon/icon8.png",
    "assets/icon/icon9.png",
    "assets/icon/icon10.png",
    "assets/icon/icon11.png",
    "assets/icon/icon12.png",
    "assets/icon/icon13.png",
    "assets/icon/icon14.png",
    "assets/icon/icon15.png",
    "assets/icon/icon16.png",
  ];

  RxList<UserModel> userList = <UserModel>[].obs;

  final TextEditingController url = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();
  late SharedPreferences sharedPreferences;
  final HomeScreenController _homeScreenController =
      Get.find<HomeScreenController>();
  Future initalGetSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final jsondetails = jsonDecode(sharedPreferences.getString('userdata')!);
    userList.value.clear();
    _homeScreenController.homeUserList.clear();
    for (int i = 0; i < jsondetails.length; i++) {
      userList.add(UserModel.fromJson(jsondetails[i]));
      _homeScreenController.homeUserList
          .add(UserModel.fromJson(jsondetails[i]));
    }
    // Records userModel = Records.fromJson(jsondetails);
    // UserModel userModel = UserModel.fromJson(jsondetails);
    userList.forEach((element) {
      print("*******kk***********${element.title}");
    });
  }

  Future storedata() async {
    print(userList.toJson().toList());
    List<Map<String, dynamic>> tempUserData = [];
    userList.forEach((element) async {
      tempUserData.add({
        "url": element.url,
        "title": element.title,
        "category": element.category,
        "note": element.note,
        "logo": element.logo,
        "image": element.image,
      });
    });
    String userdata = jsonEncode(tempUserData);
    await sharedPreferences.setString('userdata', userdata);
    await initalGetSavedData();

    // AppPrefef().chat = jsonEncode(tempChat);
  }

  deletedata() {
    // userList.remove(element)
  }
}
