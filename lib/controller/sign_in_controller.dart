import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/auth/login_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/auth_repository.dart';
import 'package:usta_bor_android/ui/main/main_page.dart';
import 'package:usta_bor_android/ui/main/select_site/select_site.dart';


class SignInController extends BaseController {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscure = true;
  late AuthRepository _repository;
  final loginNode = FocusNode();
  final passwordNode = FocusNode();
  bool _loginError = false;
  bool _passwordError = false;

  bool get loginError => _loginError;

  bool get obscure => _obscure;

  bool get passwordError => _passwordError;

  @override
  void onInit() {
    _repository = AuthRepository(apiClient: ApiClient.getInstance());
    super.onInit();
  }
  @override
  void onReady() {
    _repository = AuthRepository(apiClient: ApiClient.getInstance());
   // loginMethod();
    super.onReady();
  }



  void typeLogin() {
    _loginError = false;
    update();
  }

  void typePassword(String v) {
    _passwordError = false;
    update();
  }

  void setObscure() {
    _obscure = !_obscure;
    update();
  }

  loginMethod() async {
    final phone = "998${loginController.text.trim().replaceAll(' ', '').replaceAll('-', '')}";
    if (phone.length != 12) {
      _loginError = true;
      update();
      return;
    } else if (passwordController.text.trim().length <= 5) {
      _passwordError = true;
      update();
      return;
    }

    print(phone + " " + passwordController.text);

    setLoading(true);
    final response = await _repository.fetchLogin(login: phone, password: passwordController.text);
    setLoading(false);
    if (response.data is LoginResponse && response.data?.status?.code != "error") {
      await LocalSource.getInstance.setAccount(
          accessToken: response.data?.result?.token ?? '',
          phone: "+998 ${loginController.text.replaceAll('-', ' ')}",
          username: "",
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
      Get.snackbar("error".tr, response.data?.status?.message ?? "incorrect_login_or_password".tr);
    }
  }

  loginProvider(String provider, String token) async {

    setLoading(true);


    final response = await _repository.fetchLoginProvider(provider: provider, token: token);

    setLoading(false);
    if (response.data is LoginResponse && response.data?.status?.code != "error") {
      await LocalSource.getInstance.setAccount(
          accessToken: response.data?.result?.token ?? '',
          phone: "+998 ${loginController.text.replaceAll('-', ' ')}",
          username: "",
          userId: response.data?.result?.userId ?? 0,
          avatar: '');

      if (LocalSource.getInstance.siteId == -1) {
        Get.offAll(() => SelectSiteScreen());
      } else {
        Get.back();
        Get.off(() => MainPage());
        Get.find<MainController>().updateProfile();

      }
    } else {
      Get.snackbar("error".tr, response.data?.status?.message ?? "incorrect_login_or_password".tr);
    }
  }

  loginProviderApple(String provider, String token) async {

    setLoading(true);
    final response = await _repository.fetchLoginProviderApple(provider: provider, token: token);
    setLoading(false);
    if (response.data is LoginResponse && response.data?.status?.code != "error") {
      await LocalSource.getInstance.setAccount(
          accessToken: response.data?.result?.token ?? '',
          phone: "+998 ${loginController.text.replaceAll('-', ' ')}",
          username: "",
          userId: response.data?.result?.userId ?? 0,
          avatar: '');

      // Get.find<MyApplicationController>().getMyApplications();
      // Get.find<ProfileController>().getProfile();

      if (LocalSource.getInstance.siteId == -1) {
        Get.offAll(() => SelectSiteScreen());
      } else {
        Get.back();
        Get.off(() => MainPage());
        Get.find<MainController>().updateProfile();
      }
    } else {
      Get.snackbar("error".tr, response.data?.status?.message ?? "incorrect_login_or_password".tr);
    }
  }
}
