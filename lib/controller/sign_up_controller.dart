import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/auth/phone_confirm_response.dart';
import 'package:usta_bor_android/data/model/auth/registration_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/auth_repository.dart';
import 'package:usta_bor_android/ui/auth/authentication/sign_up_page/verification_page.dart';
import 'package:usta_bor_android/ui/main/main_page.dart';
import 'package:usta_bor_android/ui/main/select_site/select_site.dart';
import 'main_controller.dart';

class SignUpController extends BaseController {
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final codeController = TextEditingController();
   bool isTime = false;

  Timer? _timer;
  int start = 60;
 // var oneSec = const Duration(seconds: 1);
  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) {
            if (start < 2) {
              isTime = true;
              _timer!.cancel();
              _timer = null;
              update();
            } else {
              start = start - 1;
              update();
            }
          },
      );
    }
  }



  String _receivedCode = '';
  String _phoneNumber = '';
  String _phone = '';
  final usernameNode = FocusNode();
  final phoneNode = FocusNode();
  bool _usernameError = false;
  bool _phoneError = false;
  bool _codeError = false;

  bool get usernameError => _usernameError;

  bool get phoneError => _phoneError;

  bool get codeError => _codeError;

  String get phoneNumber => _phoneNumber;

  void typeUsername() {
    _usernameError = false;
    update();
  }

  void typeCode() {
    if (codeController.text.trim().length == 4) {
      registration(codeController.text);
    } else {
      _codeError = false;
      update();
    }
  }

  void typePhoneNumber() {
    _phoneError = false;
    update();
  }

  registration(String code) async {
    if (code.length == 4 && _receivedCode == code) {
      setLoading(true);
      final response = await AuthRepository(apiClient: ApiClient.getInstance()).fetchRegistration(username: usernameController.text, phone: _phone);
      setLoading(false);
      if (response.data is RegistrationResponse && response.data?.status?.code != "error") {
        await LocalSource.getInstance.setAccount(
            accessToken: response.data?.result?.token ?? "",
            phone: _phoneNumber,
            username: usernameController.text,
            userId: response.data?.result?.userId ?? 0,
            avatar: '');
        // Get.find<MyApplicationController>().getMyApplications();
        // Get.find<ProfileController>().getProfile();
        // Get.find<CatalogController>().refreshPage();
       LocalSource.getInstance.setIsGoogleSigning(false);
        if (LocalSource.getInstance.siteId == -1) {
          Get.offAll(() => SelectSiteScreen());
        } else {
          Get.back();
          Get.off(() => MainPage());
          Get.find<MainController>().updateProfile();
        }
      } else {
        Get.snackbar("error".tr, response.data?.status?.message ?? "error_text".tr);
      }
    } else {
      _codeError = true;
      update();
    }
  }

  phoneConfirm({bool fromSignUp = false}) async {
    _phone = "998${phoneController.text.trim().replaceAll(' ', '').replaceAll('-', '')}";
    if (usernameController.text.trim().isEmpty) {
      _usernameError = true;
      update();
      return;
    } else if (_phone.length != 12) {
      _phoneError = true;
      update();
      return;
    }
    _phoneNumber = "+998 ${phoneController.text.replaceAll('-', ' ')}";
    setLoading(true);
    final response = await AuthRepository(apiClient: ApiClient.getInstance()).fetchPhoneConfirm(phone: _phone);
    setLoading(false);
    if (response.data is PhoneConfirmResponse && response.data?.status?.code != "error") {
      _receivedCode = response.data?.result?.code ?? '';

      isTime = false;
      start = 60;
      startTimer();

      if (fromSignUp) {
        Get.to(() => VerificationPage());
      }
    } else {
      Get.snackbar("error".tr, response.data?.status?.message ?? "error_text".tr);
    }
  }
}
