import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class CircleBackButton extends StatelessWidget {
  const CircleBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

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
              color: AppColor.blue.withOpacity(.2),
              offset: Offset(0, 6),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 3),
            child: SvgPicture.asset(
              "assets/svg/ic_back.svg",
              height: 14,
              width: 11,
            ),
          ),
        ),
      ),
    );
  }
}
