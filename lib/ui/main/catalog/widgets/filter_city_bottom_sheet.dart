import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'back_top.dart';

class FilterCityBottomSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalogController>(builder: (value) {
      return Container(
        height: Get.height - 50,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: BackTop(
                backPressed: () {
                  Get.back();
                },
                text: "choose_city".tr,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                physics: BouncingScrollPhysics(),
                itemCount: value.city.length,
                itemBuilder: (_, index) {
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      onTap: () {
                        value.setCity(value.city[index]);
                        Get.back();
                      },
                      title: Text(
                        value.city[index].name ?? "",
                        style: AppStyle.baseStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Visibility(
                        visible: value.city[index].id == value.currentCity?.id,
                        child: Icon(
                          Icons.done,
                          color: AppColor.green,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 16 + MediaQuery
                  .of(context)
                  .padding
                  .bottom,
            )
          ],
        ),
      );
    });
  }
}
