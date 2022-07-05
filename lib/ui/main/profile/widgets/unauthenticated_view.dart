import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usta_bor_android/controller/profile_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/ui/auth/widgets/guest_view.dart';
import 'package:usta_bor_android/ui/main/profile/how_it_works/how_it_works_screen.dart';
import 'language_bottom_sheet.dart';
import 'language_item_widget.dart';

class UnauthenticatedView extends StatelessWidget {
  const UnauthenticatedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return ListView(
          children: [
            SizedBox(height: 64),
            GuestView(),
            SizedBox(height: 48),
            SizedBox(
              height: 48,
              child: ListTile(
                onTap: () {
                  Get.to(() => HowItWorksScreen());
                },
                leading: SvgPicture.asset(
                  'assets/svg/how_it_works.svg',
                ),
                minLeadingWidth: 16,
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SvgPicture.asset(
                    "assets/svg/right_arrow.svg",
                  ),
                ),
                title: Text(
                  'how_it_works'.tr,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 14,
                    color: AppColor.black40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 48,
              child: ListTile(
                onTap: () {
                  final text = controller.lang;
                  // Get.defaultDialog(
                  //   title: "select_language".tr,
                  //   titleStyle: AppStyle.baseStyle.copyWith(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 20,
                  //   ),
                  //   contentPadding: EdgeInsets.zero,
                  //   content: Column(
                  //     children: [
                  //       SizedBox(height: 12,),
                  //       if ('ru' != text)
                  //         LanguageItemWidget(
                  //           onTap: () => controller.setLang('ru'),
                  //           text: " 🇷🇺  Русский",
                  //           check: 'ru' == text,
                  //         ),
                  //        if ('uz' != text)
                  //         LanguageItemWidget(
                  //           onTap: () => controller.setLang('uz'),
                  //           text: ' 🇺🇿  O\’zbekcha',
                  //           check: 'uz' == text,
                  //         ),
                  //       if ('en' != text)
                  //         LanguageItemWidget(
                  //           onTap: () => controller.setLang("en"),
                  //           text: " 🇬🇧  English",
                  //           check: "en" == text,
                  //         ),
                  //       SizedBox(height: 16),
                  //     ],
                  //   )
                  // );
                  //
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
                  width: 24,
                  height: 24,

                ),
                minLeadingWidth: 16,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocalSource.getInstance.locale == 'uz'
                          ? "O\’zbekcha"
                          : LocalSource.getInstance.locale == 'en'
                          ? "English"
                          : 'Русский',
                      style: AppStyle.baseStyle.copyWith(
                        fontSize: 14,
                        color: AppColor.black40,
                        fontWeight: FontWeight.w600,
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
      },
    );
  }
}
