import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:usta_bor_android/controller/profile_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field/always_disabled_focus_node.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/auth/phone_confirm_response.dart';
import 'package:usta_bor_android/data/model/profile/profile_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/auth_repository.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/main/main_page.dart';


class EditProfileController extends BaseController {
  final usernameNode = FocusNode();
  final oldPasswordNode = FocusNode();
  final newPasswordNode = FocusNode();
  final confirmPasswordNode = FocusNode();
  final newPhoneNode = FocusNode();
  final codeNode = FocusNode();
  final phoneNode = AlwaysDisabledFocusNode();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final newPhoneController = TextEditingController();
  final codeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool _usernameError = false;
  bool _oldPasswordError = false;
  bool _newPasswordError = false;
  bool _confirmPasswordError = false;
  bool _newPhoneError = false;
  bool _codeError = false;
  bool _successPhone = false;
  late Profile _profile;
  String _phone = '';
  String _receivedCode = '';
  final _picker = ImagePicker();
  dynamic _pickImageError;
  XFile? _selectedImage;
  XFile? get getSelectedImage => _selectedImage;
  dynamic get getError => _pickImageError;

  Future<void> onPickImagePressed(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(source: source,imageQuality: 30,preferredCameraDevice: CameraDevice.front);
      if (pickedImage != null) {
        _selectedImage = pickedImage;
        print(_selectedImage!.path);
       }
    } catch (e) {
      _pickImageError = e;
    }
    update();
  }

  bool get successPhone => _successPhone;

  @override
  void onInit() {
    _profile = Profile(
      name: LocalSource.getInstance.username,
      image: LocalSource.getInstance.avatar,
      id: LocalSource.getInstance.userId,
      phone: LocalSource.getInstance.phone,
      presentation: LocalSource.getInstance.username,
    );
    usernameController.text = _profile.name ?? '';
    phoneController.text = (_profile.phone ?? '').replaceAll("+998", '');
    super.onInit();
  }

  editProfile() async {
    if (_selectedImage!=null) {
      File image  = await FlutterExifRotation.rotateAndSaveImage(path: _selectedImage?.path ?? '');
      await LocalSource.getInstance.setAvatar(image.path);
      setLoading(true);
      final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchEditAvatar(
        image: File(image.path),
      );
      setLoading(false);
      if (response.data?.status?.message != "error") {
        if(usernameController.text.trim() == LocalSource.getInstance.username){
          Get.find<ProfileController>().getProfile();
          Get.back();
          // Get.find<MainController>().setIndex(3);
          print("+++++updated1");
        }
      } else {
        Get.snackbar('error'.tr, 'error_text'.tr);
      }
    }
    if (usernameController.text.trim().isNotEmpty && LocalSource.getInstance.username != usernameController.text) {
      setLoading(true);
      final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchEditProfile(name: usernameController.text);
      setLoading(false);
      if (response.data?.status?.message != "error") {
        Get.find<ProfileController>().getProfile();
        Get.back();
        // Get.find<MainController>().setIndex(3);
        print("+++++updated");

      } else {
        Get.snackbar('error'.tr, 'error_text'.tr);
      }

    } else if (usernameController.text.trim().isEmpty) {
      _usernameError = true;
      update();

    } else {
    _usernameError = false;
    update();

    }
    update();
  }

  phoneConfirm() async {
    _phone = "+998${newPhoneController.text.trim().replaceAll(' ', '').replaceAll('-', '')}";
    if (_phone.length != 13) {
      _newPhoneError = true;
      update();
      return;
    }
    setLoading(true);
    final response = await AuthRepository(apiClient: ApiClient.getInstance()).fetchPhoneConfirm(phone: _phone);
    setLoading(false);
    if (response.data is PhoneConfirmResponse && response.data?.status?.code != "error") {
      _receivedCode = response.data?.result?.code ?? '';
      _successPhone = true;
    } else {
      Get.snackbar("error".tr, response.data?.status?.message ?? "error_text".tr);
    }
  }
  editPassword() async {

    if (!(newPasswordController.text.trim().length == 6 && confirmPasswordController.text.trim().length==6)) {
      _newPasswordError = true;
      Get.snackbar('error'.tr, 'error_password_length'.tr,duration: Duration(seconds: 1),animationDuration: Duration(milliseconds: 500));
      update();
    } else if (confirmPasswordController.text != newPasswordController.text) {
      Get.snackbar('error'.tr, 'error_password_same'.tr,duration: Duration(seconds: 1),animationDuration: Duration(milliseconds: 500));
      _confirmPasswordError = true;
      update();
    } else {
      setLoading(true);
      final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchEditPassword(
        password: confirmPasswordController.text,
      );
      setLoading(false);
      if (response.data?.status?.message != "error") {
        newPasswordController.clear();
        confirmPasswordController.clear();
        _newPasswordError = false;
        _confirmPasswordError = false;
        Get.find<ProfileController>().getProfile();

        Get.back();
      } else {
        Get.snackbar('error'.tr, 'error_text'.tr);
      }
    }
  }

  editPhone() async {
    if (codeController.text != _receivedCode) {
      _oldPasswordError = true;
      Get.snackbar('error'.tr, 'you_entered_wrong_code'.tr,duration: Duration(seconds: 1),animationDuration: Duration(milliseconds: 500));
      update();
    } else {
      setLoading(true);

      final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchEditPhone(
        phone: _phone.replaceAll(" ", '').replaceAll("+", ""),
      );
      setLoading(false);
      if (response.data?.status?.message != "error") {
        newPhoneController.clear();
        codeController.clear();
        _phone = '';
        _receivedCode = '';
        _successPhone = false;
       await Get.find<ProfileController>().getProfile();
        update();

        _profile = Profile(
          name: LocalSource.getInstance.username,
          image: LocalSource.getInstance.avatar,
          id: LocalSource.getInstance.userId,
          phone: LocalSource.getInstance.phone,
          presentation: LocalSource.getInstance.username,
        );
        usernameController.text = _profile.name ?? '';
        phoneController.text = (_profile.phone ?? '').replaceAll("+998", '');
        Get.back();
        print("BACK");
      } else {
        Get.snackbar('error'.tr, 'error_text'.tr);
      }
    }
  }

  Future getProfile() async {
    setLoading(true);
    final response = await AuthRepository(apiClient: ApiClient.getInstance()).fetchProfile();
    setLoading(false);
    if (response.data?.status?.message != "error" && response.data != null && response.data!.result != null) {
      _profile = response.data!.result!;
      await LocalSource.getInstance.setAccount(accessToken: LocalSource.getInstance.accessToken, phone: response.data?.result?.phone ?? '', username: response.data?.result?.presentation ?? '', userId: LocalSource.getInstance.userId, avatar: LocalSource.getInstance.avatar);
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  void typeUsername() {
    _usernameError = false;
    update();
  }

  void typeNewPhoneNumber() {
    _newPhoneError = false;
    update();
  }

  void typeOldPassword() {
    _oldPasswordError = false;
    update();
  }

  void typeNewPassword() {
    _newPasswordError = false;
    update();
  }

  void typeConfirmPassword() {
    _confirmPasswordError = false;
    update();
  }

  void typeCode() {
    _codeError = false;
    update();
  }

  bool get usernameError => _usernameError;

  bool get newPhoneError => _newPhoneError;

  bool get oldPasswordError => _oldPasswordError;

  bool get newPasswordError => _newPasswordError;

  bool get confirmPasswordError => _confirmPasswordError;

  bool get codeError => _codeError;

  Profile? get profile => _profile;
}
