import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:usta_bor_android/controller/sign_up_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field/phone_masked_textinput_formatter.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class SignUpPage extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    final maskedTextInputFormatter = PhoneMaskedTextInputFormatter(mask: '##-###-##-##', separator: '-');

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
          child: KeyboardDismisser(
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 52),
                    child: Center(
                      child: Text(
                        'registration'.tr,
                        textAlign: TextAlign.center,
                        style: AppStyle.baseStyle.copyWith(
                          fontSize: 22,
                          color: AppColor.black40,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: controller.usernameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onChanged: (v) {
                      controller.typeUsername();
                    },
                    autofocus: true,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    focusNode: controller.usernameNode,
                    onFieldSubmitted: (_) {
                      fieldFocusChange(context, controller.usernameNode, controller.phoneNode);
                    },
                    decoration: InputDecoration(
                      errorStyle: AppStyle.baseStyle.copyWith(
                        color: AppColor.red,
                        fontSize: 14,
                      ),
                      errorText: controller.usernameError ? "error_fio".tr : null,
                      hintText: 'fio'.tr,
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
                  const SizedBox(height: 24),
                  TextFormField(
                    inputFormatters:  [maskedTextInputFormatter],
                    controller: controller.phoneController,
                    onChanged: (text) {
                      controller.typePhoneNumber();
                    },
                    focusNode: controller.phoneNode,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'phone_number_'.tr,
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
                      errorText: controller.phoneError ? "error_phone".tr : null,
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 2, color: AppColor.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    backgroundColor: controller.usernameController.text.isNotEmpty && controller.phoneController.text.isNotEmpty ? AppColor.green : AppColor.grey50,
                    onTap: () {
                      if (controller.usernameController.text.isNotEmpty && controller.phoneController.text.isNotEmpty) controller.phoneConfirm(fromSignUp: true);
                    },
                    text: 'register'.tr,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
