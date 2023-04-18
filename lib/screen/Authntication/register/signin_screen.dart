import 'package:codezilla/schema/app_colors.dart';
import 'package:codezilla/screen/Authntication/register/signin_controller.dart';
import 'package:codezilla/utils/common/input_text_field.dart';
import 'package:codezilla/utils/common_button/common_button.dart';
import 'package:codezilla/utils/enum/enum.dart';
import 'package:codezilla/utils/validation/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerScreenController = Get.put(RegisterScreenController());


  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25),
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
                    color: AppColor.bgColor,
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
                  maxLine: 1,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 8.0,top: 8),
                    child: Icon(Icons.person),
                  ),
                  onChange: (val) {
                    registerScreenController.userNameString.value = val ?? "";
                  },
                  controller: registerScreenController.userNameController,
                  focusNode: registerScreenController.userNameFocusNode,
                  hint: "Name",
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  maxLine: 1,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 8.0,top: 8),
                    child: Icon(Icons.email),
                  ),
                  onChange: (val) {
                    registerScreenController.userEmailString.value = val ?? "";
                  },
                  controller: registerScreenController.userEmailController,
                  focusNode: registerScreenController.userEmailFocusNode,
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
                      registerScreenController.userPasswordString.value =
                          val ?? "";
                    },
                    maxLine: 1,
                    obscureText: !registerScreenController.showPass.value,
                    controller: registerScreenController.passwordController,
                    focusNode: registerScreenController.passwordFocusNode,
                    hint: "Password",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        registerScreenController.showPass.value =
                        !registerScreenController.showPass.value;

                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(
                          registerScreenController.showPass.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
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
                      registerScreenController.confirmPasswordString.value =
                          val ?? "";
                    },
                    maxLine: 1,
                    obscureText:
                    !registerScreenController.confirmShowPass.value,
                    controller:
                    registerScreenController.confirmPasswordController,
                    focusNode:
                    registerScreenController.confirmPasswordFocusNode,
                    hint: "Confirm Password",
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        registerScreenController.confirmShowPass.value =
                        !registerScreenController.confirmShowPass.value;

                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Icon(
                          registerScreenController.confirmShowPass.value
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Obx(
                      () => CommonAppButton(
                    buttonType: (registerScreenController
                        .userEmailString.value.isNotEmpty &&
                        ValidationUtils.validateEmail(
                            registerScreenController
                                .userEmailString.value) &&
                        registerScreenController
                            .userNameString.value.isNotEmpty &&
                        registerScreenController
                            .confirmPasswordString.value.isNotEmpty &&
                        (registerScreenController
                            .userPasswordString.value ==
                            registerScreenController
                                .confirmPasswordString.value))
                        ? ButtonType.enable
                        : ButtonType.disable,
                    borderRadius: 20,
                    onTap: () async {
                      registerScreenController.signUpData();
                    },
                    text: "Register",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
