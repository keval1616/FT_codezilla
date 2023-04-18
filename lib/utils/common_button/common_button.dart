import 'package:codezilla/utils/enum/enum.dart';
import 'package:codezilla/utils/text_style/text_style.dart';
import 'package:flutter/material.dart';


class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final ButtonType buttonType;

  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;

  const CommonAppButton({
    Key? key,
    this.onTap,
    this.buttonType = ButtonType.disable,
    this.text,
    this.color,
    this.icon,
    this.height,
    this.textColor,
    this.style,
    this.borderRadius,
    this.width,
    this.boxShadow,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color background = Colors.grey;
    switch (buttonType) {
      case ButtonType.enable:
        {
          background = Colors.blue;
        }
        break;
      case ButtonType.disable:
        {
          background = Colors.grey.withOpacity(0.5);
        }
        break;
      case ButtonType.progress:
        break;
    }
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
        onTap: (buttonType == ButtonType.enable) ? (onTap ?? () {}) : () {},
        child: Container(
          height: height ?? 60,
          width: width ?? 183,
          decoration: BoxDecoration(
            border: border,
            color: buttonType == ButtonType.disable
                ? Colors.transparent
                : Colors.blue,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),

                blurRadius: 6,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonType == ButtonType.progress)
                const CircularProgressIndicator(),
              if (buttonType != ButtonType.progress)
                Center(
                  child: Text(
                    text!,
                    style: style ??
                        const TextStyle(fontFamily: 'inter', fontSize: 17)
                            .textColor((buttonType == ButtonType.disable)
                            ? Colors.black45
                            : Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
