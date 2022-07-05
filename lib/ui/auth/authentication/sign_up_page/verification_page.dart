
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/controller/sign_up_controller.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class VerificationPage extends GetView<SignUpController> {



  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leadingWidth: 68,
          leading: LeadingButton(),
        ),
        body: ModalProgressHUD(
          inAsyncCall: controller.loading,
          color: Colors.transparent,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset(
                  "assets/png/sms.png",
                  height: 80,
                  width: 80,
                ),
              ),
              Center(
                child: Text(
                  'enter_code'.tr,
                  textAlign: TextAlign.center,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 18,
                    color: AppColor.black40,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Center(
                child: Text(
                  '${'send_code'.tr}:\n${controller.phoneNumber}'.tr,
                  textAlign: TextAlign.center,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 18,
                    color: AppColor.black40,
                  ),
                ),
              ),
              SizedBox(height: 32),
              PinCodeTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                appContext: context,
                pastedTextStyle: AppStyle.baseStyle.copyWith(
                  color: AppColor.green,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                textInputAction: TextInputAction.done,
                pinTheme: PinTheme(
                  borderWidth: 1,
                  fieldHeight: 48,
                  shape: PinCodeFieldShape.box,
                  fieldWidth: 40,
                  borderRadius: BorderRadius.circular(8),
                  activeFillColor: AppColor.green,
                  activeColor: AppColor.green,
                  disabledColor: AppColor.grey40,
                  inactiveColor: AppColor.grey40,
                  selectedColor: AppColor.green,
                  selectedFillColor: AppColor.green,
                  errorBorderColor: AppColor.grey40,
                  inactiveFillColor: AppColor.grey40,
                  fieldOuterPadding: EdgeInsetsDirectional.only(start: 10),
                ),
                cursorColor: AppColor.green,
                controller: controller.codeController,
                beforeTextPaste: (text) => false,
                onChanged: (_){
                  controller.typeCode();
                },
              ),
              if(controller.codeError)
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Center(
                    child: Text(
                      "you_entered_wrong_code".tr,
                      style: AppStyle.baseStyle.copyWith(
                        color: AppColor.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              TextButton(
                onPressed: () async {
                 if(controller.isTime)
                  controller.phoneConfirm();
                },
                child: Text(
                  controller.isTime? 'resend'.tr:
                  "resend_after".tr + controller.start.toString() + "sec".tr,
                  style: AppStyle.baseStyle.copyWith(
                    color: controller.isTime? AppColor.green:AppColor.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
