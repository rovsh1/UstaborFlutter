import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/auth/auth_screen.dart';

Future<void> logoutDialog() async {
  await Get.defaultDialog(
    title: 'Ustabor',
    titleStyle: AppStyle.baseStyle.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: AppColor.green,
    ),
    middleText: 'do_you_want_to_log_out'.tr,
    middleTextStyle: TextStyle(
      color: AppColor.black40.withOpacity(.7),
      fontSize: 14,
    ),
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          'no'.tr,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.red.withOpacity(.7),
            fontSize: 14,
          ),
        ),
      ),
      TextButton(
        onPressed: () async {
          await LocalSource.getInstance.removeStorage();
          await Get.offAll(() => AuthScreen());
        },
        child: Text(
          'yes'.tr,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.green,
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
