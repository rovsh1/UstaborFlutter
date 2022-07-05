import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class BuildCategoryField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(
      builder: (value) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            ('category_'.tr).replaceAll("*", ""),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
            ),
          ),
          SizedBox(height: 8),
          ExpandableNotifier(
            controller: value.controllerCategory,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      value.toggleCategory();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Ink(
                      height: 44,
                      padding: EdgeInsets.only(left: 14, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: value.currentCategoryError ? AppColor.red : AppColor.grey30, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width - 80,
                            child: Text(
                              value.currentCategory.name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.baseStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            size: 30,
                            color: AppColor.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expandable(
                  collapsed: SizedBox(),
                  controller: value.controllerCategory,
                  expanded: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 8),
                    height: value.category.length * 40 + 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(color: AppColor.grey30, width: 1),
                    ),
                    child: Column(
                      children: [
                        for (int index = 0; index < value.category.length; index++)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                value.setCategory(value.category[index]);
                              },
                              child: Ink(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 40,
                                  width: Get.width,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      value.category[index].name ?? '',
                                      maxLines: 2,
                                      style: AppStyle.baseStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
