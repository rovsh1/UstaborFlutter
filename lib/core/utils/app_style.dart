import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

const openSans = 'OpenSans';

class AppStyle {
  AppStyle._();

  static const baseStyle = TextStyle(
    color: AppColor.black,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: openSans,
  );
}
