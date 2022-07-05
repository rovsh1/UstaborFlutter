import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/price_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'category_price/category_price_screen.dart';

class PricesScreen extends GetView<PriceController> {

  PriceController controller = Get.find<PriceController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PriceController>(
      builder: (value) {
        return ModalProgressHUD(
          inAsyncCall: value.loading,
          color: Colors.transparent,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: Container(
                height: 36,
                margin: EdgeInsets.only(top: 64),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      width: 8,
                    );
                  },
                  padding: EdgeInsets.only(left: 16),
                  itemCount: value.site.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                       // controller.getSite();
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
                    );
                  },
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: value.category.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    onTap: () {
                      Get.to(()=>
                        CategoryPriceScreen(
                          categoryId: value.category[index].id ?? 0,
                          siteId: value.currentSite?.id==0 ? value.category[index].siteId??0 : value.currentSite?.id ?? 0,
                        ),
                      );
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 32),
                    minLeadingWidth: 8,
                    leading: CachedNetworkImage(
                      imageUrl: value.category[index].icon ?? '',
                      height: 28,
                      width: 28,
                    ),
                    title: Text(
                      value.category[index].name ?? "",
                      style: AppStyle.baseStyle.copyWith(
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
