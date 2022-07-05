import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class LanguageItemWidget extends StatelessWidget {
  final Function? onTap;
  final String? text;
  final bool? check;

  LanguageItemWidget({
    Key? key,
    this.text,
    this.check,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Ink(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 48,
              child: Center(
                child: Text(
                  text!,
                  style: check!
                      ? AppStyle.baseStyle.copyWith(
                          color: AppColor.green,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )
                      : AppStyle.baseStyle.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                ),
              ),
            ),
            Spacer(),
            Visibility(
              visible: check!,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  "assets/svg/ic_check_circle.svg",
                  width: 24,
                  height: 24,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
