

import 'package:codezilla/app_route.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/editscan_screen/editscanscreen.dart';
import 'package:codezilla/screen/home/homeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeScreenController = Get.put(HomeScreenController());
  bool navigate = true;

  Future _scanQR() async {
    var camerastatus = await Permission.camera.status;
    if(camerastatus.isGranted){
      String? cameraScanResult = await scanner.scan();
      print("****************************$cameraScanResult");
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (context) =>
              EditscanScreen(
                  link: cameraScanResult)));


    }else {
      var isGrant = await Permission.camera.request();
      if(isGrant.isGranted){
        String? cameraScanResult = await scanner.scan();
        print(cameraScanResult);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColor.conrainer,
      appBar: AppBar(
        leadingWidth: 40,
        centerTitle: false,

        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset("assets/home/codezilla.png",width: 15,height: 15,),
        ),
        elevation: 0,
        backgroundColor: AppColor.conrainer,
        title: Text("CodeZilla Wallet",style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search,color: Colors.black,),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert,color: Colors.black,),
          ),
        ],


      ),
      body: Column(

        children: [
          SizedBox(height: 20,),
Container(
  height: 50,
  child:   ListView.builder(

    shrinkWrap: true,
    itemCount: homeScreenController.Categories.length,
      physics: BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(


          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(homeScreenController.Categories[index]),
          )),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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
                  shrinkWrap: true,
                  itemCount: 100,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Colors.white,
                       ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: Image.asset("assets/icon/icon9.png",width: 60,height: 60,),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90),

                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Text("KFC Menu",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),

                                  Container(
                                    width: 230,
                                    height: 60,
                                    padding: new EdgeInsets.only(right: 13.0),
                                    child: Text(
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      'https://www.figma.com/file/VYXmVYfqWOExryQYXOA8hB/QR-Menu-(Copy)?node-id=126%3A154&t=f706OTpGbgGPI2dB-0',
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                        fontSize: 13.0,
                                        fontFamily: 'Roboto',
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios_outlined,size: 25,color: Colors.black12,)
                            ],
                          ),
                        ),
                      ),
                    );
                  }
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
                  onTap: (){
                    _scanQR();
                    // Get.toNamed(AppRouter.qrScannerPage);
                  },
                  child: Container(
                    width: 200,
                    height: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 5,bottom: 5),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset("assets/home/camrera.png"),
                            SizedBox(width: 15,),
                            Text("CAMERA SCAN",style: TextStyle(color: Colors.white),)

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 50,),
                Container(
                  width: 100,
                  height: 67,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    border: Border.all(width: 0.4)
                  ),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 5,top: 5,bottom: 5),
                    child: Center(
                      child:
                          Image.asset("assets/home/gallery.png"),

                    ),
                  ),
                )
              ],
            ),
          )

        ),
      ),
    );
  }
}
