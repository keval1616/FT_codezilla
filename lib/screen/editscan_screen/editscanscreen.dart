import 'dart:convert';
import 'dart:io';

import 'package:codezilla/app_route.dart';
import 'package:codezilla/model/user_model.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/editscan_screen/editscreen_controller.dart';
import 'package:codezilla/screen/home/homeController.dart';
import 'package:codezilla/screen/home/homescreen.dart';
import 'package:codezilla/sevice/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class EditscanScreen extends StatefulWidget {
  String? link;

   EditscanScreen({Key? key, this.link}) : super(key: key);
  @override
  State<EditscanScreen> createState() => _EditscanScreenState();
}

class _EditscanScreenState extends State<EditscanScreen> {
  final editScreenController = Get.put(EditScreenController());
  final homeScreenController = Get.find<HomeScreenController>();
final UserModel userModel=Get.arguments[0];
  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editScreenController.title.text=userModel.title??'';
    widget.link = userModel.url??"";
    editScreenController.SelectCategories.value = userModel.category??"";
    editScreenController.saveIcon.value = userModel.logo??"";
    editScreenController.note.text = userModel.note??"";

  }




  Future getGalleryImage() async {
    final pickedFile = await editScreenController.picker
        .pickImage(source: ImageSource.gallery)
        .then((value) {
      setState(() {
        print(value!.path);
        if (value.path.isNotEmpty) {
          print("image selected");
          editScreenController.image = File(value.path);
        } else {
          print('No Image Selected');
        }
      });
    });
  }

  Future getCameraImage() async {
    final pickedFile = await editScreenController.picker
        .pickImage(source: ImageSource.camera)
        .then((value) {
      setState(() {
        print(value!.path);
        if (value.path.isNotEmpty) {
          print("image selected");
          editScreenController.image = File(value.path);
        } else {
          print('No Image Selected');
        }
      });
    });
  }

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
            // you can forcefully translate values left side using Transform
            transform:  Matrix4.translationValues(-20.0, 0.0, 0.0),
            child:  const Text(
              "Edit scan",
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
            child: FutureBuilder(

                builder: (ctx, snapshot) {
                  // if (snapshot.connectionState == ConnectionState.done) {
                  // if (snapshot.data!.isNotEmpty) {
                  //     editScreenController.url.text = snapshot.data![0].url??"";
                  //   editScreenController.title.text =
                  //       snapshot.data![0].title ?? "";
                  //   editScreenController.category.text =
                  //       snapshot.data![0].category ?? "";
                  //   editScreenController.note.text =
                  //       snapshot.data![0].note ?? "";
                  // }

                  return Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          width: 300,
                                          height: 40,
                                          padding: const EdgeInsets.only(
                                              right: 13.0),
                                          child: Text(
                                            widget.link ?? "",
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
                                    padding: const EdgeInsets.only(left: 15.0,right: 20),
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
                              child: Obx(()=>
                                  GestureDetector(
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
                                            child: editScreenController.SelectCategories.value.isNotEmpty?
                                            Text(editScreenController.SelectCategories.value):Text("Category"),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
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
                                        BottomSheetforimage(context);
                                      },
                                      child: Container(
                                        width: 106,
                                        height: 31,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: AppColor.buttonbaground,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
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
                                       SizedBox(width: 20,),
                                       Obx(()=>
                                         Container(
                                          width: 40,
                                          height: 40,

                                      child:editScreenController.saveIcon.value.isNotEmpty?
                                      Image.asset(editScreenController.saveIcon.value): Image.asset("assets/profile.jpeg"),
                                      ),
                                       ),

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
                                  contentPadding: EdgeInsets.only(top: 20),

                                  border: InputBorder.none,
                                  hintText: "Note",
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(left: 15.0,right: 20),
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
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:(){

                                    editScreenController.userList.remove(userModel);

                                    editScreenController.storedata();

                                  },
                                  child: Container(
                                    width: 151,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.deletbottoncolor,
                                    ),
                                    child: const Center(
                                        child: Text(
                                      "Delet",
                                      style:
                                      TextStyle(
fontFamily: 'DM Sans',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                SizedBox(width: 30,),
                                GestureDetector(
                                  onTap: (){

                                    editScreenController.userList.value.add(UserModel(
                                      url: widget.link,
                                        title: editScreenController.title.text,
                                        category: editScreenController.SelectCategories.value,
                                        note:editScreenController.note.text,
                                        logo:editScreenController.saveIcon.value,
                                      image: "assets/editscan/note.png",
                                       ));
                                    editScreenController.storedata();
                                    print("*********************MOODEL****************************${editScreenController.userList.value.first.url}");
                                    // Get.toNamed(AppRouter.homeScreen,arguments: [
                                    //   widget.link,editScreenController.title.text, editScreenController.SelectCategories.value , editScreenController.note.text, editScreenController.saveIcon.value
                                    // ]);
                                    // storedata();
                                    Get.toNamed(AppRouter.homeScreen);
                                  },
                                  child: Container(
                                    width: 151,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.blueAccent,
                                    ),
                                    child: const Center(
                                        child: Text(
                                      "Save",
                                      style: TextStyle(
                                          fontFamily: 'MS Sans',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                  // }
                  // return const Center(child: CircularProgressIndicator());
                }),
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
        return Expanded(
          child: Obx(
            () => Padding(
              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                              onTap: (){
                                editScreenController.SelectCategories.value = editScreenController.CategoriesList.elementAt(editScreenController.selectCategory.value);
                                print("=========category+++++++++++${editScreenController.SelectCategories.value}");
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    editScreenController.CategoriesList.length,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(()=>
                                       Container(
                                        child: Center(
                                            child: Column(

                                              mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  editScreenController.selectCategory.value = index;
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
                                                                  BorderRadius.circular(
                                                                      80),
                                                              border:
                                                                  Border.all(width: 1)),
                                                          child: Obx(()=>
                                                             Container(
                                                              width: 10,
                                                              height: 10,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius
                                                                      .circular(80),
                                                                  color:
                                                                      editScreenController
                                                                                  .selectCategory.value ==
                                                                              index
                                                                          ? Colors
                                                                              .blueAccent
                                                                          : Colors.white,
                                                                  border: Border.all(
                                                                      width: 1,
                                                                      color: Colors.white)),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        Text(
                                                          editScreenController
                                                              .CategoriesList[index],
                                                          style: const TextStyle(
                                                              color: Colors.black87,
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
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
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
                                                      BorderRadius.circular(10.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    Colors.black12, //<-- SEE HERE
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                editScreenController
                                                        .CategoriesList
                                                    .add(editScreenController
                                                        .newCategoryController
                                                        .text);
                                                FocusManager.instance.primaryFocus
                                                    ?.unfocus();
                                                editScreenController
                                                    .addCategory.value = false;
                                                editScreenController
                                                    .newCategoryController
                                                    .clear();
                                              },
                                              child: Text(
                                                "Save",
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
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
                                    editScreenController.addCategory.value = true;
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius: BorderRadius.circular(90),
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
                                            color: Colors.black87, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
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
                  child:Row(
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
                        onTap: (){
                          editScreenController.saveIcon.value = editScreenController.IconImageList.elementAt(editScreenController.selectIcon.value);
                          print("*************************${editScreenController.saveIcon.value}");


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
                  child: Column(
                    children: [
                      SizedBox(
                          height: 345,
                          child: GridView.builder(
                              itemCount: editScreenController.IconImageList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        editScreenController.selectIcon.value = index;

                                      });
                                      print("####index####$index");

                                    },
                                    child: Obx(()=>
                                      Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(

                                            border:editScreenController.selectIcon.value == index?
                                            Border.all(
                                                color:Colors.blueAccent,width: 3
                                            ): Border.all(
                                                color:Colors.white
                                            ),
                                            borderRadius: BorderRadius.circular(60),
                                          ),
                                          child: Image.asset(editScreenController
                                              .IconImageList[index].toString())),
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

  void BottomSheetforimage(BuildContext context) {
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
            height: 300,
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
                        "Image",
                        style: TextStyle(
                            fontFamily: 'MS Sans',
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      const Spacer(),
                      const Text(
                        "Done",
                        style: TextStyle(
                            fontFamily: 'MS Sans',
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await getCameraImage();
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/image/camera.png",
                                            width: 35,
                                            height: 35,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Text(
                                            "Camera",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await getGalleryImage();
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/image/gallery.png",
                                            width: 35,
                                            height: 35,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          const Text(
                                            "Gallery",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })),
                  ],
                ),
              ],
            ));
      },
    );
  }

  _launchURL() async {
    var url = widget.link.toString();
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';

    }
  }
}
