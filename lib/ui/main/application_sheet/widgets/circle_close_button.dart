import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class CircleCloseButton extends StatelessWidget {
  const CircleCloseButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColor.darkBlue.withOpacity(.2),
              offset: Offset(0, 6),
              blurRadius: 24,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.close,
            color: AppColor.black,
            size: 19,
          ),
        ),
      ),
    );
  }
}
