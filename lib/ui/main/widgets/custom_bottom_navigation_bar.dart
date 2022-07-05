import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:get/get.dart';
import 'custom_bottom_nav_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return BottomAppBar(
          elevation: 10,
          color: Colors.white,
          child: Container(
            height: 60,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: CustomBottomNavBarItem(
                    isActive: controller.index == 0,
                    activeIcon: 'assets/svg/catalog_act.svg',
                    icon: 'assets/svg/catalog.svg',
                    label: 'catalogue'.tr,
                    onPressed: () {
                      controller.setIndex(0);
                    },
                  ),
                ),
                Expanded(
                  child: CustomBottomNavBarItem(
                    isActive: controller.index == 1,
                    activeIcon: 'assets/svg/prices_act.svg',
                    icon: 'assets/svg/prices.svg',
                    label: 'prices'.tr,
                    onPressed: () {
                      controller.setIndex(1);
                    },
                  ),
                ),
                Expanded(child: Container()),
                Expanded(
                  child: CustomBottomNavBarItem(
                    isActive: controller.index == 2,
                    activeIcon: 'assets/svg/zayavki_act.svg',
                    icon: 'assets/svg/zayavki.svg',
                    label: 'my_order'.tr,
                    onPressed: () {
                      controller.setIndex(2);
                    },
                  ),
                ),
                Expanded(
                  child: CustomBottomNavBarItem(
                    isActive: controller.index == 3,
                    activeIcon: 'assets/svg/master_act.svg',
                    icon: 'assets/svg/master.svg',
                    label: 'menu'.tr,
                    onPressed: () {
                      controller.setIndex(3);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
