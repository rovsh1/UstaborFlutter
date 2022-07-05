import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:usta_bor_android/controller/edit_profile_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/auth/authentication/restore_passwoord_page/restore_password_page.dart';

class ChangePasswordScreen extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          leading: LeadingButton(),
          leadingWidth: 68,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(32),
            child: Text(
              "change_password".tr,
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
          child: KeyboardDismisser(
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  /*TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    controller: controller.oldPasswordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (v) {
                      controller.typeOldPassword();
                    },
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    onFieldSubmitted: (_) {
                      fieldFocusChange(context, controller.oldPasswordNode, controller.newPasswordNode);
                    },
                    focusNode: controller.oldPasswordNode,
                    decoration: InputDecoration(
                      errorStyle: AppStyle.baseStyle.copyWith(
                        color: AppColor.red,
                        fontSize: 14,
                      ),
                      errorText: controller.oldPasswordError ? "error_password".tr : null,
                      hintText: 'current_password'.tr,
                      hintStyle: AppStyle.baseStyle.copyWith(
                        fontSize: 14,
                        color: AppColor.black40.withOpacity(.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),*/
                  TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    controller: controller.newPasswordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (v) {
                      controller.typeOldPassword();
                    },
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    onFieldSubmitted: (_) {
                      fieldFocusChange(context, controller.newPasswordNode, controller.confirmPasswordNode);
                    },
                    focusNode: controller.newPasswordNode,
                    decoration: InputDecoration(
                      errorStyle: AppStyle.baseStyle.copyWith(
                        color: AppColor.red,
                        fontSize: 14,
                      ),
                      errorText: null,
                      hintText: 'new_password'.tr,
                      hintStyle: AppStyle.baseStyle.copyWith(
                        fontSize: 14,
                        color: AppColor.black40.withOpacity(.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    controller: controller.confirmPasswordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (v) {
                      controller.typeOldPassword();
                    },
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    focusNode: controller.confirmPasswordNode,
                    decoration: InputDecoration(
                      errorStyle: AppStyle.baseStyle.copyWith(
                        color: AppColor.red,
                        fontSize: 14,
                      ),
                      errorText: null,
                      hintText: 'retry_password'.tr,
                      hintStyle: AppStyle.baseStyle.copyWith(
                        fontSize: 14,
                        color: AppColor.black40.withOpacity(.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    backgroundColor: controller.newPasswordController.text.isNotEmpty && controller.confirmPasswordController.text.isNotEmpty
                        ? AppColor.green
                        : AppColor.grey50,
                    onTap: () {
                      if (controller.newPasswordController.text.isNotEmpty && controller.confirmPasswordController.text.isNotEmpty)

                        controller.editPassword();
                    },
                    text: 'change'.tr,
                  ),
                  const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {
                      Get.to(()=>RestorePasswordPage(
                        fromProfile: true,
                      ));
                    },
                    child: Text(
                      "forget_password".tr,
                      style: AppStyle.baseStyle.copyWith(
                        color: AppColor.black40.withOpacity(.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  fieldFocusChange(
    BuildContext context,
    FocusNode? currentFocus,
    FocusNode? nextFocus,
  ) {
    if (currentFocus != null && nextFocus != null) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }
  }
}
