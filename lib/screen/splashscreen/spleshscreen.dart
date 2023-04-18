



import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/splashscreen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
              () => AnimatedOpacity(
            opacity: splashScreenController.visible.isTrue ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 3000),
            child: Stack(
              children: [
                Container(
                    width: context.width,
                    height:context.height,
                    child: Image.asset(
                        "assets/home/homescreen.png",
                        fit: BoxFit.contain,
                        alignment: Alignment.centerRight
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
