import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class UnselectedView extends StatelessWidget {
  const UnselectedView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColor.grey30,
      strokeWidth: 1,
      radius: Radius.circular(3),
      borderType: BorderType.RRect,
      dashPattern: [7, 5],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/svg/pick_image.svg'),
                TextButton(
                  onPressed: () {
                    Get.find<ApplicationController>().onPickImagePressed(ImageSource.camera);
                  },
                  child: Text(
                    'take_a_picture'.tr,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Text(
                  'or'.tr,
                  style: AppStyle.baseStyle,
                ),
                TextButton(
                  onPressed: () {
                    Get.find<ApplicationController>().onPickImagePressed(ImageSource.gallery);
                  },
                  child: Text(
                    'select_from_storage'.tr,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
