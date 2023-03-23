import 'dart:io';

import 'package:codezilla/app_route.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/editscan_screen/editscanscreen.dart';
import 'package:codezilla/screen/editscan_screen/editscreen_controller.dart';
import 'package:codezilla/screen/home/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final editScreenController = Get.put(EditScreenController());
  final homeScreenController = Get.find<HomeScreenController>();
  // var qrlink = Get.arguments[0];
  // var title = Get.arguments[1];
  // var categories = Get.arguments[2];
  // var note = Get.arguments[3];
  // var image = Get.arguments[4];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editScreenController.initalGetSavedData();
  }

  bool navigate = true;
  Future _scanQR() async {
    var camerastatus = await Permission.camera.status;
    if (camerastatus.isGranted) {
      homeScreenController.cameraScanResult.value = (await scanner.scan())!;
      Get.toNamed(AppRouter.editscanScreen,);

      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => EditscanScreen(link: cameraScanResult)));
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        homeScreenController.cameraScanResult.value = (await scanner.scan())!;

      }
    }
  }


  getDataByCategory(int index){
    // homeScreenController.homeUserList.value =
    //     editScreenController.userList
    //         .where((p0) =>
    //     p0.category?.toLowerCase() ==
    //         homeScreenController.categories[index].toLowerCase())
    //         .toList();
    // homeScreenController.homeUserList.refresh();
    // print(homeScreenController.homeUserList.value );

    homeScreenController.homeUserList.clear();
    if(index==0){
      homeScreenController.homeUserList.addAll(editScreenController.userList);
      homeScreenController.homeUserList.refresh();
    }else{

      homeScreenController.homeUserList.clear();
      for(int i=0;i<editScreenController.userList.length;i++){

        // print(editScreenController.userList[i].category);
        // print((homeScreenController.categories[j]));
        if(editScreenController.userList[i].category==homeScreenController.categories[index]){
          print("here");
          homeScreenController.homeUserList.add(editScreenController.userList[i]);
          print( "==============>   ${homeScreenController.homeUserList}");
        }

      }
      homeScreenController.homeUserList.refresh();

    }

  }
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.conrainer,
        appBar: AppBar(
          leadingWidth: 40,
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              "assets/home/codezilla.png",
              width: 13,
              height: 16,
            ),
          ),
          elevation: 0,
          backgroundColor: AppColor.conrainer,
          title: Text(
            "CodeZilla Wallet".tr,
            style: TextStyle(
                fontFamily: 'MS Sans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              child: Obx(()=>
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeScreenController.categories.length,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            homeScreenController.selectCategory.value = index;
                          });
                          print(homeScreenController.categories[index]);
                          getDataByCategory(index);
                        },
                        child: Container(
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              homeScreenController.categories[index],
                              style: TextStyle(
                                fontFamily: 'MS Sans',
                                fontSize: 14,
                                color: homeScreenController.selectCategory.value == index ? Colors.white : Colors.black
                              ),
                            ),
                          )),
                          decoration: BoxDecoration(
                            color: homeScreenController.selectCategory.value == index ? Colors.blueAccent : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // SizedBox(height: 150,),
            // Image.asset("assets/home/blurbarcode.png",width: 200,height: 200,),
            // SizedBox(height: 50,),
            // Text("No data found, scan your first code",style: TextStyle(fontSize: 16),),

            Expanded(
              child: Obx(
                () => Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeScreenController.homeUserList.value.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12, top: 7, bottom: 7),
                          child: Obx(
                            () => GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRouter.editscanScreen,
                                    arguments: [
                                      homeScreenController
                                          .homeUserList.value[index],
                                      isupdate = true
                                    ]);

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          print(
                                              "*********************IMAGE#################${homeScreenController.homeUserList.value[index].image}");
                                          print("&&&&&&&&&&&&&&&&LoGO ${homeScreenController.homeUserList.value[index].logo??""}");

                                        },
                                        child:
                                        homeScreenController
                                            .homeUserList.value[index].image!.isNotEmpty ?
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(59),
                                          child: Image.file(
                                            File(
                                                homeScreenController
                                                    .homeUserList.value[index].image??"",
                                            ),
                                            height: 60,
                                            width: 60,

                                            fit: BoxFit.cover,
                                            alignment: Alignment.topCenter,
                                          ),
                                        ):
                                        homeScreenController
                                            .homeUserList.value[index].logo!.isNotEmpty?
                                         Container(
                                           width: 60,
                                           height: 60,
                                           child: Image.asset(homeScreenController
                                              .homeUserList.value[index].logo??"",width: 60,height: 60,),
                                         )  : Container(
                                           width: 60,
                                           height: 60,
                                           child: Image.asset("assets/profile.jpeg",width: 60,height: 60,),
                                         ),
                                      ),

                                      SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            homeScreenController
                                                    .homeUserList.value[index].title
                                                    .toString() ??
                                                "",
                                            // homeScreenController.userModel.value.title.toString()??"",
                                            style: TextStyle(
                                                fontFamily: 'MS Sans',
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Container(
                                            width: 260,
                                            height: 50,
                                            padding: new EdgeInsets.only(
                                                right: 13.0),
                                            child: Text(
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              homeScreenController.homeUserList.value[index].url
                                                      .toString() ??
                                                  "",
                                              // homeScreenController.userModel.value.url.toString()??"",
                                              overflow: TextOverflow.ellipsis,
                                              style: new TextStyle(
                                                fontFamily: 'MS Sans',
                                                fontSize: 12.0,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 25,
                                        color: Colors.black12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: AppColor.conrainer,
          child: Container(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scanQR();
                        editScreenController.title.clear();
                        editScreenController.category.clear();
                        editScreenController.image.value = File("");



                        // Get.toNamed(AppRouter.qrScannerPage);
                      },
                      child: Container(
                        width: 240,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, top: 5, bottom: 5, right: 10),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: [
                                  Image.asset("assets/home/camrera.png"),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "CAMERA SCAN".tr,
                                    style: TextStyle(
                                        fontFamily: 'MS Sans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      width: 84,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                        child: Center(
                          child: Image.asset("assets/home/gallery.png"),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
