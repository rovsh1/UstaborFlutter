import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/ui/auth/widgets/sign_in_bottom_sheet.dart';
import 'package:usta_bor_android/ui/auth/widgets/sign_up_bottom_sheet.dart';

class GuestView extends StatelessWidget {
  final bool showSpacer;

  GuestView({this.showSpacer = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (showSpacer)
            Spacer(),
          Image.asset(
            "assets/png/hello.png",
            height: 80,
            width: 80,
          ),
          SizedBox(height: 32),
          Text(
            'welcome'.tr,
            textAlign: TextAlign.center,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
              fontSize: 22,
            ),
          ),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'guest_message'.tr,
              textAlign: TextAlign.center,
              style: AppStyle.baseStyle.copyWith(
                color: AppColor.black40,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 32),
          CustomButton(
            border: Border.all(color: AppColor.green, width: 2),
            backgroundColor: AppColor.white,
            fontColor: AppColor.green,
            onTap: () {
              Get.bottomSheet(
                SignInBottomSheet(),
                isScrollControlled: true,
                enableDrag: true,
              );
            },
            text: "come_in".tr,
          ),
          SizedBox(height: 24),
          CustomButton(
            onTap: () {
              Get.bottomSheet(
                SignUpBottomSheet(),
                isScrollControlled: true,
                enableDrag: true,
              );
            },
            text: "register".tr,
          ),
          if (showSpacer)
            SizedBox(
              height: 60,
            )
        ],
      ),
    );
  }
}
