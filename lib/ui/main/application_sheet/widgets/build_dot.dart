import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class BuildDot extends StatelessWidget {
  const BuildDot({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 42,
        height: 6,
        decoration: BoxDecoration(
          gradient: isActive ? AppColor.greenGradient : null,
          color: isActive ? null : AppColor.grey20,
          borderRadius: BorderRadius.circular(isActive ? 4 : 3),
        ),
      ),
    );
  }
}
