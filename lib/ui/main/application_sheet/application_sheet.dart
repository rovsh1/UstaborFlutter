import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/first_page.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/fourth_page.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/second_page.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/third_page.dart';

class ApplicationSheet extends GetView<ApplicationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(
      builder: (value) => KeyboardDismisser(
        child: Container(
            height: Get.height - 50,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: ModalProgressHUD(
              inAsyncCall: value.loading,
              color: Colors.transparent,
              child: PageView(
                controller: value.pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {},
                children: [
                  FirstPage(),
                  SecondPage(),
                  ThirdPage(),
                  FourthPage(),
                ],
              ),
            )),
      ),
    );
  }
}
