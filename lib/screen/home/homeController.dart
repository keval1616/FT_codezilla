import 'dart:convert';

import 'package:codezilla/app_route.dart';
import 'package:codezilla/model/user_model.dart';
import 'package:codezilla/pref/app_Prefrance.dart';
import 'package:codezilla/screen/editscan_screen/editscreen_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenController extends GetxController {
  RxInt selectCategory = 0.obs;
  RxList categories =  [
    // "#All".tr,
    // "#Restorent".tr,
    // "#Websites".tr,
    // "#Buisness Center".tr,
    // "#class".tr
  ].obs;
  RxList<UserModel> homeUserList = <UserModel>[].obs;
  RxString  cameraScanResult = "".obs;

  late SharedPreferences sharedPreferences;
  Future initalGetSavedData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final jsondetails = jsonDecode(sharedPreferences.getString('categories')!);
  }

  getData(){

    if(AppPref().catList.isNotEmpty){
      categories.value = json.decode(AppPref().catList);
    }else{
      categories.value.addAll({   "#All".tr,
        "#Restorent".tr,
        "#Websites".tr,
        "#Buisness Center".tr,
        "#class".tr});
    }

  }
} 
