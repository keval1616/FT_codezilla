import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

// const _clientId =
//     "676041512066-fvrm1mavqj2ob61i34j3og82cjcjienf.apps.googleusercontent.com";
// const _scopes = ['https://www.googleapis.com/auth/drive.file'];

class _HomeScreenState extends State<HomeScreen> {
  final editScreenController = Get.put(EditScreenController());
  final homeScreenController = Get.find<HomeScreenController>();
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref("user");
  FirebaseService firebaseService = FirebaseService();
  List<UserModel> users = [];
  List<dynamic> data = [];
  List<CategoryModel> categorys = [];

  // var qrlink = Get.arguments[0];
  // var title = Get.arguments[1];
  // var categories = Get.arguments[2];
  // var note = Get.arguments[3];
  // var image = Get.arguments[4];
  String categoryName = "";

  @override
  void initState() {
    getUsers();
    // TODO: implement initState
    super.initState();

    print("--------datalist---------------${data}");
    // editScreenController.initalGetSavedData();
    //  SecureStorage();
    // GoogleDrive();
  }

  // final googleSignIn = GoogleSignIn.standard(scopes: [
  //   drive.DriveApi.driveAppdataScope,
  // ]);
  // Future<drive.DriveApi?> _getDriveApi() async {
  //   final googleUser = await googleSignIn.signIn();
  //   final headers = await googleUser?.authHeaders;
  //   if (headers == null) {

  //     await showMessage(context, "Sign-in first", "Error");
  //     return null;
  //   }

  //   final client = GoogleAuthClient(headers);
  //   final driveApi = drive.DriveApi(client);
  //   return driveApi;
  // }
  // Future<void> _uploadToHidden() async {
  //   try {
  //     final driveApi = await _getDriveApi();
  //     if (driveApi == null) {
  //       return;
  //     }
  //     // Not allow a user to do something else
  //     showGeneralDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       transitionDuration: Duration(seconds: 2),
  //       barrierColor: Colors.black.withOpacity(0.5),
  //       pageBuilder: (context, animation, secondaryAnimation) => Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //     );
  //   ...
  //   } finally {
  //   // Remove a dialog
  //   Navigator.pop(context);
  //   }
  // }
// final drive = GoogleDrive();
  bool navigate = true;

  Future _scanQR() async {
    var camerastatus = await Permission.camera.status;
    if (camerastatus.isGranted) {
      homeScreenController.cameraScanResult.value = (await scanner.scan())!;
      // Get.toNamed(
      //   AppRouter.editscanScreen,arguments: [EnumForButton.addScreen]
      // );
      Get.to(
        EditscanScreen(),
        // arguments: {
        //   "enumForButton": EnumForButton.addScreen,
        // },
      );
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => EditscanScreen(link: cameraScanResult)));
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        homeScreenController.cameraScanResult.value = (await scanner.scan())!;
      }
    }
  }

  getDataByCategory(int index) {
    // homeScreenController.homeUserList.value =
    //     editScreenController.userList
    //         .where((p0) =>
    //     p0.category?.toLowerCase() ==
    //         homeScreenController.categories[index].toLowerCase())
    //         .toList();
    // homeScreenController.homeUserList.refresh();
    // print(homeScreenController.homeUserList.value );

    homeScreenController.homeUserList.clear();
    if (index == 0) {
      homeScreenController.homeUserList.addAll(editScreenController.userList);
      homeScreenController.homeUserList.refresh();
    } else {
      homeScreenController.homeUserList.clear();
      for (int i = 0; i < editScreenController.userList.length; i++) {
        // print(editScreenController.userList[i].category);
        // print((homeScreenController.categories[j]));
        if (editScreenController.userList[i].category ==
            homeScreenController.categories[index]) {
          print("here");
          homeScreenController.homeUserList
              .add(editScreenController.userList[i]);
          print("==============>   ${homeScreenController.homeUserList}");
        }
      }
      homeScreenController.homeUserList.refresh();
    }
  }

  getDataByCategory1(int index) {
    // homeScreenController.homeUserList.value =
    //     editScreenController.userList
    //         .where((p0) =>
    //     p0.category?.toLowerCase() ==
    //         homeScreenController.categories[index].toLowerCase())
    //         .toList();
    // homeScreenController.homeUserList.refresh();
    // print(homeScreenController.homeUserList.value );

    homeScreenController.homeUserList.clear();
    if (index == 0) {
      homeScreenController.homeUserList.addAll(editScreenController.userList);
      homeScreenController.homeUserList.refresh();
    } else {
      homeScreenController.homeUserList.clear();
      for (int i = 0; i < editScreenController.userList.length; i++) {
        // print(editScreenController.userList[i].category);
        // print((homeScreenController.categories[j]));
        if (editScreenController.userList[i].category ==
            homeScreenController.categories[index]) {
          print("here");
          homeScreenController.homeUserList
              .add(editScreenController.userList[i]);
          print("==============>   ${homeScreenController.homeUserList}");
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
          children: [
            SizedBox(
              height: 20,
            ),

            Container(
              height: 50,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  UserModel userModel = users[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print(users);
                        setState(() {
                          categoryName = userModel.category!;
                          print(categoryName);
                        });



                        getDataByCategory(index);
                      },
                      child: Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              userModel.category ?? "",
                              style: TextStyle(
                                  fontFamily: 'MS Sans',
                                  fontSize: 14,
                                  color: homeScreenController
                                              .selectCategory.value ==
                                          index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color:
                              homeScreenController.selectCategory.value == index
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
            // SizedBox(height: 150,),
            // Image.asset("assets/home/blurbarcode.png",width: 200,height: 200,),
            // SizedBox(height: 50,),
            // Text("No data found, scan your first code",style: TextStyle(fontSize: 16),),

            Expanded(
              child: Container(
                child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: 5,
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

                            Get.to(EditscanScreen(
                              // enumForButton: EnumForButton.homescreen,
                              userModel: users[index],
                              // removeMap: index,
                            ));
                            //
                            Get.to(() => EditscanScreen(), arguments: {
                              'enumForButton': EnumForButton.homescreen,
                              // 'title': title,
                              // 'note': note,
                              // // 'cetegory': cetegory,
                              // 'logo': logo,
                              // 'image': image,
                              // 'docID': docID,
                              // 'url': url
                            });
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
    users = await firebaseService.getUsers();
    print("this is sssss=========${users}");
    Map<String, List<Map<String, dynamic>>> sortedData = sortData(users);

    print(users);
    categorys = await firebaseService.getCategory();
    setState(() {});
  }
}

Map<String, List<Map<String, dynamic>>> sortData(List<Map<String, dynamic>> data) {
  Map<String, List<Map<String, dynamic>>> sortedMap =<String, List<Map<String, dynamic>>>{};;

  for (var item in data) {
    String category = item['category'];

    if (sortedMap.containsKey(category)) {
      sortedMap[category]!.add(item);
    } else {
      sortedMap[category] = [item];
    }
  }

  sortedMap.forEach((key, value) {
    value.sort((a, b) => a['name'].compareTo(b['name']));
  });

  return sortedMap;
}