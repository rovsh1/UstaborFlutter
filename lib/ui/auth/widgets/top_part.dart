import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/circle_close_button.dart';

class TopPart extends StatelessWidget {
  const TopPart({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 52,
            height: 40,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: AppColor.black40,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleCloseButton(
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
