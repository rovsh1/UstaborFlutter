import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class PhoneButton extends StatelessWidget {
  const PhoneButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.phone
            ),
            width: double.infinity,
            height: 48,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 22),
                  child: SvgPicture.asset(
                    "assets/svg/phone.svg",
                    height: 20,
                    width: 20,
                    color: AppColor.call,
                  ),
                ),
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: AppStyle.baseStyle.copyWith(
                      fontSize: 14,
                      color: AppColor.call,
                    ),
                  ),
                ),
                SizedBox(
                  width: 42,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
