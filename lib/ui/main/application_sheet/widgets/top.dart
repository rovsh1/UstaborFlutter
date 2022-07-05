import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

import 'circle_back_button.dart';
import 'circle_close_button.dart';

class Top extends StatelessWidget {
  final bool showBack;
  final Function? backPressed;

  Top({this.showBack = false, this.backPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: showBack
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: CircleBackButton(
                    onPressed: () {
                      backPressed!();
                    },
                  ),
                )
              : Container(),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              'order_service'.tr,
              textAlign: TextAlign.center,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 22,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.centerRight,
            child: CircleCloseButton(
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ],
    );
  }
}
