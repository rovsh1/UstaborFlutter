import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/select_site_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/main_page.dart';
import 'package:usta_bor_android/ui/main/select_site/widgets/site_field.dart';

class SelectSiteScreen extends GetView<SelectSiteController> {
  const SelectSiteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectSiteController>(builder: (value) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          automaticallyImplyLeading: false,
          title: Text(
            "choose_site".tr,
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
          inAsyncCall: value.loading,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 72,
                ),
                SiteField(),
                SizedBox(
                  height: 36,
                ),
                CustomButton(
                  text: "next".tr,
                  onTap: () async {
                    await LocalSource.getInstance.setSiteId(value.currentSite?.id ?? 0);

                    Get.off(MainPage());
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
