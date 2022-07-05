import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

callDialog(String? phoneNumber) async {
  if (phoneNumber == null) {
    await Get.defaultDialog(
      title: 'Ustabor',
      titleStyle: AppStyle.baseStyle.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: AppColor.green,
      ),
      middleText: 'master_phone_number_no'.tr,
      middleTextStyle: AppStyle.baseStyle.copyWith(
        color: AppColor.black40.withOpacity(.7),
        fontSize: 14,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'ok'.tr,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.green,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  } else {
    await Get.defaultDialog(
      title: phoneNumber,
      titleStyle: AppStyle.baseStyle.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppColor.green,
      ),
      middleText: 'do_you_want_call_master'.tr,
      middleTextStyle: AppStyle.baseStyle.copyWith(
        color: AppColor.black40.withOpacity(.7),
        fontSize: 14,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'close'.tr,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.red.withOpacity(.7),
              fontSize: 14,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            Get.back();
            try {
              await launch('tel:' + phoneNumber);
            } catch (e) {
              print(e);
            }
          },
          child: Text(
            'call'.tr,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.green,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
