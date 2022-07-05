import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:usta_bor_android/controller/my_application_detail_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_tabbar.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_response.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_status.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_desription/widgets/active_master_tab.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_desription/widgets/address_tab.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_desription/widgets/hide_master_tab.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_desription/widgets/task_tab.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_desription/widgets/time_price_tab.dart';

import '../../main_page.dart';

class MyApplicationDetailScreen extends GetView<MyApplicationDetailController> {
  MyApplicationDetailScreen({
    Key? key,
    required this.application,
  }) : super(key: key);
  final MyApplication application;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyApplicationDetailController>(initState: (_) {
      controller.getMyApplicationDetail(application.id ?? 0);
    }, builder: (controller) {
      return WillPopScope(
        onWillPop: () async{
          Get.offAll(() => MainPage());
          Get.find<MainController>().setIndex(2);
return false;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColor.white,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4, right: 4),
              child: InkWell(
                onTap: () {
                  Get.offAll(() => MainPage());
                  Get.find<MainController>().setIndex(2);
                },
                borderRadius: BorderRadius.circular(40),
                child: Ink(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.blue.withOpacity(.2),
                        offset: Offset(0, 6),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: SvgPicture.asset(
                        "assets/svg/ic_back.svg",
                        height: 14,
                        width: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            leadingWidth: 68,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(168),
              child: Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${'order_id'.tr} ${application.id}",
                          textAlign: TextAlign.center,
                          style: AppStyle.baseStyle.copyWith(
                            fontSize: 22,
                            color: AppColor.black40,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: application.status != 4 && application.status != 3? AppColor.green : AppColor.grey30,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            getApplicationStatus(application.status??0),
                            style: AppStyle.baseStyle.copyWith(
                              color: AppColor.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: AppColor.white90,
                    height: 48,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(4),
                    child: CupertinoSegmentedControl<int>(
                      padding: EdgeInsets.zero,
                      children: <int, Widget>{
                        0: Container(
                            height: 40,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: controller.currentSegment == 0 ? AppColor.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: controller.currentSegment == 0
                                  ? [
                                      BoxShadow(
                                        color: AppColor.darkBlue.withOpacity(.2),
                                        offset: Offset(0, 6),
                                        blurRadius: 24,
                                        spreadRadius: 0,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                                child: Text(
                              'master_suggest'.tr,
                              style: AppStyle.baseStyle.copyWith(color: controller.currentSegment == 0 ? AppColor.black40 : AppColor.black40.withOpacity(.5), fontWeight: FontWeight.w600, fontSize: 12),
                              textAlign: TextAlign.center,
                            ))),
                        1: Container(
                            height: 40,
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: controller.currentSegment == 1 ? AppColor.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: controller.currentSegment == 1
                                  ? [
                                      BoxShadow(
                                        color: AppColor.darkBlue.withOpacity(.2),
                                        offset: Offset(0, 6),
                                        blurRadius: 24,
                                        spreadRadius: 0,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                                child: Text(
                              'info_order'.tr,
                              textAlign: TextAlign.center,
                              style: AppStyle.baseStyle.copyWith(color: controller.currentSegment == 1 ? AppColor.black40 : AppColor.black40.withOpacity(.5), fontWeight: FontWeight.w600, fontSize: 12),
                            ))),
                      },
                      borderColor: AppColor.white90,
                      selectedColor: Colors.transparent,
                      pressedColor: Colors.transparent,
                      unselectedColor: Colors.transparent,
                      onValueChanged: (v) {
                        controller.onValueChanged(v,application.id!.toInt());
                      },
                      groupValue: controller.currentSegment,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  controller.currentSegment == 0
                      ? Column(
                          children: [
                            CustomTabBar(
                              isScrollable: false,
                              controller: controller.tabController1,
                              tabs: List.generate(
                                controller.tabTitle1.length,
                                (index) => Tab(
                                  child: AnimatedContainer(
                                    height: 24,
                                    duration: Duration(milliseconds: 100),
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(
                                      controller.tabTitle1[index],
                                      style: AppStyle.baseStyle.copyWith(
                                        fontSize: 14,
                                        color: index == controller.tabController1.index ? AppColor.green : AppColor.black40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (index) {
                                controller.update();
                              },
                            ),
                            Divider(
                              color: AppColor.grey100,
                              thickness: 1,
                              height: 0,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            CustomTabBar(
                              isScrollable: false,
                              controller: controller.tabController2,
                              tabs: List.generate(
                                controller.tabTitle2.length,
                                (index) => Tab(
                                  child: AnimatedContainer(
                                    height: 24,
                                    duration: Duration(milliseconds: 100),
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      controller.tabTitle2[index],
                                      style: AppStyle.baseStyle.copyWith(
                                        fontSize: 14,
                                        color: index == controller.tabController2.index ? AppColor.green : AppColor.black40,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: (index) {
                                controller.update();
                              },
                            ),
                            Divider(
                              color: AppColor.grey100,
                              thickness: 1,
                              height: 0,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: controller.loading,
            color: Colors.transparent,
            child: controller.applicationDetail != null
                ? SafeArea(
                    child: controller.currentSegment == 0
                        ? TabBarView(
                            controller: controller.tabController1,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              ActiveMasterTab(
                                hideMaster: (int masterId) {
                                  controller.hideMaster(application.id ?? 0, masterId);
                                },
                                application: controller.applicationDetail!,
                              ),
                              HideMasterTab(
                                application: controller.applicationDetail!,
                              ),
                            ],
                          )
                        : TabBarView(
                            controller: controller.tabController2,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              TaskTab(
                                applicationDetail: controller.applicationDetail!,
                              ),
                              TimePriceTab(
                                applicationDetail: controller.applicationDetail!,
                              ),
                              AddressTab(
                                applicationDetail: controller.applicationDetail!,
                              ),
                            ],
                          ),
                  )
                : SizedBox(),
          ),
        ),
      );
    });
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
