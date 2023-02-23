import 'package:codezilla/app_route.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({Key? key}) : super(key: key);

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Image.asset("assets/home/homescreen.png"),
          SizedBox(
            height: 60,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 330,
          width: double.maxFinite, //set your width here
          decoration: BoxDecoration(
            color: AppColor.conrainer,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 40),
            child: Column(
              children: [
                Text(
                  "Your favorites restaurants \n QR menus in one place 😍 ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Digital wallet for QR codes. Scan any QR code once and keep it in your pocket.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouter.homeScreen);
                  },
                  child: Container(
                    width: 286,
                    height: 48,
                    child: Center(
                        child: Text(
                      "English",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.conrainer,
                        border: Border.all(width: 0.5, color: Colors.grey)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRouter.homeScreen);
                  },
                  child: Container(
                    width: 286,
                    height: 48,
                    child: Center(
                        child: Text(
                      "العربية",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
