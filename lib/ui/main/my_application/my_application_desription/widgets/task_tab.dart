import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_detail_response.dart';

class TaskTab extends StatelessWidget {
  final MyApplicationDetail applicationDetail;

  TaskTab({required this.applicationDetail});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      physics: BouncingScrollPhysics(),
      children: [
        Text(
          'site'.tr,
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
              applicationDetail.siteName ?? '',
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
          'category'.tr,
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
              applicationDetail.categoryName ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ),
        if (applicationDetail.serviceId != null && applicationDetail.services!.isNotEmpty)
          for (int i = 0; i < applicationDetail.services!.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  i ==0 ? 'service_'.tr: applicationDetail.services![i - 1].question??'',
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
                      applicationDetail.services![i].name??'',
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
        if (applicationDetail.documents!.isNotEmpty)
          Column(
            children: [
              SizedBox(height: 12),
              Text(
                'image_work'.tr,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppStyle.baseStyle.copyWith(
                  color: AppColor.black40,
                ),
              ),
              SizedBox(height: 8),
              for (var doc in applicationDetail.documents!)
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: doc.href ?? "",
                      height: 240,
                      width: Get.width - 32,
                      fit: BoxFit.cover,
                      placeholder: (_, __) {
                        return Container(
                          height: 240,
                          width: Get.width - 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.green,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: AppColor.black40.withOpacity(.3),
                            ),
                          ),
                        );
                      },
                      errorWidget: (_, __, ___) {
                        return Container(
                          height: 240,
                          width: Get.width - 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.green,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image,
                              color: AppColor.black40.withOpacity(.3),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        if (applicationDetail.note != null && applicationDetail.note!.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12),
              Text(
                'more_info'.tr,
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
                    applicationDetail.text!,
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
