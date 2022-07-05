import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/category_price_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/money_format.dart';

class ChartTab extends StatelessWidget {
  const ChartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryPriceController>(builder: (value) {
      return ModalProgressHUD(
        inAsyncCall: value.loading,
        color: Colors.transparent,
        child: value.result != null
            ? ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            Container(
                height: 360,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.darkBlue.withOpacity(.2),
                      offset: Offset(0, 6),
                      blurRadius: 24,
                      spreadRadius: 0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    SizedBox(
                      height: 240,
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  formatMoney(value.minPrice, withSum: false),
                                  style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColor.green,
                                  ),
                                ),
                                Text(
                                  "min_price".tr,
                                  style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: AppColor.black40,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: (Get.width - 120) / 3,
                                  height: (value.minPrice / value.maxPrice * 190) == 0? 2: (value.minPrice / value.maxPrice * 190),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColor.green,
                                          AppColor.green.withOpacity(0),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  formatMoney(value.averagePrice, withSum: false),
                                  style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColor.green,
                                  ),
                                ),
                                Text(
                                  "average_price".tr,
                                  style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: AppColor.black40,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: (Get.width - 120) / 3,
                                  height: value.averagePrice / value.maxPrice * 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColor.green,
                                          AppColor.green.withOpacity(0),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Spacer(),
                                Text(
                                  formatMoney(value.maxPrice, withSum: false),
                                  style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: AppColor.green,
                                  ),
                                ),
                                Text(
                                  "max_price".tr,
                                  style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: AppColor.black40,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: (Get.width - 120) / 3,
                                  height: 190,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColor.green,
                                          AppColor.green.withOpacity(0),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Divider(
                            color: AppColor.grey,
                            height: 1,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 30,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.green,
                            ),
                            child: Text(
                              'middle_price'.tr,
                              style: AppStyle.baseStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Text(
                        '${formatMoney(76224)} - ${formatMoney(131225)}',
                        style: AppStyle.baseStyle.copyWith(
                          color: AppColor.black40,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 32),
            Text(
              "price_service".tr,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (int index = 0; index < (value.result?.prices?.length ?? 0); index++)
              Container(
                height: 32,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  minLeadingWidth: 0,
                  title: Text(
                    value.result?.prices?[index].name ?? '',
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                    "${'from'.tr} ${formatMoney(double.parse((value.result?.prices?[index].price ?? '0.0').toString()))}",
                    maxLines: 1,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40
                    ),
                  ),
                ),
              ),
          ],
        )
            : SizedBox(),
      );
    });
  }
}
