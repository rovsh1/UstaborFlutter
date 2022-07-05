import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_detail_response.dart';

class AddressTab extends StatelessWidget {
  final MyApplicationDetail applicationDetail;

  AddressTab({required this.applicationDetail});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'address'.tr,
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
              applicationDetail.address ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
        if (applicationDetail.addressNote != null && applicationDetail.addressNote!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                'landmark'.tr,
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
                    applicationDetail.addressNote ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.baseStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        SizedBox(height: 12),
        Text(
          'call_phone'.tr,
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
              applicationDetail.contactPhone ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
        if (applicationDetail.note != null && applicationDetail.note!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                'any_wishes'.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppStyle.baseStyle.copyWith(
                  color: AppColor.black40,
                ),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 14, right: 5, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.grey30, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    applicationDetail.note!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.baseStyle.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
