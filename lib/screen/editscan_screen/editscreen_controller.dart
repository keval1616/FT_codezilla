

import 'dart:io';

import 'package:codezilla/model/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditScreenController extends GetxController {
 RxInt selectCategory = 0.obs;
 RxInt selectIcon = 0.obs;
 RxString saveIcon = "".obs;

  RxBool addCategory = false.obs;
 RxBool selecticon = false.obs;
  File? image;
  final picker = ImagePicker();
  RxList  CategoriesList = ["#All","#Restorent","#Websites","#Buisness Center","#class"].obs;
  List  IconImageList = [
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

  final TextEditingController url = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  late UserModel currentUser;
}