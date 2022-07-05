import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:usta_bor_android/controller/my_application_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/main_page.dart';

import 'bottom_sheet_message.dart';
import 'dots.dart';
import 'top.dart';

class FourthPage extends StatelessWidget {
  const FourthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(builder: (value) {
      return WillPopScope(
        onWillPop: () async{
          if (value.success) {
            Get.find<MyApplicationController>().getMyApplications();
            Get.find<MainController>().setIndex(2);
            Get.offAll(() => MainPage());

            print("Custom tap");
          } else {
            value.nextPage(3);
          }

          return false;
        },
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(12),
          children: [
            Top(),
            SizedBox(height: 16),
            Center(
                child: Dots(
                  index: 3,
                )),
            Visibility(
              visible: value.success,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 28),
                child: Center(
                  child: Image.asset(
                    "assets/png/done.png",
                    height: 104,
                    width: 104,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: value.success,
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 24),
                child: Text(
                  "thanks_order".tr,
                  style: AppStyle.baseStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Visibility(
                visible: !value.success,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 32, left: 32, right: 32),
                  child: Center(
                    child: Text(
                      "phone_check".tr,
                      textAlign: TextAlign.center,
                      style: AppStyle.baseStyle.copyWith(
                        fontSize: 18,
                        color: AppColor.black40,
                      ),
                    ),
                  ),
                )),
            Visibility(
                visible: !value.success,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    "sms_check".tr,
                    textAlign: TextAlign.center,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                    ),
                  ),
                )),
            Visibility(
              visible: !value.success,
              child: CustomTextField(
                maxLines: 1,
                controller: value.codeController,
                hintText: "code_active".tr,
                labelText: "",
                errorText: "error_code".tr,
                showError: value.codeError,
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
              ),
            ),
            Visibility(
              visible: !value.success,
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 40),
                child: TextButton(
                  onPressed: () async {
                    if(value.isTime)
                    value.phoneConfirm();
                  },
                  child: Text(
                    value.isTime? 'resend'.tr:
                    "resend_after".tr + value.start.toString() + "sec".tr,
                    style: AppStyle.baseStyle.copyWith(
                      color:value.isTime? AppColor.green:AppColor.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                if (value.success) {
                  Get.find<MyApplicationController>().getMyApplications();
                  Get.find<MainController>().setIndex(2);
                  Get.offAll(() => MainPage());

                  print("Custom tap");
                } else {
                  value.nextPage(3);
                }
              },
              text: value.success ? "my_order".tr : "confirm".tr,
            ),
            Visibility(
              visible: value.success,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: BottomSheetMessage(
                  text:
                  TextSpan(text: "free_order".tr,style: AppStyle.baseStyle.copyWith(
                    fontSize: 14,
                  ),),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
