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
import 'package:usta_bor_android/core/custom_widgets/custom_text_field.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field/phone_masked_textinput_formatter.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/auth/authentication/restore_passwoord_page/restore_password_page.dart';

class ChangePhoneScreen extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    final maskedTextInputFormatter = PhoneMaskedTextInputFormatter(mask: '##-###-##-##', separator: '-');

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
              "edit_phone".tr,
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
                  TextFormField(
                    inputFormatters: [maskedTextInputFormatter],
                    autofocus: true,
                    controller: controller.newPhoneController,
                    onChanged: (text) {
                      controller.typeNewPhoneNumber();
                    },
                    focusNode: controller.newPasswordNode,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'enter_phone'.tr,
                      hintStyle: AppStyle.baseStyle.copyWith(
                        fontSize: 14,
                        color: AppColor.black40.withOpacity(.5),
                      ),
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset(
                            "assets/svg/uzbekistan.svg",
                            height: 24,
                            width: 24,
                          ),
                          Container(
                              width: 40,
                              margin: EdgeInsets.only(left: 16, bottom: 2),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "+998",
                                    style: AppStyle.baseStyle.copyWith(
                                      color: AppColor.black40,
                                      fontSize: 14,
                                    ),
                                  ))),
                        ],
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
                      errorText: controller.newPhoneError ? "error_phone".tr : null,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 2, color: AppColor.red),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.successPhone,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CustomTextField(
                        maxLines: 1,
                        controller: controller.codeController,
                        hintText: "code_sms".tr,
                        labelText: "",
                        inputFormatters: [LengthLimitingTextInputFormatter(4)],
                        labelPadding: 0,
                        errorText: "error_code".tr,
                        showError: controller.codeError,
                        inputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    backgroundColor: controller.newPhoneController.text.isNotEmpty ? AppColor.green : AppColor.grey50,
                    onTap: () {
                      if (controller.newPhoneController.text.isNotEmpty) {
                        if (controller.successPhone) {
                          controller.editPhone();
                        } else {
                          controller.phoneConfirm();
                        }
                      }
                    },
                    text: controller.successPhone ? 'come_in'.tr : "change".tr,
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
}
