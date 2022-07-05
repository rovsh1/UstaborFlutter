import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/circle_close_button.dart';

class Top extends StatelessWidget {
  final bool showBack;
  final bool showFilter;
  final String title;

  Top({this.showBack = false, this.showFilter = true, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          height: 4,
          width: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColor.grey90,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                      alignment: Alignment.centerLeft,
                      child: Visibility(
                        visible: showFilter,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: SvgPicture.asset("assets/svg/filter.svg",
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                    )

            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 20,
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
      ],
    );
  }
}
