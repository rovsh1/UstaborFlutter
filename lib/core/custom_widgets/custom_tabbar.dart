import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class CustomTabBar extends StatelessWidget {
  final TabController? controller;
  final List<Widget> tabs;
  final Function(int index)? onTap;
  final bool isScrollable;

    CustomTabBar({
    Key? key,
    this.controller,
    required this.tabs,
    this.onTap,
    this.isScrollable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: isScrollable,
      controller: controller,
      labelColor: AppColor.white,
      unselectedLabelColor: AppColor.black,
      labelStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColor.white,
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: AppColor.green,
      indicatorWeight: 2,
      tabs: tabs,
      onTap: onTap,
    );
  }
}
