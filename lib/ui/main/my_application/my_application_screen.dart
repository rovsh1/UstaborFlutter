import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/my_application_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/auth/widgets/guest_view.dart';
import 'widgets/my_application_item.dart';

class MyApplicationScreen extends GetView<MyApplicationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyApplicationController>(
      builder: (controller) => Scaffold(
        body: LocalSource.getInstance.hasAccount
            ? ModalProgressHUD(
                inAsyncCall: controller.loading,
                color: Colors.transparent,
                child: SafeArea(
                  child: controller.myApplication.isEmpty && !controller.loading
                      ? Center(
                          child: Text(
                            "no_applications".tr,
                            style: AppStyle.baseStyle.copyWith(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            await controller.getMyApplications();
                            return;
                          },
                          // key: controller.refreshIndicatorKey,
                          color: AppColor.green,
                          child: ListView.separated(
                            separatorBuilder: (_, index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                            physics: AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 40.0, top: 24, left: 12, right: 12),
                            itemCount: controller.myApplication.length,
                            itemBuilder: (_, index) {
                              return MyApplicationItem(
                                application: controller.myApplication[index],
                              );
                            },
                          ),
                        ),
                ),
              )
            : Center(child: GuestView()),
      ),
    );
  }

}


