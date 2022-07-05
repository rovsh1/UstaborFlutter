import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/custom_widgets/custom_price_text_field.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/money_format.dart';
import 'package:usta_bor_android/data/model/application_create/date.dart';

import 'bottom_sheet_message.dart';
import 'build_date_field.dart';
import 'dots.dart';
import 'top.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

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
            index: 1,
          )),
          if (value.currentService.id != -1&&!value.endPrice.toString().contains("-1"))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: BottomSheetMessage(
                text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'price_from'.tr),
                      TextSpan(text: " ${formatMoney(value.startPrice)} ", style: const TextStyle(fontWeight: FontWeight.bold)),
      TextSpan(text: 'to'.tr),
      TextSpan(text: " ${formatMoney(value.endPrice)}", style: const TextStyle(fontWeight: FontWeight.bold)),

      ],
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              "skip_work".tr,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 12,
                color: AppColor.black,
              ),
            ),
          ),
          SizedBox(
            height: 36,
            child: RadioListTile<ApplicationDate>(
              groupValue: value.date,
              value: ApplicationDate.today,
              onChanged: (ApplicationDate? date) {
                value.changeDate(date!);
              },
              title: Text(
                "${'today'.tr}  (${value.dateTime.day} ${'${value.dateTime.month}'.tr})",
                style: AppStyle.baseStyle.copyWith(fontSize: 14),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            height: 36,
            child: RadioListTile<ApplicationDate>(
              groupValue: value.date,
              value: ApplicationDate.tomorrow,
              onChanged: (ApplicationDate? date) {
                value.changeDate(date!);
              },
              title: Text(
                "${'tomorrow'.tr}  (${value.dateTime.add(Duration(days: 1)).day} ${'${value.dateTime.month}'.tr})",
                style: AppStyle.baseStyle.copyWith(fontSize: 14),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            height: 36,
            child: RadioListTile<ApplicationDate>(
              groupValue: value.date,
              value: ApplicationDate.master_free,
              onChanged: (ApplicationDate? date) {
                value.changeDate(date!);
              },
              title: Text(
                'wait_master'.tr,
                style: AppStyle.baseStyle.copyWith(fontSize: 14),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            height: 36,
            child: RadioListTile<ApplicationDate>(
              groupValue: value.date,
              value: ApplicationDate.in_week,
              onChanged: (ApplicationDate? date) {
                value.changeDate(date!);
              },
              title: Text(
                'in_week'.tr,
                style: AppStyle.baseStyle.copyWith(
                  fontSize: 14,
                ),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          BuildDateField(),
          CustomPriceTextField(
            maxLines: 1,
            currentFocus: value.priceNode,
            controller: value.priceController,
            hintText: "any_price".tr,
            labelText: "self_price".tr,
            inputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
          ),
          if (value.currentService.id != -1&&!value.endPrice.toString().contains("-1"))
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                "${'recommended_'.tr} ${formatMoney(value.startPrice)} ${'to'.tr} ${formatMoney(value.endPrice)}",
                style: AppStyle.baseStyle.copyWith(
                  color: AppColor.black40.withOpacity(.5),
                ),
              ),
            ),
          SizedBox(
            height: 16,
          ),
          CustomButton(
            onTap: () {
              value.nextPage(1);
            },
            text: "next".tr,
          ),
        ],
      );
    });
  }
}
