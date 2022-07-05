import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/auth/auth_screen.dart';

Future<void> updateDialog( BuildContext context,
 VersionStatus versionStatus) async {
  await Get.defaultDialog(
    title: 'update'.tr,
    titleStyle: AppStyle.baseStyle.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: AppColor.green,
    ),
    middleText: 'update_body'.tr,
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
          'cancel_update_button'.tr,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.red.withOpacity(.7),
            fontSize: 14,
          ),
        ),
      ),
      TextButton(
        onPressed: () async {
          launch(versionStatus.appStoreLink);
        },
        child: Text(
          'update_button'.tr,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.green,
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
