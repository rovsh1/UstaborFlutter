import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class CustomIconButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? fontColor;
  final String? text;
  final String iconPath;
  final Function onTap;
  final double? width;
  final double? textSize;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxBorder? border;

  CustomIconButton({
    this.text = '',
    required this.onTap,
    required this.iconPath,
    this.backgroundColor = AppColor.green,
    this.fontColor = Colors.white,
    this.width = double.infinity,
    this.textSize = 15,
    this.height = 56,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.border,
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
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: border,
      ),
      child: MaterialButton(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        onPressed: () {
          onTap();
        },
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              color: fontColor,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              text!,
              style: TextStyle(
                color: fontColor,
                letterSpacing: 0.5,
                fontSize: textSize,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
