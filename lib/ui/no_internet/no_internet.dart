import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/size_config.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 100,
                color: AppColor.green.withOpacity(.8),
              ),
              SizedBox(height: SizeConfig.v * 5),
              Text(
                'no_internet_connection'.tr,
                textAlign: TextAlign.center,
                style: AppStyle.baseStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: SizeConfig.h * 3,
                  left: SizeConfig.h * 3,
                  top: SizeConfig.v * 2,
                  bottom: SizeConfig.v * 4,
                ),
                child: Text(
                  'no_internet_msg'.tr,
                  textAlign: TextAlign.center,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 14,
                    color: AppColor.black40.withOpacity(.6),
                  ),
                ),
              ),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.h * 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColor.green,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  'retry'.tr,
                  style: AppStyle.baseStyle.copyWith(
                    color: AppColor.green,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
