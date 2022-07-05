import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class CircleButtonUnColored extends StatelessWidget {
  const CircleButtonUnColored({
    Key? key,
    required this.onPressed,
    required this.isRight,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isRight;

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
            )
          ],
        ),
        child: Icon(
          isRight ? Icons.arrow_right : Icons.arrow_left,
          color: AppColor.grey,
          size: 26,
        ),
      ),
    );
  }
}
