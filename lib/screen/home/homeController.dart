import 'package:codezilla/model/user_model.dart';
import 'package:codezilla/screen/editscan_screen/editscreen_controller.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  RxList<String> categories = [
    "#All".tr,
    "#Restorent".tr,
    "#Websites".tr,
    "#Buisness Center".tr,
    "#class".tr
  ].obs;
  RxList<UserModel> homeUserList = <UserModel>[].obs;

} 
