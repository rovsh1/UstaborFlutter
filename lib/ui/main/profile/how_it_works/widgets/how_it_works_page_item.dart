import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class HowItWorksPageItem extends StatelessWidget {
  const HowItWorksPageItem({
    Key? key,
    required this.imgPath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String imgPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(
            flex: 2,
          ),
          Center(
            child: Image.asset(
              imgPath,
              width: Get.height < 641 ? 160 : 200,
              height: Get.height < 641 ? 160 : 200,
              fit: BoxFit.cover,
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Text(
            title.tr,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 24),
          Text(
            subtitle.tr,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
              fontSize: Get.height < 641 ? 12: 14,
            ),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
