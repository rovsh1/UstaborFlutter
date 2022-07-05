import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:usta_bor_android/controller/restore_password_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class RestorePasswordPage extends GetView<RestorePasswordController> {
  final bool fromProfile;

  RestorePasswordPage({this.fromProfile = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestorePasswordController>(
      builder: (controller) {
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
            child: KeyboardDismisser(
              child: SafeArea(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Center(
                        child: Text(
                          'password_recovery'.tr,
                          textAlign: TextAlign.center,
                          style: AppStyle.baseStyle.copyWith(
                            fontSize: 22,
                            color: AppColor.black40,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Center(
                        child: Text(
                          'mail_phone'.tr,
                          textAlign: TextAlign.center,
                          style: AppStyle.baseStyle.copyWith(
                            fontSize: 14,
                            color: AppColor.black40,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      autofocus: true,
                      controller: controller.loginController,
                      onChanged: (text) {
                        print(text);
                        controller.typeLogin();
                      },
                      focusNode: controller.loginNode,
                      style: AppStyle.baseStyle.copyWith(
                        color: AppColor.black40,
                        fontSize: 14,
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'phone_number_or_email'.tr,
                        hintStyle: AppStyle.baseStyle.copyWith(
                          fontSize: 14,
                          color: AppColor.black40.withOpacity(.5),
                        ),
                        prefixStyle: AppStyle.baseStyle.copyWith(
                          color: AppColor.black40,
                          fontSize: 14,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(width: 2, color: AppColor.grey50),
                        ),
                        errorStyle: AppStyle.baseStyle.copyWith(
                          color: AppColor.red,
                          fontSize: 14,
                        ),
                        errorText: controller.loginError ? "error_phone_or_email".tr : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(width: 2, color: AppColor.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      backgroundColor: controller.loginController.text.isNotEmpty ? AppColor.green : AppColor.grey50,
                      onTap: () {
                        if (controller.loginController.text.isNotEmpty) controller.restore(fromProfile: fromProfile);
                      },
                      text: 'send_link'.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
