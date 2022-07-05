import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class DragContainer extends StatelessWidget {
  const DragContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: AppColor.grey110,
        ),
      ),
    );
  }
}
