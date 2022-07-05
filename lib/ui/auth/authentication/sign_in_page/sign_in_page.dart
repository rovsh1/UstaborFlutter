import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:usta_bor_android/controller/sign_in_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field/phone_masked_textinput_formatter.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/auth/authentication/restore_passwoord_page/restore_password_page.dart';

class SignInPage extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    final maskedTextInputFormatter = PhoneMaskedTextInputFormatter(mask: '##-###-##-##', separator: '-');

    return GetBuilder<SignInController>(
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
                      padding: const EdgeInsets.only(top: 12, bottom: 52),
                      child: Center(
                        child: Text(
                          'enter'.tr,
                          textAlign: TextAlign.center,
                          style: AppStyle.baseStyle.copyWith(
                            fontSize: 22,
                            color: AppColor.black40,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      inputFormatters: [maskedTextInputFormatter],
                      autofocus: true,
                      controller: controller.loginController,
                      onChanged: (text) {
                        controller.typeLogin();
                      },
                      onFieldSubmitted: (_) {
                        fieldFocusChange(context, controller.loginNode, controller.passwordNode);
                      },
                      focusNode: controller.loginNode,
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
                        errorText: controller.loginError ? "error_phone".tr : null,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(width: 2, color: AppColor.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(8)],
                      obscureText: controller.obscure,
                      controller: controller.passwordController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (v) {
                        controller.typePassword(v);
                      },
                      focusNode: controller.passwordNode,
                      style: AppStyle.baseStyle.copyWith(
                        color: AppColor.black40,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.setObscure();
                          },
                          icon: SvgPicture.asset(
                            controller.obscure ? "assets/svg/ic_pass_show.svg" : "assets/svg/ic_pass.svg",
                            color: controller.obscure ? AppColor.grey50 : AppColor.green,
                          ),
                        ),
                        errorStyle: AppStyle.baseStyle.copyWith(
                          color: AppColor.red,
                          fontSize: 14,
                        ),
                        errorText: controller.passwordError ? "error_password".tr : null,
                        hintText: 'password'.tr,
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
                    CustomButton(
                      backgroundColor: controller.passwordController.text.isNotEmpty && controller.loginController.text.isNotEmpty ? AppColor.green : AppColor.grey50,
                      onTap: () {
                        if (controller.passwordController.text.isNotEmpty && controller.loginController.text.isNotEmpty) controller.loginMethod();
                      },
                      text: 'come_in'.tr,
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        Get.to(()=>RestorePasswordPage());
                      },
                      child: Text(
                        "forget_password".tr,
                        style: AppStyle.baseStyle.copyWith(
                          color: AppColor.black40.withOpacity(.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
