import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/recall_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_text_field.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/call_date.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/top.dart';
import 'package:flutter/services.dart';

class ReCallBottomSheet extends GetView<ReCallController> {
  final Catalog catalog;

  ReCallBottomSheet({required this.catalog});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReCallController>(builder: (value) {
      return Container(
       height: 400 + MediaQuery
           .of(context)
           .padding
           .bottom,
       padding: EdgeInsets.symmetric(horizontal: 16),
       decoration: BoxDecoration(
         color: AppColor.white,
         borderRadius: BorderRadius.vertical(
           top: Radius.circular(10),
         ),
       ),
       child: ModalProgressHUD(
         inAsyncCall: value.loading,
         color: Colors.transparent,
         child: Column(
           children: [
             Top(
               showFilter: false,
               title: 'call_to_number'.tr,
             ),
             SizedBox(height: 24),
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
             SizedBox(height: 24),
             Text("choose_best_time".tr,
               style: AppStyle.baseStyle.copyWith(
                   fontWeight: FontWeight.w600,
                   fontSize: 14,
                 color: AppColor.black40,
               ),
             ),
             SizedBox(
               height: 36,
               child: RadioListTile<CallDate>(
                 groupValue: value.date,
                 value: CallDate.morning,
                 onChanged: (CallDate? date) {
                   value.changeDate(date!);
                 },
                 title: Text(
                   callDates[0].text,
                   style: AppStyle.baseStyle.copyWith(fontSize: 14),
                 ),
                 contentPadding: EdgeInsets.zero,
               ),
             ),
             SizedBox(
               height: 36,
               child: RadioListTile<CallDate>(
                 groupValue: value.date,
                 value: CallDate.day,
                 onChanged: (CallDate? date) {
                   value.changeDate(date!);
                 },
                 title: Text(
                   callDates[1].text,
                   style: AppStyle.baseStyle.copyWith(fontSize: 14),
                 ),
                 contentPadding: EdgeInsets.zero,
               ),
             ),
             SizedBox(
               height: 36,
               child: RadioListTile<CallDate>(
                 groupValue: value.date,
                 value: CallDate.evening,
                 onChanged: (CallDate? date) {
                   value.changeDate(date!);
                 },
                 title: Text(
                   callDates[2].text,
                   style: AppStyle.baseStyle.copyWith(fontSize: 14),
                 ),
                 contentPadding: EdgeInsets.zero,
               ),
             ),
             SizedBox(height: 32),
             CustomButton(
               onTap: () async {
                 value.reCallMethod(catalog.id??0);
               },
               text: "choose".tr,
             ),
             SizedBox(
               height: 8,
             ),
           ],
         ),
       ),
        );
    });
  }
}
