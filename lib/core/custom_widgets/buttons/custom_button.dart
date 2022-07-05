import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? fontColor;
  final String? text;
  final Function onTap;
  final double? width;
  final double? textSize;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxBorder? border;
  final List<BoxShadow>?  boxShadow;

  CustomButton({
    this.text = '',
    required this.onTap,
    this.backgroundColor = AppColor.green,
    this.fontColor = Colors.white,
    this.width = double.infinity,
    this.textSize = 16,
    this.height = 56,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: border,
          boxShadow: boxShadow,
      ),
      child: MaterialButton(
        color: backgroundColor,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        onPressed: () {
          onTap();
        },
        padding: EdgeInsets.all(0),
        child: Center(
          child: Text(
            text!,
            style: AppStyle.baseStyle.copyWith(
              color: fontColor,
              letterSpacing: 0.5,
              fontSize: textSize,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
