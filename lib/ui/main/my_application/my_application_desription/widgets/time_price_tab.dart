import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/money_format.dart';
import 'package:usta_bor_android/data/model/application_create/date.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_detail_response.dart';

class TimePriceTab extends StatelessWidget {
  final MyApplicationDetail applicationDetail;

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


  TimePriceTab({required this.applicationDetail});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'work_time'.tr,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.black40,
          ),
        ),
        SizedBox(height: 8),
        Text(
          getDate(),
          style: AppStyle.baseStyle.copyWith(fontSize: 14),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),
        Text(
          'enter_time'.tr,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.black40,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 48,
          padding: EdgeInsets.only(left: 14, right: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey30, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              dates.firstWhere((element) => element.id == applicationDetail.time).text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'self_sum'.tr,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: AppStyle.baseStyle.copyWith(
            color: AppColor.black40,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 48,
          padding: EdgeInsets.only(left: 14, right: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grey30, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              applicationDetail.price!= 0? formatMoney(applicationDetail.price ?? ''): "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getDate() {
    String text = '';
    final dateTime = DateTime.now();
    switch (applicationDetail.date) {
      case "today":
        text =  "${'today'.tr}  (${dateTime.day} ${'${dateTime.month}'.tr})";
        break;
      case "tomorrow":
        text = "${'tomorrow'.tr}  (${dateTime.add(Duration(days: 1)).day} ${'${dateTime.month}'.tr})";
        break;
      case "master":
        text = "wait_master".tr;
        break;
      case "in_week":
        text = "in_week".tr;
        break;
    }
    return text;
  }
}
