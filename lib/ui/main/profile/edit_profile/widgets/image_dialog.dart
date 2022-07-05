import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

Future<bool?> imageDialog() async {
  return await Get.defaultDialog(
    title: 'Ustabor',
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    titleStyle: AppStyle.baseStyle.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: AppColor.green,
    ),
    middleText: 'image_upload'.tr,
    middleTextStyle: AppStyle.baseStyle.copyWith(
      color: AppColor.black40,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
    actions: [
      MaterialButton(
        elevation: 0,
        minWidth: 120,
        height: 40,
        focusElevation: 0,
        highlightElevation: 0,
        onPressed: () {
          Get.back(result: true);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        color: AppColor.green,
        child: Text(
          'camera'.tr,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.white,
            fontSize: 14,
          ),
        ),
      ),
      MaterialButton(
        elevation: 0,
        height: 40,
        focusElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),
        minWidth: 120,
        color: AppColor.green,
        onPressed: () {
          Get.back(result: false);
        },
        child: Text(
          'gallery'.tr,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.white,
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
