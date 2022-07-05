import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'img_picker_title.dart';
import 'unselected_view.dart';

class CustomImage extends StatelessWidget {
  CustomImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          ImgPickerTitle(),
          SizedBox(height: 8),
          UnselectedView(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
