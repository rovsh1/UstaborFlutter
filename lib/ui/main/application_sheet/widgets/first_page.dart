import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/top.dart';

import '../../../../core/utils/app_style.dart';
import 'bottom_sheet_message.dart';
import 'build_answer_field.dart';
import 'build_category_field.dart';
import 'build_service_field.dart';
import 'build_site_field.dart';
import 'custom_image_picker.dart';
import 'dots.dart';
import 'names_of_images.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(builder: (value) {
      return ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(12),
        children: [
          Top(),
          SizedBox(height: 16),
          Center(
              child: Dots(
            index: 0,
          )),
          SizedBox(height: 16),
          BottomSheetMessage(
            text:TextSpan(text: "order_sheet1".tr,style: AppStyle.baseStyle.copyWith(
              fontSize: 14,
            ),),
          ),
          CustomTextField(
            maxLines: 1,
            currentFocus: value.nameNode,
            controller: value.nameController,
            errorText: "error_name".tr,
            showError: value.nameError,
            hintText: "name".tr,
            onChanged: (_) {
              value.typeName();
            },
            labelText: "name_".tr,
            inputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
          ),
          BuildSiteField(),
          BuildCategoryField(),
          Visibility(visible: value.service.isNotEmpty, child: BuildServiceField()),
          Visibility(visible: value.answer.isNotEmpty, child: BuildAnswerField()),
          CustomImage(),
          NamesOfImages(),
          CustomTextField(
            maxLines: 10,
            controller: value.noteController,
            hintText: "situation".tr,
            labelText: "more_info_".tr,
            errorText: "",
            showError: value.noteError,
            inputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 32,
          ),
          CustomButton(
            onTap: () {
              value.nextPage(0);
            },
            text: "next".tr,
          ),
          SizedBox(
            height: 32,
          ),
        ],
      );
    });
  }
}
