import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'dots.dart';
import 'top.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(builder: (value) {
      return ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(12),
        children: [
          Top(
            backPressed: () {
              value.prevPage();
            },
            showBack: true,
          ),
          SizedBox(height: 16),
          Center(
              child: Dots(
                index: 2,
              )),
          SizedBox(height: 16),
          CustomTextField(
            maxLines: 10,
            currentFocus: value.addressNode,
            controller: value.addressController,
            context: context,
            errorText: "error_address".tr,
            showError: value.addressError,
            hintText: "work_place_".tr,
            labelText: "address_".tr,
            inputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          CustomTextField(
            maxLines: 10,
            currentFocus: value.addressNoteNode,
            controller: value.addressNoteController,
            context: context,
            hintText: "landmark_".tr,
            labelText: "_landmark_".tr,
            inputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'phone_contact'.tr,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          CustomTextField(
            maxLines: 1,
            prefixText: "+998 ",
            isPhone: true,
            errorText: "error_phone".tr,
            showError: value.phoneError,
            currentFocus: value.phoneNode,
            controller: value.phoneController,
            context: context,
            labelPadding: 0,
            labelText: "",
            inputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            maxLines: 10,
            currentFocus: value.textNode,
            controller: value.textController,
            context: context,
            hintText: "write_wishes".tr,
            labelText: "any_wishes_".tr,
            inputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            onTap: () {
              value.nextPage(2);
            },
            text: "next".tr,
          ),
        ],
      );
    });
  }
}
