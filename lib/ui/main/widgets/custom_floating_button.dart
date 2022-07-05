import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 64,
        margin: EdgeInsets.only(top: 16),
        height: 64,
        decoration: BoxDecoration(
            gradient: AppColor.floatingBtnGradient,
            shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.add_rounded,
            color: AppColor.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}
