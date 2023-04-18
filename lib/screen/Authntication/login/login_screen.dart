

import 'package:codezilla/app_route.dart';
import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/Authntication/login/login_controller.dart';
import 'package:codezilla/utils/common/input_text_field.dart';
import 'package:codezilla/utils/common_button/common_button.dart';
import 'package:codezilla/utils/enum/enum.dart';
import 'package:codezilla/utils/text_style/text_style.dart';
import 'package:codezilla/utils/validation/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginScreenController = Get.put(LoginScreenController());


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25, top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Get Started",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 102,
                    height: 102,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AppColor.lightpink,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),

                          blurRadius: 6,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputField(

                    icon: const Padding(
                      padding: EdgeInsets.only(left: 8.0,top: 8),
                      child: Icon(Icons.email),
                    ),
                    onChange: (val) {
                      loginScreenController.userEmailString.value = val ?? "";
                    },
                    controller: loginScreenController.userEmailController,
                    focusNode: loginScreenController.userEmailFocusNode,
                    hint: "Email",
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15.0),
                  Obx(
                        () => InputField(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 8.0,top: 8),
                        child: Icon(
                          Icons.password,
                          size: 20,
                        ),
                      ),
                      onChange: (val) {
                        loginScreenController.userPasswordString.value =
                            val ?? "";
                      },
                      maxLine: 1,
                      obscureText: !loginScreenController.showPass.value,
                      controller: loginScreenController.passwordController,
                      focusNode: loginScreenController.passwordFocusNode,
                      hint: "Password",
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          loginScreenController.showPass.value =
                          !loginScreenController.showPass.value;

                          if (mounted) {
                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            loginScreenController.showPass.value
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: () {
                            // Get.toNamed(AppRouter.forgetPassScreen);
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ))),
                  const SizedBox(height: 15.0),
                  Obx(
                        () => CommonAppButton(
                      buttonType: (loginScreenController
                          .userEmailString.value.isNotEmpty &&
                          loginScreenController
                              .userPasswordString.value.isNotEmpty &&
                          ValidationUtils.validateEmail(
                              loginScreenController.userEmailString.value))
                          ? ButtonType.enable
                          : ButtonType.disable,
                      borderRadius: 20,
                      onTap: () async {
                        loginScreenController.logInData();
                      },
                      text: "LOG IN",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                       Get.toNamed(AppRouter.registerScreen);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'New to atfaal game? ',
                        style: const TextStyle(fontFamily: 'poppins')
                            .textColor(Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Register',
                            style: const TextStyle(
                                fontFamily: 'poppins', fontSize: 15)
                                .textColor(Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
