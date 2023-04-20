import 'dart:io';

import 'package:codezilla/app_route.dart';
import 'package:codezilla/firebase_helper.dart';
import 'package:codezilla/model/categorymodel.dart';
import 'package:codezilla/model/user_model.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/editscan_screen/editscanscreen.dart';
import 'package:codezilla/screen/editscan_screen/editscreen_controller.dart';
import 'package:codezilla/screen/home/homeController.dart';
import 'package:codezilla/utils/enum/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'package:sqflite/sqlite_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final editScreenController = Get.put(EditScreenController());
  final homeScreenController = Get.find<HomeScreenController>();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref("user");
  FirebaseService firebaseService = FirebaseService();
  List<UserModel> users = [];
  List<dynamic> data = [];
  List<CategoryModel> categorys = [];
  String categoryName = "";
  String myKey = "";

  @override
  void initState() {
    // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    myKey = "All";

    getUsers();
    // });
    // TODO: implement initState
    super.initState();
  }

  bool navigate = true;

  Future _scanQR() async {
    var camerastatus = await Permission.camera.status;
    if (camerastatus.isGranted) {
      homeScreenController.cameraScanResult.value = (await scanner.scan())!;

      Get.to(
        EditscanScreen(
          enumForButton: EnumForButton.addScreen,
        ),
      );
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        homeScreenController.cameraScanResult.value = (await scanner.scan())!;
      }
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
              onPressed: () async {
                logOutDialogue(context);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),

            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: homeScreenController.categoryList.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // String key = sortedItems.keys.elementAt(index);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              selectedIndex = index;
                              setState(() {});

                              myKey = homeScreenController
                                      .categoryList[index].category ??
                                  "";
                              print(myKey);
                              sortByCategory(key: myKey);
                            },
                            child: Container(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    homeScreenController
                                            .categoryList[index].category ??
                                        "",
                                    style: TextStyle(
                                        fontFamily: 'MS Sans',
                                        fontSize: 14,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Colors.blueAccent
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 150,),
            // Image.asset("assets/home/blurbarcode.png",width: 200,height: 200,),
            // SizedBox(height: 50,),
            // Text("No data found, scan your first code",style: TextStyle(fontSize: 16),),

            Expanded(
              child: Container(
                child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: users.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      UserModel user = users[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12, top: 7, bottom: 7),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) =>  EditscanScreen(
                            //     title: snapshot.data?.docs[index].data()['title']
                            //   )),
                            // );

                            Get.to(
                              EditscanScreen(
                                userModel: users[index],
                                enumForButton: EnumForButton.homescreen,
                                // removeMap: index,
                              ),
                            );
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
                                      onTap: () {},
                                      child:
                                          //    ClipRRect(
                                          // borderRadius:
                                          // BorderRadius.circular(59),
                                          // child: snapshot.data!.docs[index]["image"]?
                                          // Image.file(
                                          //   File(
                                          //     snapshot.data!.docs[index]["image"] ??
                                          //         "",
                                          //   ),
                                          //   height: 60,
                                          //   width: 60,
                                          //   fit: BoxFit.cover,
                                          //   alignment:
                                          //   Alignment.topCenter,
                                          // ):
                                          Container(
                                        width: 60,
                                        height: 60,
                                        child: Image.asset(
                                          "assets/profile.jpeg",
                                          width: 60,
                                          height: 60,
                                        ),
                                      )
                                      //     :snapshot.data!.docs[index]["logo"]!.isNotEmpty
                                      //     ? Container(
                                      //   width: 60,
                                      //   height: 60,
                                      //   child: Image.asset(
                                      //     snapshot.data!.docs[index]["logo"] ??
                                      //         "",
                                      //     width: 60,
                                      //     height: 60,
                                      //   ),
                                      // )
                                      //     : Container(
                                      //   width: 60,
                                      //   height: 60,
                                      //   child: Image.asset(
                                      //     "assets/profile.jpeg",
                                      //     width: 60,
                                      //     height: 60,
                                      //   ),
                                      // ),
                                      ),
                                  // ),
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
                                        user.title ?? "",
                                        // homeScreenController.homeUserList
                                        //     .value[index].title
                                        //     .toString() ??
                                        //     "",
                                        // homeScreenController.userModel.value.title.toString()??"",
                                        style: TextStyle(
                                            fontFamily: 'MS Sans',
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Container(
                                        width: 200,
                                        height: 50,
                                        padding:
                                            new EdgeInsets.only(right: 13.0),
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          user.url ?? "",
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
                                  Spacer(),
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
                      );
                    }),
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
                        width: 230,
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
                    Spacer(),
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

  logOutDialogue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: const Text(
          "Are you sure you want to Logout?",
        ),
        title: const Text(
          "CodeZilla",
        ),
        actions: [
          CupertinoButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "No",
            ),
          ),
          CupertinoButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
              print("user Sign out");
              Get.offAllNamed(AppRouter.splashScreen);
            },
            child: const Text(
              "Yes",
            ),
          ),
        ],
      ),
    );
  }

  void getUsers() async {
    users.clear();
    sortedItems.clear();
    homeScreenController.categoryList.clear();

    // homeScreenController.categoryList.forEach((element) {
    //   if (element == CategoryModel(category: "All") ||
    //       element == CategoryModel(category: "Restaurants") ||
    //       element == CategoryModel(category: "Website Url") ||
    //       element == CategoryModel(category: "Business Card") ||
    //       element == CategoryModel(category: "Wifi") ||
    //       element == CategoryModel(category: "Email")) {
    //     homeScreenController.categoryList.remove(element);
    //   }
    // });
    users = await firebaseService.getUsers();
    users.forEach((item) {
      if (!sortedItems.containsKey(item.category)) {
        sortedItems[item.category!] = [];
      }
      sortedItems[item.category]!.add(item.toJson());
    });
    setState(() {});
    // users.clear();

    for (int i = 0; i <= sortedItems.keys.length; i++) {
      if (i == 0) {
        homeScreenController.categoryList
            .insert(0, CategoryModel(category: "All"));
      }else{
        homeScreenController.categoryList.insert(i,
            CategoryModel(category: sortedItems.keys.toList(growable: false)[i-1]));
      };
      // else if (i == 1) {
      //   homeScreenController.categoryList
      //       .insert(1, CategoryModel(category: "Restaurants"));
      // } else if (i == 2) {
      //   homeScreenController.categoryList
      //       .insert(2, CategoryModel(category: "Website Url"));
      // } else if (i == 3) {
      //   homeScreenController.categoryList
      //       .insert(3, CategoryModel(category: "Business Card"));
      // } else if (i == 4) {
      //   homeScreenController.categoryList
      //       .insert(4, CategoryModel(category: "Wifi"));
      // } else {
      //   homeScreenController.categoryList
      //       .insert(5, CategoryModel(category: "Email"));
      // }
    }
    // for (int i = 0; i <= sortedItems.keys.length; i++) {
    //   homeScreenController.categoryList.insert(i + 6,
    //       CategoryModel(category: sortedItems.keys.toList(growable: false)[i]));
    //   setState(() {});
    // }

    sortByCategory(key: myKey);

    setState(() {});
  }

  sortByCategory({String? key}) {
    if (key == "All") {
      users.clear();
      sortedItems.forEach((key, value) {
        value.forEach((element) {
          users.add(UserModel.fromJson(element));
        });
      });
    } else if (!(key == "All")) {
      if (sortedItems.containsKey(key)) {
        users.clear();
        List<Map<String, dynamic>>? list = sortedItems[key];
        for (int i = 0; i < list!.length; i++) {
          users.add(UserModel.fromJson(list[i]));
        }
        print(users);
        setState(() {});
      }
    } else {}
    setState(() {});
  }
}

Map<String, List<Map<String, dynamic>>> sortedItems = {};
