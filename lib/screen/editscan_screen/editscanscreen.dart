import 'dart:convert';
import 'dart:io';
import 'package:codezilla/app_route.dart';
import 'package:codezilla/model/categorymodel.dart';
import 'package:codezilla/model/user_model.dart';
import 'package:codezilla/model/userdatamodel.dart';
import 'package:codezilla/pref/app_Prefrance.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/editscan_screen/editscreen_controller.dart';
import 'package:codezilla/screen/home/homeController.dart';
import 'package:codezilla/utils/enum/enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditscanScreen extends StatefulWidget {
  // RxString qrcodelink = link.obs;
// String? title;
   UserModel? userModel;
//   DataModel? dataModel;
//   int? removeMap;


  EditscanScreen({Key? key,this.userModel})
      : super(key: key);

  @override
  State<EditscanScreen> createState() => _EditscanScreenState();
}

class _EditscanScreenState extends State<EditscanScreen> {
  final editScreenController = Get.put(EditScreenController());
  final homeScreenController = Get.find<HomeScreenController>();
  late DatabaseReference dbRef;

  get pickedFile => pickedFile;
  int argumentOfIndex = 0;

  // int getcategories(){
  //   int index=homeScreenController.categories.indexWhere((element) => element .contains(widget.userModel!.category));
  // return index;
  // }

  @override
  void initState() {
    // print("================================${widget.title}");
    // print("================================${editScreenController.title.text = widget.title??""}");
    // editScreenController.image.value.path == null;
    // TODO: implement initState
    super.initState();
    print("------argumrnt----${widget.userModel?.title}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (Get.arguments['enumForButton'] == EnumForButton.homescreen) {
        // editScreenController.selectCategory.value = getcategories();
        editScreenController.title.text = widget.userModel?.title??"";
        editScreenController.note.text = widget.userModel?.note??"";
        editScreenController.SelectCategories.value =
            Get.arguments['cetegory']?? "";
        homeScreenController
            .cameraScanResult.value = widget.userModel?.url??"";
        editScreenController
            .image.value = File("${Get.arguments['image']??""}");
        editScreenController.saveIcon.value = "${Get.arguments['logo']??""}";

      // }
    });

  }





  // final UserModel argument = Get.arguments[0];

  // final int enumbutton = Get.arguments[2];
  // final int argumentOfIndex = Get.arguments[1]!=null?Get.arguments[1]:0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        editScreenController.addCategory.value == false;
      },
      child: Scaffold(
        backgroundColor: AppColor.conrainer,
        appBar: AppBar(
          backgroundColor: AppColor.conrainer,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.blueAccent,
                size: 30,
              )),
          title: Transform(
            transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
            child:

            Text(
              // Get.arguments["enumForButton"]==EnumForButton.homescreen?
              // "Edit scan":
              "Add Scan",
              style: TextStyle(
                  fontFamily: 'MS Sans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87),
            ),
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: SingleChildScrollView(
              child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL();
                },
                child: Container(
                  width: context.width,
                  height: 112,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Code",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'MS Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Container(
                                  width: context.width / 1.5,
                                  height: 40,
                                  padding: const EdgeInsets.only(right: 13.0),
                                  child: Text(
                                    homeScreenController
                                            .cameraScanResult.value ??
                                        "",
                                    textAlign: TextAlign.start,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13.0,
                                      fontFamily: 'Roboto',
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const Text(
                                  "Open Url",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Image.asset(
                                  "assets/home/barcode.png",
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: context.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: editScreenController.title,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 20),
                          border: InputBorder.none,
                          hintText: "Title",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 20, top: 10),
                            child: Image.asset(
                              "assets/editscan/title.png",
                              width: 17,
                              height: 23,
                            ),
                          )),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Obx(
                        () => GestureDetector(
                          onTap: () {
                            BottomSheetforcategory(context);
                          },
                          child: Container(
                            height: 40,
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/editscan/cetagery.png",
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: editScreenController
                                          .SelectCategories.value.isNotEmpty
                                      ? Text(editScreenController
                                          .SelectCategories.value)
                                      : Text("Category"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                        height: 50,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/home/gallery.png",
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                BottomSheetforicon(context);
                              },
                              child: Container(
                                width: 106,
                                height: 31,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.buttonbaground,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.black12,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text("Select Icon"),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "or",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showBottomSheetForImage(context);
                              },
                              child: Container(
                                width: 106,
                                height: 31,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.buttonbaground,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.black12,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    const Text("Add Image"),

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            // editScreenController.pickImage()
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    TextField(
                      controller: editScreenController.note,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 12),
                          border: InputBorder.none,
                          hintText: "Note",
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 20,
                            ),
                            child: Image.asset(
                              "assets/editscan/note.png",
                              width: 24,
                              height: 24,
                            ),
                          )),
                    ),
                    const Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 20,
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // if(Get.arguments["enumForButton"]==EnumForButton.homescreen)
                            GestureDetector(

                              onTap: () {
                                // editScreenController.userList
                                //     .removeAt(widget.removeMap!);
                                // homeScreenController.homeUserList
                                //     .remove(argument);

                                // editScreenController.storedata();
                                Get.back();
                              },
                              child: Container(
                                width: 148,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColor.deletbottoncolor,
                                ),
                                child: const Center(
                                    child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                            Spacer(),
                            // Get.arguments[2] == EnumForButton.homescreen
                            //     ?

                            // Get.arguments["enumForButton"] == EnumForButton.addScreen?
                            GestureDetector(
                                onTap: () {
                                  // editScreenController.userList.add(UserModel(
                                  //   url: homeScreenController.cameraScanResult.value ??"",
                                  //   title: editScreenController.title.text,
                                  //   category: editScreenController.SelectCategories.value,
                                   
                                  //   logo: editScreenController.saveIcon.value,
                                  //   image:
                                  //       editScreenController.image.value.path ??
                                  //           "",
                                  // ));
                                  // editScreenController.storedata();
                                  // Map<String, String> users = {
                                  //   'category': editScreenController.SelectCategories.value,
                                  //   // 'salary': userSalaryController.text
                                  //   "image": editScreenController.image.value.path ??"",
                                  // };

                                  // dbRef.push().set(users);

                                    var note = editScreenController.note.text.trim();
                                    var title =  editScreenController.title.text.trim();
                                    var logo= editScreenController.saveIcon.value??"";
                                    var image = editScreenController.image.value.path ??"";
                                  var category = editScreenController.SelectCategories.value;
                                  var url = homeScreenController.cameraScanResult.value ??"";
;                                    addItem(title,note,category,logo,image,url);
Get.toNamed(AppRouter.homeScreen);


                                      // "*********************MOODEL****************************${editScreenController.userList.value.first.url}");
                                  // Get.toNamed(AppRouter.homeScreen,arguments: [
                                  //   widget.link,editScreenController.title.text, editScreenController.SelectCategories.value , editScreenController.note.text, editScreenController.saveIcon.value
                                  // ]);
                                  // storedata();
                                  // Get.back();
                                },
                                child:
                                    // enumbutton == EnumForButton.homescreen ?
                                    Container(
                                  width: 148,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.blueAccent,
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "save",
                                    style: TextStyle(
                                        fontFamily: 'MS Sans',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ))
                            // : GestureDetector(
                            //     onTap: () {
                            //       var note = editScreenController.note.text.trim();
                            //       var title =  editScreenController.title.text.trim();
                            //       var logo= editScreenController.saveIcon.value??"";
                            //       var image = editScreenController.image.value.path ??"";
                            //       var category = editScreenController.SelectCategories.value;
                            //       var url = homeScreenController.cameraScanResult.value ??"";
                            //       UpdateItem(title,note,category,logo,image,url);
                            //       print("---------${note}");
                            //       print("---------${title}");
                            //       print("---------${logo}");
                            //       print("---------${image}");
                            //       print("---------${category}");
                            //
                            //       // editScreenController.userList
                            //       //     .removeAt(widget.removeMap!);
                            //       // editScreenController.userList.value
                            //       //     .add(UserModel(
                            //       //   url: homeScreenController
                            //       //           .cameraScanResult.value ??
                            //       //       "",
                            //       //   title: editScreenController.title.text,
                            //       //   category: editScreenController
                            //       //       .SelectCategories.value,
                            //       //   note: editScreenController.note.text,
                            //       //   logo:
                            //       //       editScreenController.saveIcon.value,
                            //       //   image: editScreenController
                            //       //           .image.value.path ??
                            //       //       "",
                            //       // ));
                            //       // editScreenController.storedata();
                            //       // print(
                            //       //     "*********************MOODEL****************************${editScreenController.userList.value.first.url}");
                            //       // Get.toNamed(AppRouter.homeScreen,arguments: [
                            //       //   widget.link,editScreenController.title.text, editScreenController.SelectCategories.value , editScreenController.note.text, editScreenController.saveIcon.value
                            //       // ]);
                            //       // storedata();
                            //       Get.back();
                            //     },
                            //     child:
                            //         // enumbutton == EnumForButton.homescreen ?
                            //         Container(
                            //       width: 148,
                            //       height: 48,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(15),
                            //         color: Colors.blueAccent,
                            //       ),
                            //       child: const Center(
                            //           child: Text(
                            //         "update",
                            //         style: TextStyle(
                            //             fontFamily: 'MS Sans',
                            //             color: Colors.white,
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.bold),
                            //       )),
                            //     ))
                          ]),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          )
              // }
              // return const Center(child: CircularProgressIndicator());

              ),
        ),
      ),
    );
  }

  void BottomSheetforcategory(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(

                decoration: const BoxDecoration(

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        children: [
                          const Text(
                            "Category",
                            style: TextStyle(
                                fontFamily: 'MS Sans',
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {

                              editScreenController.SelectCategories.value =
                                  homeScreenController.categories.elementAt(
                                      editScreenController
                                          .selectCategory.value);
                              var selectcategory = editScreenController.SelectCategories.value;
                              AddCategory(selectcategory);
                              print(
                                  "=========category+++++++++++${editScreenController.SelectCategories.value}");
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                  fontFamily: 'MS Sans',
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  homeScreenController.categories.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => Container(

                                      child: Center(
                                          child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                editScreenController
                                                    .selectCategory
                                                    .value = index;
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 25,
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      80),
                                                          border: Border.all(
                                                              width: 1)),
                                                      child: Obx(
                                                        () => Container(
                                                          width: 10,
                                                          height: 10,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          80),
                                                              color: editScreenController
                                                                          .selectCategory
                                                                          .value ==
                                                                      index
                                                                  ? Colors
                                                                      .blueAccent
                                                                  : Colors
                                                                      .white,
                                                              border: Border.all(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      homeScreenController
                                                          .categories[index],
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black87,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                      decoration: BoxDecoration(

                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: editScreenController.addCategory.value ==
                                    true
                                ? Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            border: Border.all(width: 1)),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Container(
                                        width: 200,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: TextField(
                                          controller: editScreenController
                                              .newCategoryController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0),
                                            ),
                                            filled: true,
                                            fillColor: Colors
                                                .black12, //<-- SEE HERE
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            if (kDebugMode) {
                                              print(
                                                  "=========================================================ok");
                                            }
                                            homeScreenController.categories
                                                .add(editScreenController
                                                    .newCategoryController
                                                    .text);


                                            AppPref().catList = json.encode(
                                                homeScreenController
                                                    .categories);

                                            FocusManager
                                                .instance.primaryFocus
                                                ?.unfocus();
                                            editScreenController
                                                .addCategory.value = false;
                                            // homeScreenController.categories
                                            //     .refresh();
                                            editScreenController
                                                .newCategoryController
                                                .clear();
                                          },
                                          child: Text(
                                            "Update",
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.bold),
                                          ))
                                    ],
                                  )
                                : Container(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 10, bottom: 50),
                          child: GestureDetector(
                            onTap: () {},
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                                editScreenController.addCategory.value =
                                    true;
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                          BorderRadius.circular(90),
                                    ),
                                    child: const Center(
                                        child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text(
                                    "Add a new category",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  void BottomSheetforicon(BuildContext context) {
    showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 440,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      const Text(
                        "Icon",
                        style: TextStyle(
                            fontFamily: 'MS Sans',
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          editScreenController.saveIcon.value =
                              editScreenController.IconImageList.elementAt(
                                  editScreenController.selectIcon.value);
                          print(
                              "*************************${editScreenController.saveIcon.value}");

                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Done",
                          style: TextStyle(
                              fontFamily: 'MS Sans',
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                          height: 345,
                          child: GridView.builder(
                              itemCount:
                                  editScreenController.IconImageList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        editScreenController.selectIcon.value =
                                            index;
                                      });
                                      print("####index####$index");
                                    },
                                    child: Obx(
                                      () => Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: editScreenController
                                                        .selectIcon.value ==
                                                    index
                                                ? Border.all(
                                                    color: Colors.blueAccent,
                                                    width: 3)
                                                : Border.all(
                                                    color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(60),
                                          ),
                                          child: Image.asset(
                                              editScreenController
                                                  .IconImageList[index]
                                                  .toString())),
                                    ),
                                  ),
                                );
                              })),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  Future<dynamic> showBottomSheetForImage(BuildContext context) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      context: context,
      backgroundColor: AppColor.lightYellow,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Select Source",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    await editScreenController.getImage(ImageSource.camera);
                    Get.back();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.bgColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.camera_alt),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await editScreenController.getImage(ImageSource.gallery);
                    Get.back();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.bgColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.photo),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
addItem(String title, String note, String category, String logo, String image, String url){
    var item = DataModel(title:title,note:note,category: category, logo: logo, image: image, url: url);
    print(item.toJson());
    print(FirebaseAuth.instance.currentUser!.uid);
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('qrs').add(item.toJson()).then((DocumentReference doc)
    {


    });

}
  AddCategory(String category ){
    var item = CategoryModel(category: category);
    print(item.toJson());
    print(FirebaseAuth.instance.currentUser!.uid);
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('category').add(item.toJson()).then((DocumentReference doc){});

  }
  UpdateItem(String title, String note, String category, String logo, String image, String url){
    var updateitem = DataModel(title:title,note:note,category: category, logo: logo, image: image, url: url);
    print(updateitem.toJson());
    print(FirebaseAuth.instance.currentUser!.uid);
    Future<void> updateUserData (Map<String, dynamic>values)async{
      String id = values['id'];
    }
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('qrs').doc(Get.arguments['docID']).update(updateitem.toJson());
    print("---------------------------------${    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('qrs').doc(FirebaseAuth.instance.currentUser!.getIdToken() as String?).update(updateitem.toJson())
        }");

  }


  _launchURL() async {
    var url = homeScreenController.cameraScanResult.value.toString();
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}

