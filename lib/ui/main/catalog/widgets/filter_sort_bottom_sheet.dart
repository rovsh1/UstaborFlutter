import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/sort.dart';
import 'back_top.dart';

class FilterSortBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalogController>(builder: (value) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 100 + MediaQuery.of(context).padding.bottom + sortData.length * 48,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: BackTop(
                backPressed: () {
                  Get.back();
                },
                text: "sort".tr,
              ),
            ),
            Spacer(),
            for (Sort sort in sortData)
              Material(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  onTap: () {
                    value.setSort(sort);
                    Get.back();
                  },
                  title: Text(
                    sort.name.tr,
                    style: AppStyle.baseStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  trailing: Visibility(
                    visible: sort == value.currentSort,
                    child: Icon(
                      Icons.done,
                      color: AppColor.green,
                    ),
                  ),
                ),
              ),
            Spacer(),
          ],
        ),
      );
    });
  }
}
