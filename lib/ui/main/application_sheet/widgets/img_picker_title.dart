import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class ImgPickerTitle extends StatelessWidget {
  const ImgPickerTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'add_photo_message'.tr,
            style: AppStyle.baseStyle.copyWith(
              fontSize: 14,
            ),
          ),
          TextSpan(
            text: ' (' + 'unnecessary'.tr + ')',
            style: AppStyle.baseStyle.copyWith(
              fontSize: 12,
              color: AppColor.black40.withOpacity(.7),
            ),
          ),
        ],
      ),
    );
  }
}
