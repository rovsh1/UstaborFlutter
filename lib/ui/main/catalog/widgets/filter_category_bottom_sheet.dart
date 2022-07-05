import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'back_top.dart';

class FilterCategoryBottomSheet extends StatelessWidget {

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
                text: "choose_category".tr,
              ),
            ),
            Container(
              height: 36,
              margin: EdgeInsets.only(top: 24),
              padding: EdgeInsets.only(left: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                separatorBuilder: (_, index) {
                  return SizedBox(
                    width: 8,
                  );
                },
                itemCount: value.site.length,
                itemBuilder: (_, index) {
                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        value.setSite(value.site[index]);

                      },
                      borderRadius: BorderRadius.circular(45),
                      child: Ink(
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                            color: AppColor.green,
                            width: 2,
                          ),
                          color: value.currentSite?.id == value.site[index].id ? AppColor.green : AppColor.white,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(
                              child: Text(
                                value.site[index].name ?? '',
                                style: AppStyle.baseStyle.copyWith(
                                  color: value.currentSite?.id == value.site[index].id ? AppColor.white : AppColor.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                physics: BouncingScrollPhysics(),
                itemCount: value.category.length,
                itemBuilder: (_, index) {
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      onTap: () {
                        value.setCategory(value.category[index]);
                        Get.back();
                      },
                      minLeadingWidth: 8,
                      leading: CachedNetworkImage(
                        imageUrl: value.category[index].icon ?? '',
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.sort),
                        height: 28,
                        width: 28,
                      ),
                      trailing: Visibility(
                        visible: value.category[index].id == value.currentCategory?.id,
                        child: Icon(
                          Icons.done,
                          color: AppColor.green,
                        ),
                      ),
                      title: Text(
                        value.category[index].name ?? "",
                        style: AppStyle.baseStyle.copyWith(
                          fontSize: 18,
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
