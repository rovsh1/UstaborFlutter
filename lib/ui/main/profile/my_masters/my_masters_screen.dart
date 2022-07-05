import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/my_masters_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/profile/my_masters/widgets/my_master_item.dart';

class MyMastersScreen extends GetView<MyMastersController> {

  MyMastersController controller = Get.find<MyMastersController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyMastersController>(
      builder: (controller) =>
          Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColor.white,
              leadingWidth: 68,
              leading: LeadingButton(),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(32),
                child: Text(
                  "my_masters".tr,
                  textAlign: TextAlign.center,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 22,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            body: ModalProgressHUD(
              inAsyncCall: controller.loading,
              color: Colors.transparent,
              child: SafeArea(
                child: controller.myMasters.isEmpty && !controller.loading? Center(
                  child: Text("no_masters".tr,
                     style: AppStyle.baseStyle.copyWith(
                       fontSize: 21,
                       fontWeight: FontWeight.w600,
                     ),
                  ),
                ): RefreshIndicator(
                  onRefresh: () async {
                    await controller.getMyMasters();
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: controller.myMasters.length,
                    itemBuilder: (_, index) {
                   //   print("AAAA");
                     // print(controller.myMasters[3].feedbackUrl);
                      return MyMasterItem(
                        master: controller.myMasters[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
