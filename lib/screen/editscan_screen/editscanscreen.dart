import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/editscan_screen/editscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditscanScreen extends StatefulWidget {
  const EditscanScreen({Key? key}) : super(key: key);

  @override
  State<EditscanScreen> createState() => _EditscanScreenState();
}

class _EditscanScreenState extends State<EditscanScreen> {
  final editScreenController = Get.put(EditScreenController());

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.conrainer,
        appBar: AppBar(
          backgroundColor: AppColor.conrainer,
          leading: GestureDetector(
              onTap: (){Get.back();},
              child: Icon(Icons.arrow_back_sharp,color: Colors.blueAccent,size: 38,)),
          title: Text("Edit scan",style: TextStyle(color: Colors.black87),),
          centerTitle: false,
          elevation: 0,
        ),
       body: Padding(
         padding: const EdgeInsets.only(left: 12.0,right: 12),
         child: Column(

           children: [
             Container(
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
                             Text(
                               "Code",textAlign:TextAlign.start,style: TextStyle(color: Colors.black87,fontSize: 16,fontWeight: FontWeight.bold),),
                             SizedBox(height: 7,),
                             new Container(

                               width: 300,
                               height: 60,
                               padding: new EdgeInsets.only(right: 13.0),
                               child: new Text(
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
                         Spacer(),
                         Column(
                           children: [
                             Text("Open Url",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),),
                             SizedBox(height: 10,),
                             Image.asset("assets/home/barcode.png",width: 35,height: 35,)
                           ],
                         )


                       ],

                     ),
                   ],
                 ),
               ),
             ),
             SizedBox(height: 15,),

             Container(
               width: context.width,

             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10),
             ),
               child: Column(
                 children: [
                   TextField(

                     decoration: InputDecoration(
                         border: InputBorder.none,
                         hintText: "Title",
                       prefixIcon: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Image.asset("assets/editscan/title.png",width: 10,height: 10,),
                       )
                     ),
                   ),
                   Divider(
                     thickness: 0.5,
                     color: Colors.grey,
                   ),

                   Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: GestureDetector(
                       onTap: (){
                         BottomSheetforcategory(context);
                       },

                       child: Row(
                         children: [
                           Image.asset("assets/editscan/cetagery.png",width: 35,height: 35,),
                           SizedBox(width: 16,),
                           Text("Category")
                         ],
                       ),
                     ),
                   ),
                   Divider(
                     thickness: 0.5,
                     color: Colors.grey,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: Row(

                       children: [

                         Image.asset("assets/home/gallery.png",width: 35,height: 35,),
                         SizedBox(width: 16,),
                         GestureDetector(
                           onTap: (){
                             BottomSheetforicon(context);
                           },
                           child: Container(
                             width: 120,
                             height: 40,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color:AppColor.buttonbaground,
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   width: 15,
                                   height: 15,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(2),
                                     color: Colors.black12,
                                   ),
                                   child: Icon(Icons.add,color: Colors.white,size: 14,),
                                 ),
                                 SizedBox(width: 5,),
                                 Text("Select Icon"),

                               ],
                             ),
                           ),
                         ),
                         SizedBox(width: 10,),
                         Text("or",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 15),),
                         SizedBox(width: 10,),
                         GestureDetector(
                           onTap: (){
                             BottomSheetforimage(context);
                           },
                           child: Container(
                             width: 120,
                             height: 40,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color:AppColor.buttonbaground,
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   width: 15,
                                   height: 15,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(2),
                                     color: Colors.black12,
                                   ),
                                   child: Icon(Icons.add,color: Colors.white,size: 14,),
                                 ),
                                 SizedBox(width: 5,),
                                 Text("Select Image"),

                               ],
                             ),
                           ),
                         ),

                       ],
                     ),
                   ),
                   Divider(
                     thickness: 0.5,
                     color: Colors.grey,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left: 12.0),
                     child: Row(
                       children: [
                         Image.asset("assets/editscan/note.png",width: 35,height: 35,),
                         SizedBox(width: 16,),
                         Text("Note")
                       ],
                     ),
                   ),
                   Divider(
                     thickness: 0.5,
                     color: Colors.grey,
                   ),
                   SizedBox(height: 20,),

                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         width: 151,
                         height: 48,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: AppColor.deletbottoncolor,
                         ),
                         child: Center(child: Text("Delet",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                       ),
                       SizedBox(width: 20,),
                       Container(
                         width: 151,
                         height: 48,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: Colors.blueAccent,
                         ),
                         child: Center(child: Text("save",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                       ),
                     ],
                   ),
                   SizedBox(height: 20,),

                 ],
               ),
             )
           ],
         ),
       ),
      ),
    );
  }
  void BottomSheetforcategory(BuildContext context) {
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

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30) ),
        ),
        child:Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text("Category",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),),
                 Spacer(),
                  Text("Done",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),

                ],
              ),

            ),
            SizedBox(height: 20,),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
          height: 345,
          child:   ListView.builder(

          shrinkWrap: true,
          itemCount: editScreenController.Categories.length ,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
          return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(


          child: Center(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      border: Border.all(width: 1)
                    ),
                    child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            color: Colors.blueAccent,
                            border: Border.all(width: 1,color: Colors.white)
                        ),
                  ),
                  ),
                  SizedBox(width: 20,),
                  Text(editScreenController.Categories[index],style: TextStyle(color: Colors.black87,fontSize: 15),),
                ],
              )
            ],
          ),
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
                ],
              ),
            ),
          ],

        )
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

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30) ),
            ),
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Text("Icons",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),),
                      Spacer(),
                      Text("Done",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),

                    ],
                  ),

                ),
                SizedBox(height: 20,),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 345,
                        child:  GridView.builder(
                          itemCount: editScreenController.IconImage.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 10,
                              crossAxisSpacing: 10
                               ),
                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: editScreenController.IconImage[index]
                                ),
                              );
                            }

                        )
                      ),
                    ],
                  ),
                ),
              ],

            )
        );
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

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30) ),
            ),
            child:Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    children: [
                      Text("Icons",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),),
                      Spacer(),
                      Text("Done",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold,fontSize: 20),),

                    ],
                  ),

                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Container(
                        height: 200,
                        child:  ListView.builder(
                            itemCount: 1,

                            itemBuilder: (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Row(
                                  children: [
Image.asset("assets/image/camera.png",width: 35,height: 35,),
                                    SizedBox(width: 15,),
                                    Text("Camera",style: TextStyle(color: Colors.black,fontSize: 18,),)
                                  ],
                                ),
                                    SizedBox(height: 15,),
                                    Row(
                                      children: [
                                        Image.asset("assets/image/gallery.png",width: 35,height: 35,),
                                        SizedBox(width: 15,),
                                        Text("Gallery",style: TextStyle(color: Colors.black,fontSize: 18,),)
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }

                        )
                    ),
                  ],
                ),
              ],

            )
        );
      },
    );
  }
}


