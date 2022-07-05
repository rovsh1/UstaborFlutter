import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
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
        width:40,
        height:40,
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
        child: Center(
          child: Padding(
            padding:  EdgeInsets.only(left: isRight? 3: 0, right: isRight? 0: 3),
            child: SvgPicture.asset(
              isRight ? "assets/svg/ic_right.svg" : "assets/svg/ic_left.svg",
              color: AppColor.green,
              width: 9,
              height: 12,
            ),
          ),
        ),
      ),
    );
  }
}
