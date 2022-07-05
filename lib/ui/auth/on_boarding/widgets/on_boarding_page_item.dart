import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class OnBoardingPageItem extends StatelessWidget {
  const OnBoardingPageItem({
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
              width: 240,
              height: 240,
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
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 24),
          Text(
            subtitle.tr,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
              fontSize: 14,
            ),
            textAlign: TextAlign.left,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
