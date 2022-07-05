import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class TopText extends StatelessWidget {
  const TopText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 28, left: 32, right: 32),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppStyle.baseStyle.copyWith(
            fontSize: 14,
            color: AppColor.black40,
          ),
        ),
      ),
    );
  }
}
