import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:usta_bor_android/controller/profile_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/ui/main/profile/edit_profile/edit_profile_screen.dart';
import 'package:usta_bor_android/ui/main/profile/my_masters/my_masters_screen.dart';
import 'package:usta_bor_android/ui/main/widgets/logout_dialog.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/profile/how_it_works/how_it_works_screen.dart';
import 'language_bottom_sheet.dart';

class Authenticated extends GetView<ProfileController> {
  const Authenticated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        builder: (controller) {
      return ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 48),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.grey80,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Material(
                        color: AppColor.white,
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => EditProfileScreen());
                          },
                          icon: SvgPicture.asset(
                            'assets/svg/edit.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Flexible(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColor.white,
                          ),
                          child: controller.profile?.image != null &&
                              controller.profile!.image!.isNotEmpty
                              ? Image.network(
                            '${controller.profile?.image ?? ''}?${DateTime.now().millisecondsSinceEpoch.toString()}',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          )

                              : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.grey80,
                                border: Border.all(
                                    color: AppColor.white,
                                    width: 6
                                )
                            ),
                            padding: EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              "assets/svg/avatar.svg",
                              color: AppColor.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        controller.profile?.presentation ?? '',
                        style: AppStyle.baseStyle.copyWith(
                          color: AppColor.black40,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center, //Style
                      ),
                      SizedBox(height: 6),
                      Text(
                        'customer'.tr,
                        style: AppStyle.baseStyle.copyWith(
                          color: AppColor.black40.withOpacity(.5),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                    ],
                  ),

                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Material(
                        color: AppColor.white,
                        child: IconButton(
                          onPressed: () {
                            logoutDialog();
                          },
                          icon: SvgPicture.asset(
                            'assets/svg/logout_profile.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          buildListTile(
            iconPath: 'assets/svg/how_it_works.svg',
            title: 'how_it_works'.tr,
            onPressed: () {
              Get.to(() => HowItWorksScreen());
            },
          ),
          buildListTile(
            iconPath: 'assets/svg/ic_master.svg',
            title: 'my_masters'.tr,
            onPressed: () {
              Get.to(() => MyMastersScreen());
            },
          ),
          buildListTile(
            iconPath: 'assets/svg/zayavki.svg',
            title: 'my_applications'.tr,
            onPressed: () {
              Get.find<MainController>().setIndex(2);
            },
          ),
          SizedBox(
            height: 48,
            child: ListTile(
              onTap: () {
                // final text = controller.lang;
                // Get.
                // defaultDialog(
                //     title: "select_language".tr,
                //     titleStyle: AppStyle.baseStyle.copyWith(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 20,
                //     ),
                //     contentPadding: EdgeInsets.zero,
                //     content: Column(
                //       children: [
                //         SizedBox(
                //           height: 12,
                //         ),
                //         if ('ru' != text)
                //           LanguageItemWidget(
                //             onTap: () => controller.setLang('ru'),
                //             text: " 🇷🇺  Русский",
                //             check: 'ru' == text,
                //           ),
                //         if ('uz' != text)
                //           LanguageItemWidget(
                //             onTap: () => controller.setLang('uz'),
                //             text: ' 🇺🇿  O\’zbekcha',
                //             check: 'uz' == text,
                //           ),
                //         if ('en' != text)
                //           LanguageItemWidget(
                //             onTap: () => controller.setLang("en"),
                //             text: " 🇬🇧  English",
                //             check: "en" == text,
                //           ),
                //         SizedBox(height: 16),
                //       ],
                //     ));
                Get.bottomSheet(
                  LanguageBottomSheet(
                    text: controller.lang,
                    onTap: (value) {
                      controller.setLang(value);
                    },
                  ),
                );
              },
              leading: SvgPicture.asset(
                LocalSource.getInstance.locale == 'uz'
                    ? 'assets/svg/uzbekistan.svg'
                    : LocalSource.getInstance.locale == 'en'
                        ? 'assets/svg/english.svg'
                        : 'assets/svg/russia.svg',
                fit: BoxFit.contain,
                width: 24,
                height: 24,
              ),
              minLeadingWidth: 16,
              title: Row(
                children: [
                  Text(
                    LocalSource.getInstance.locale == 'uz'
                        ? "O\’zbekcha"
                        : LocalSource.getInstance.locale == 'en'
                            ? "English"
                            : 'Русский',
                    style: AppStyle.baseStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black40,
                    ),
                  ),
                  SizedBox(width: 8),
                  SvgPicture.asset(
                    "assets/svg/arrow.svg",
                    color: AppColor.black40.withOpacity(.3),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget buildListTile({
    required String iconPath,
    required String title,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 48,
      child: ListTile(
        onTap: onPressed,
        leading: SvgPicture.asset(
          iconPath,
        ),
        title: Text(
          title,
          style: AppStyle.baseStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.black40,
          ),
        ),
        minLeadingWidth: 16,
        trailing: Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: SvgPicture.asset(
            "assets/svg/right_arrow.svg",
          ),
        ),
      ),
    );
  }
}
