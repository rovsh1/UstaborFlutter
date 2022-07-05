import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:usta_bor_android/controller/edit_profile_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field/phone_masked_textinput_formatter.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/profile/change_password/change_password_screen.dart';
import 'package:usta_bor_android/ui/main/profile/change_phone/change_phone_screen.dart';
import 'package:usta_bor_android/ui/main/profile/edit_profile/widgets/image_dialog.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  @override
  Widget build(BuildContext context) {
    final maskedTextInputFormatter = PhoneMaskedTextInputFormatter(mask: '##-###-##-##', separator: '-');

    return GetBuilder<EditProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          leading: SizedBox(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 8),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  borderRadius: BorderRadius.circular(40),
                  child: Ink(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColor.white,
                    ),
                    child: Icon(
                      Icons.clear,
                      color: AppColor.black40,
                      size: 16,
                    ),
                  ),
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(32),
            child: Text(
              "edit_profile".tr,
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
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: controller.getSelectedImage != null && File(controller.getSelectedImage!.path).existsSync()
                                    ? Image.file(
                                  // /data/user/0/su.keysoft.ustabor2/cache/90cbdfc9-02d9-4783-b52f-3415863e2fdc111923493860798570.jpg
                                      // /data/user/0/su.keysoft.ustabor2/cache/image_picker2606506721531797513.jpg
                                        File(controller.getSelectedImage!.path),
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      )
                                    : controller.profile?.image != null && controller.profile!.image!.isNotEmpty
                                        ? Image.network(
                                  '${controller.profile?.image ?? ''}?${DateTime.now().millisecondsSinceEpoch.toString()}',
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 100,
                                          )
                                        : Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.grey80,
                                                border: Border.all(color: AppColor.white, width: 6)),
                                            padding: EdgeInsets.all(16),
                                            child: SvgPicture.asset(
                                              "assets/svg/avatar.svg",
                                              color: AppColor.white,
                                            ),
                                          ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () async {
                                  final result = await imageDialog();
                                  if (result == true) {
                                    controller.onPickImagePressed(ImageSource.camera);
                                  } else if (result == false) {
                                    controller.onPickImagePressed(ImageSource.gallery);
                                  }
                                },
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColor.white,
                                      width: 4,
                                    ),
                                    color: AppColor.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 108,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "upload_avatar".tr,
                                style: AppStyle.baseStyle.copyWith(color: AppColor.black40, fontSize: 14),
                              ),
                              CustomButton(
                                onTap: () async {
                                  final result = await imageDialog();
                                  controller.onPickImagePressed(result == true ? ImageSource.camera : ImageSource.gallery);
                                },
                                height: 40,
                                width: 128,
                                text: "upload".tr,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: controller.usernameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (v) {
                      controller.typeUsername();
                    },
                    autofocus: true,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    focusNode: controller.usernameNode,
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
                    inputFormatters: [maskedTextInputFormatter],
                    controller: controller.phoneController,
                    focusNode: controller.phoneNode,
                    style: AppStyle.baseStyle.copyWith(
                      color: AppColor.black40,
                      fontSize: 14,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onTap: () {
                      Get.to(()=>ChangePhoneScreen());
                    },
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
                      suffixText: "change".tr,
                      suffixStyle: AppStyle.baseStyle.copyWith(
                        color: AppColor.green,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      suffixIcon: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: SvgPicture.asset(
                          "assets/svg/ic_right.svg",
                          color: AppColor.green.withOpacity(.4),
                        ),
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
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(width: 2, color: AppColor.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(()=>ChangePasswordScreen());
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "change_password".tr,
                          style: AppStyle.baseStyle.copyWith(color: AppColor.green, fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: SvgPicture.asset(
                            "assets/svg/ic_right.svg",
                            color: AppColor.green.withOpacity(.4),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  CustomButton(
                    backgroundColor: (LocalSource.getInstance.username != controller.usernameController.text && controller.usernameController.text.isNotEmpty) || controller.getSelectedImage != null
                        ? AppColor.green
                        : AppColor.grey50,
                    onTap: () {
                      if ((LocalSource.getInstance.username != controller.usernameController.text && controller.usernameController.text.isNotEmpty) || controller.getSelectedImage != null) {
                       print("EDITED");
                        controller.editProfile();
                      } else {
                        print("NOT EDITED");
                      }
                    },
                    text: 'save'.tr,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    backgroundColor: AppColor.white,
                    fontColor: AppColor.grey90,
                    onTap: () {
                      print("CANCEL");
                      Get.back();
                    },
                    text: 'cancel_change'.tr,
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
