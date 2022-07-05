import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/category_price_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_tabbar.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/prices/category_price/widgets/chart_tab.dart';
import 'package:usta_bor_android/ui/main/prices/category_price/widgets/master_tab.dart';

class CategoryPriceScreen extends GetView<CategoryPriceController> {
  final int categoryId;
  final int siteId;

  CategoryPriceScreen({required this.categoryId, required this.siteId});

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryPriceController(categoryId: categoryId, siteId: siteId));
    return GetBuilder<CategoryPriceController>(
      builder: (value) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leadingWidth: 68,
            leading: LeadingButton(),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(96),
              child: Column(
                children: [
                  Text(
                    value.result?.categoryName ?? '',
                    textAlign: TextAlign.center,
                    style: AppStyle.baseStyle.copyWith(
                      fontSize: 22,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CustomTabBar(
                    isScrollable: false,
                    controller: value.tabController,
                    tabs: List.generate(
                      2,
                      (index) => Tab(
                        child: AnimatedContainer(
                          height: 36,
                          duration: Duration(milliseconds: 100),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: buildItem(
                              isActive: index == value.tabController.index, text: value.tabTitle[index], icon: value.tabIcon[index], count: index == 1 ? value.catalogCount.toString() : ""),
                        ),
                      ),
                    ),
                    onTap: (index) {
                      value.update();
                    },
                  ),
                  Divider(
                    color: AppColor.grey100,
                    thickness: 1,
                    height: 1,
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              controller: controller.tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ChartTab(),
                MasterTab(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildItem({
    required bool isActive,
    required String text,
    required String icon,
    required String count,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          color: isActive ? AppColor.green : AppColor.grey30,
        ),
        SizedBox(
          width: 8,
        ),
        Text(text,
            style: AppStyle.baseStyle.copyWith(
              fontSize: 14,
              color: isActive ? AppColor.green : AppColor.black40,
            )),
        if (count.isNotEmpty)
          Container(
            margin: EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: AppColor.grey80,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6),
            height: 24,
            child: Center(
              child: Text(count,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 14,
                    color: AppColor.black40,
                  )),
            ),
          ),
      ],
    );
  }
}
