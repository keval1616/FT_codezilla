import 'package:codezilla/screen/Authntication/forogtpassword/forgotpassword_controller.dart';
import 'package:codezilla/utils/common/input_text_field.dart';
import 'package:codezilla/utils/common_button/common_button.dart';
import 'package:codezilla/utils/enum/enum.dart';
import 'package:codezilla/utils/validation/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final forgetPasswordController = Get.put(ForgetPasswordController());



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
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25),
          child: Column(
            children: [
              Text(
                "Forget Password",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              InputField(
                maxLine: 1,
                icon: const Padding(
                  padding: EdgeInsets.only(left: 8.0,top: 8),
                  child: Icon(Icons.email),
                ),
                onChange: (val) {
                  forgetPasswordController.userEmailString.value = val ?? "";
                },
                controller: forgetPasswordController.userEmailController,
                focusNode: forgetPasswordController.userEmailFocusNode,
                hint: "Email",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15,
              ),
              Obx(
                    () => CommonAppButton(
                  buttonType: (forgetPasswordController
                      .userEmailString.value.isNotEmpty &&
                      ValidationUtils.validateEmail(
                          forgetPasswordController.userEmailString.value))
                      ? ButtonType.enable
                      : ButtonType.disable,
                  borderRadius: 20,
                  onTap: () async {
                    forgetPasswordController.resetPassword(context);
                  },
                  text: "Send",
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
