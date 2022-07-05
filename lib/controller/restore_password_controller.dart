import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/auth/restore_password_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/auth_repository.dart';
import 'edit_profile_controller.dart';

class RestorePasswordController extends BaseController {
  final loginController = TextEditingController();
  final loginNode = FocusNode();
  bool _loginError = false;

  bool get loginError => _loginError;

  void typeLogin() {
    _loginError = false;
    update();
  }

  restore({required bool fromProfile}) async {
    String text = loginController.text;


     try {
       final phone = int.parse(text.replaceAll("+", '').replaceAll(" ", ""));

       if (phone
           .toString()
           .length != 12) {
         _loginError = true;
         update();
         return;
       }
       else  text = phone.toString();
     }
    catch(e) {
      bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(text);
      if (!emailValid) {
        _loginError = true;
        update();
        return;
      }
    }
    setLoading(true);

      print(text);

    final response = await AuthRepository(apiClient: ApiClient.getInstance())
        .fetchRestorePassword(login: text);
    setLoading(false);
    if (response.data is RestorePasswordResponse &&
        response.data?.status?.code != "error") {
      Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: AppColor.white,
        title: "success".tr,
        titleStyle: AppStyle.baseStyle.copyWith(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        middleText: text.contains("@")? "email_sent".tr : "sms_send".tr,
        contentPadding: EdgeInsets.all(16),
        middleTextStyle: AppStyle.baseStyle.copyWith(
          fontSize: 15,
          color: AppColor.black40,
          fontWeight: FontWeight.w500,
        ),
        radius: 16,
        confirm: CustomButton(
          onTap: () {
            if (fromProfile) Get.find<EditProfileController>().getProfile();
            Get.back();
            Get.back();
          },
          text: "ok".tr,
        ),
      );
    } else {
      Get.snackbar("error".tr,
          response.data?.status?.message ?? "incorrect_login_or_password".tr);
    }
  }
}
