import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

import '../../../auth/widgets/sign_in_bottom_sheet.dart';
import '../../../auth/widgets/sign_up_bottom_sheet.dart';

class LoginBottomSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
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
        ],
      ),
    );
  }
}
