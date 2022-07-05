import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class BottomSheetMessage extends StatelessWidget {
  var text;

  BottomSheetMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColor.white90,
      ),
      child: Center(
        child: RichText(
         text: text,
          textAlign: TextAlign.center,

        ),
      ),
    );
  }
}
