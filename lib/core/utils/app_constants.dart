import 'dart:ui';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'package:get/get.dart';

class AppConstants {
  AppConstants._();
  static String getBadgeName(int index) {
    switch (index) {
      case 5:
        return '24/7'.tr;
      case 6:
        return 'badge_emergency'.tr;
      default:
        return '';
    }
  }

  static Color getBadgeColor(int index) {
    switch (index) {
      case 5:
        return AppColor.green;
      case 6:
        return AppColor.lightRed;
      default:
        return Colors.transparent;
    }
  }

  static final applicationIcons = [
    'assets/svg/lighting.svg',
    'assets/svg/tick.svg',
    'assets/svg/like.svg',
  ];
}