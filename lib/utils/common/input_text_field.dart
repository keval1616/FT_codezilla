import 'package:flutter/material.dart';

typedef OnValidation = dynamic Function(String? text);

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  final String hint;
  final Widget? suffixIcon;
  final Widget? icon;
  final Widget? prefixIcon;
  final OnValidation? validator;
  final Function(String?)? onChange;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final int? maxLine;
  const InputField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.obscureText = false,
    this.hint = "",
    this.icon,
    this.onChange,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction,
    this.keyboardType,
    this.validator,
    this.maxLine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),

              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: TextFormField(
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
          textAlign: TextAlign.justify,
          cursorColor: Colors.black,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          maxLines: maxLine,
          decoration: InputDecoration(
            border: InputBorder.none,
            icon: icon,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          textInputAction: textInputAction ?? TextInputAction.done,
          keyboardType: keyboardType ?? TextInputType.name,
          onChanged: (val) {
            if (onChange != null) {
              onChange!(val);
            }
          },
          validator: (val) {
            if (validator != null) {
              return validator!(val);
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
