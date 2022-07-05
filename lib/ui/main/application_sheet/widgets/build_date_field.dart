import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/application_create/date.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:get/get.dart';

class BuildDateField extends StatelessWidget {
  @override

  List<ApplicationDateData> dates = [
    ApplicationDateData(
      id: "0_3",
      text: "0_3".tr,
    ),
    ApplicationDateData(
      id: "3_6",
      text: "3_6".tr,
    ),
    ApplicationDateData(
      id: "6_9",
      text: "6_9".tr,
    ),
    ApplicationDateData(
      id: "9_12",
      text: "9_12".tr,
    ),
    ApplicationDateData(
      id: "12_15",
      text: "12_15".tr,
    ),
    ApplicationDateData(
      id: "15_18",
      text: "15_18".tr,
    ),
    ApplicationDateData(
      id: "18_21",
      text: "18_21".tr,
    ),
    ApplicationDateData(
      id: "21_24",
      text: "21_24".tr,
    ),
  ];


  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(
      builder: (value) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12),
          Text(
            'time_'.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
            ),
          ),
          SizedBox(height: 8),
          ExpandableNotifier(
            controller: value.controllerDate,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      value.toggleDate();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Ink(
                      height: 44,
                      padding: EdgeInsets.only(left: 14, right: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: value.currentDateError? AppColor.red: AppColor.grey30, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width - 80,
                            child: Text(
                              value.currentDate.text,
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
                  controller: value.controllerDate,
                  expanded: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 8),
                    height: dates.length * 40 + 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(color: AppColor.grey30, width: 1),
                    ),
                    child: Column(
                      children: [
                        for (int index = 0; index < dates.length; index++)
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                value.setDate(dates[index]);
                              },
                              child: Ink(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  height: 40,
                                  width: Get.width,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      dates[index].text,
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
