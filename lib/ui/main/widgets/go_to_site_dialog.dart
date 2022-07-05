import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usta_bor_android/core/utils/api_constants.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

Future<void> goToSiteDialog() async {
  await Get.defaultDialog(
    title: '${ApiConstants.url}',
    titleStyle: AppStyle.baseStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColor.green,
    ),
    middleText: 'do_you_want_to_go_website_msg'.tr,
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
            color: Colors.red.withOpacity(.7),
            fontSize: 14,
          ),
        ),
      ),
      TextButton(
        onPressed: () async {
          Get.back();
          try {
            await launch(
              'https://www.${ApiConstants.url}/howitworks/',
              forceSafariVC: false,
              forceWebView: false,
            );
          } catch (e) {
            print(e);
          }
        },
        child: Text(
          'go_to_the_site'.tr,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.green,
            fontSize: 14,
          ),
        ),
      ),
    ],
  );
}
