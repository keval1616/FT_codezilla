

import 'dart:io';

import 'package:codezilla/model/user_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditScreenController extends GetxController {
 int? Exp;
  RxBool addCategory = false.obs;
  File? image;
  final picker = ImagePicker();
  RxList  CategoriesList = ["#All","#Restorent","#Websites","#Buisness Center","#class"].obs;
  List <Image> IconImage = [
    Image.asset("assets/icon/icon.png"),
    Image.asset("assets/icon/icon2.png"),
    Image.asset("assets/icon/icon3.png"),
    Image.asset("assets/icon/icon4.png"),
    Image.asset("assets/icon/icon5.png"),
    Image.asset("assets/icon/icon6.png"),
    Image.asset("assets/icon/icon7.png"),
    Image.asset("assets/icon/icon8.png"),
    Image.asset("assets/icon/icon9.png"),
    Image.asset("assets/icon/icon10.png"),
    Image.asset("assets/icon/icon11.png"),
    Image.asset("assets/icon/icon12.png"),
    Image.asset("assets/icon/icon13.png"),
    Image.asset("assets/icon/icon14.png"),
    Image.asset("assets/icon/icon15.png"),
    Image.asset("assets/icon/icon16.png"),
  ];

  final TextEditingController url = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  late UserModel currentUser;
}