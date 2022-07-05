import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/my_application_controller.dart';
import 'package:usta_bor_android/core/utils/api_constants.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_response.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_status.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_desription/my_application_detail_screen.dart';

class MyApplicationItem extends StatelessWidget {
  MyApplicationItem({
    Key? key,
    required this.application,
  }) : super(key: key);
  final MyApplication application;

  final controller = Get.find<MyApplicationController>();

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(application.created ?? "");
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      height: 188.0,
      width: Get.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.darkBlue.withOpacity(.2),
            offset: Offset(0, 6),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.circular(6.0),
        color: AppColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                margin: EdgeInsets.only(left: 16, right: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: application.status != 4 && application.status != 3 ? AppColor.green : AppColor.grey30,
                ),
                child: Center(
                  child: Text(
                    getApplicationStatus(application.status??0),
                    style: AppStyle.baseStyle.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 11,
                      color: AppColor.white,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text(
                "id".tr,
                style: AppStyle.baseStyle.copyWith(
                  color: application.status != 4 && application.status != 3 ? AppColor.green : AppColor.grey30,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                "${application.id?.toInt()}",
                style: AppStyle.baseStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              Spacer(),
              Text(
                "${"${date.day}".padLeft(2, "0")}.${"${date.month}".padLeft(2, "0")} ${date.year}",
                style: AppStyle.baseStyle.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Text(
                application.date == "today".tr ? " (${DateTime.now().day} ${DateTime.now().month})" : "",
                style: AppStyle.baseStyle.copyWith(color: AppColor.grey30, fontSize: 14),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              application.text ?? "",
              style: AppStyle.baseStyle.copyWith(
                fontSize: 18,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 16),
                width: application.masters!.length * 16 + 12,
                height: 28,
                child: Stack(
                  children: [
                    for (int index = 0; index < application.masters!.length; index++)
                      index != application.masters!.length - 1
                          ? Positioned(
                              top: 0,
                              bottom: 0,
                              left: index * 16,
                              child: Container(
                                height: 28.0,
                                width: 28.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(width: 2, color: AppColor.white),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: "https://www.${ApiConstants.url}/file/" + '${application.masters![index].icon ?? ""}/',
                                  imageBuilder: (context, imageProvider) => Container(
                                    width: 26.0,
                                    height: 26.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.person,
                                    color: AppColor.black40.withOpacity(.3),
                                    size: 16,
                                  ),
                                )
                              ),
                            )
                          : Positioned(
                              top: 0,
                              bottom: 0,
                              left: index * 16,
                              child: SizedBox(
                                height: 28.0,
                                width: 28.0,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Container(
                                        height: 28.0,
                                        width: 28.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(width: 2, color: AppColor.white),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: "https://www.${ApiConstants.url}/file/" + '${application.masters![index].icon ?? ""}/',
                                          imageBuilder: (context, imageProvider) => Container(
                                            width: 26.0,
                                            height: 26.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => CircularProgressIndicator(),
                                          errorWidget: (context, url, error) => Icon(
                                            Icons.person,
                                            color: AppColor.black40.withOpacity(.3),
                                            size: 16,
                                          ),
                                        )
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Visibility(
                                        visible: !(application.masters![index].flagViewed ?? true),
                                        child: Container(
                                          height: 12.0,
                                          width: 12.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.red,
                                            border: Border.all(width: 2, color: AppColor.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                application.masters!.isNotEmpty
                    ? '${application.masters!.length} ${'master'.trPlural("masters", application.masters!.length)}'
                    : ''.tr,
                style: AppStyle.baseStyle,
              ),
            ],
          ),
          Spacer(),
          Divider(
            height: .5,
            color: AppColor.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 16, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.to(()=>MyApplicationDetailScreen(
                      application: application,
                    ));
                  },
                  child: SvgPicture.asset(
                    "assets/svg/subtract.svg",
                    height: 28.0,
                    width: 24.0,
                    color: application.documents!.isNotEmpty ? AppColor.green : AppColor.grey30,

                  ),
                ),

                // FlatButton(
                //   onPressed: () {
                //     Get.to(MyApplicationDetailScreen(
                //       application: application,
                //     ));
                //   },
                //   child: SvgPicture.asset(
                //     "assets/svg/subtract.svg",
                //     height: 28.0,
                //     width: 24.0,
                //     color: application.documents!.isNotEmpty ? AppColor.green : AppColor.grey30,
                //
                //   ),
                // ),

                TextButton(
                  onPressed: () {
                    Get.to(()=>MyApplicationDetailScreen(
                      application: application,
                    ));
                  },
                  child: Text(
                    application.status != 4 ? "more".tr : "dany".tr,
                    style: AppStyle.baseStyle.copyWith(
                      color: application.status != 4 ? AppColor.green : AppColor.grey30,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      controller.popUpMenuChoiceHandler(value, application);
                    },
                    elevation: 10.0,
                    padding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    offset: Offset(12, -12),
                    color: AppColor.white,
                    itemBuilder: (context) => controller
                        .actionsOptions(application.status != 3 && application.status != 4)
                        .map(
                          (choice) => PopupMenuItem<String>(
                            padding: EdgeInsets.all(0),
                            value: choice['value'],
                            child: Container(
                              width: 180,
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                leading: SvgPicture.asset(
                                  choice['icon']!,
                                  color: AppColor.grey30,
                                ),
                                minLeadingWidth: 8,
                                title: Text(
                                  choice['title']!,
                                  style: AppStyle.baseStyle.copyWith(
                                    color: AppColor.black40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getApplicationStatus(int status) {
    switch (MyApplicationStatus.values[status]) {
      case MyApplicationStatus.WAITING:
        return "waiting".tr;
      case MyApplicationStatus.VIEWED:
        return "viewed".tr;
      case MyApplicationStatus.PROCESSED:
        return "processed".tr;
      case MyApplicationStatus.CANCELLED:
        return "closed".tr;
    }
  }
}
