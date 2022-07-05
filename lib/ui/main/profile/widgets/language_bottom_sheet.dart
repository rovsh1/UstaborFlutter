import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/circle_close_button.dart';

import 'language_item_widget.dart';

class LanguageBottomSheet extends StatelessWidget {
  final Function(String value)? onTap;
  final String text;
  final BuildContext? context;

  LanguageBottomSheet({Key? key, this.onTap, this.text = '', this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        color: AppColor.white,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 12),
          Row(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child:Container(),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'select_language'.tr,
                    textAlign: TextAlign.center,
                    style: AppStyle.baseStyle.copyWith(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CircleCloseButton(
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
              SizedBox(height: 12),
           //   Divider(color: AppColor.grey, height: 1),
              if ('ru' != text)
                LanguageItemWidget(
                  onTap: () => onTap!('ru'),
                  text: " 🇷🇺  Русский",
                  check: 'ru' == text,
                ),
             // if('ru' != text)
          //      Divider(color: AppColor.grey, height: 1),
              if ('uz' != text)
                LanguageItemWidget(
                  onTap: () => onTap!('uz'),
                  text: ' 🇺🇿  O\’zbekcha',
                  check: 'uz' == text,
                ),
              // if ('uz' != text)
              //   Divider(
              //     color: AppColor.grey,
              //     height: 1,
              //     indent: 16,
              //   ),
              if ('en' != text)
                LanguageItemWidget(
                  onTap: () => onTap!("en"),
                  text: " 🇬🇧  English",
                  check: "en" == text,
                ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
