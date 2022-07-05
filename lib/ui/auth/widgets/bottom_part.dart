import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({
    Key? key,
    required this.onPressed,
    required this.onLinkPressed,
    required this.title,
    required this.titleButtonText,
    required this.subtitle,
    required this.subtitleButtonText,
  }) : super(key: key);

  final VoidCallback onPressed, onLinkPressed;
  final String title;
  final String subtitle;
  final String subtitleButtonText;
  final String titleButtonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
                color: AppColor.black40,
              ),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                titleButtonText,
                style: AppStyle.baseStyle.copyWith(
                  color: AppColor.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              subtitle,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14,
                color: AppColor.black40,
              ),
            ),
            TextButton(
              onPressed: onLinkPressed,
              child: Text(
                subtitleButtonText,
                style: AppStyle.baseStyle.copyWith(
                  color: AppColor.green,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
