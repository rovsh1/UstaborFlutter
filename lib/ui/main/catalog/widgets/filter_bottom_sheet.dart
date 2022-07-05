import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/filter_category_bottom_sheet.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/top.dart';
import 'filter_city_bottom_sheet.dart';
import 'filter_sort_bottom_sheet.dart';
import 'filter_district_bottom_sheet.dart';

class FilterBottomSheet extends GetView<CatalogController> {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalogController>(
      builder: (value) {
        return Container(
          height: 432 + MediaQuery.of(context).padding.bottom + (value.currentCity != null &&  value.currentCity!.id !=0 ? 64 : 0),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Top(title: 'filter'.tr,),
              Spacer(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      FilterCategoryBottomSheet(),
                      ignoreSafeArea: false,
                      enableDrag: false,
                      isScrollControlled: true,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Ink(
                    height: 48,
                    padding: EdgeInsets.only(left: 14, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grey30, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/filter_category.svg",
                          color: AppColor.green,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            value.currentCategory != null ? "${value.currentSite!.name}: ${value.currentCategory!.name}" : "all_category".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.baseStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset("assets/svg/arrow.svg",
                          height: 10,
                          color: AppColor.green,
                        ),
                        SizedBox(width: 8,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      FilterCityBottomSheet(),
                      ignoreSafeArea: false,
                      enableDrag: false,
                      isScrollControlled: true,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Ink(
                    height: 48,
                    padding: EdgeInsets.only(left: 14, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grey30, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/filter_city.svg",
                          color: AppColor.green,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            value.currentCity != null ? (value.currentCity!.name ?? "") : "all_city".tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.baseStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset("assets/svg/arrow.svg",
                          height: 10,
                          color: AppColor.green,
                        ),
                        SizedBox(width: 8,),
                      ],
                    ),
                  ),
                ),
              ),
              if (value.currentCity != null &&  value.currentCity!.id !=0 ) SizedBox(height: 16),
              if (value.currentCity != null &&  value.currentCity!.id !=0 )
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.bottomSheet(
                        FilterDistrictBottomSheet(),
                        ignoreSafeArea: false,
                        enableDrag: false,
                        isScrollControlled: true,
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Ink(
                      height: 48,
                      padding: EdgeInsets.only(left: 14, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.grey30, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/filter_district.svg",
                            color: AppColor.green,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              value.currentDistrict != null ? (value.currentDistrict?.name ?? "") : "all_district".tr,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.baseStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
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
              SizedBox(height: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      FilterSortBottomSheet(),
                      ignoreSafeArea: false,
                      enableDrag: false,
                      isScrollControlled: true,
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Ink(
                    height: 48,
                    padding: EdgeInsets.only(left: 14, right: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.grey30, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/filter_sort.svg",
                          color: AppColor.green,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            value.currentSort.name.tr,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.baseStyle.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset("assets/svg/arrow.svg",
                          height: 10,
                          color: AppColor.green,
                        ),
                        SizedBox(width: 8,),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              CustomButton(
                onTap: () {
                  print("TAAAP");
                  value.getCatalog();
               if( value.currentCategory!=null) value.setCatalogSelected(true);
                  Get.back();
                },
                text: "search".tr,
              ),
              SizedBox(
                height: 32,
              ),
              CustomButton(
                onTap: () {
                  value.setCatalogSelected (false);
                  value.clearFilter();
                },
                text: "clear".tr,
                fontColor: AppColor.grey90,
                backgroundColor: AppColor.white,
              ),
              SizedBox(
                height: 8 + MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        );
      },
    );
  }
}
