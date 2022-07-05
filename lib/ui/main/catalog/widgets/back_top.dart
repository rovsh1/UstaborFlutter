import 'package:flutter/material.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/ui/main/application_sheet/widgets/circle_back_button.dart';

class BackTop extends StatelessWidget {
  final Function? backPressed;
  final String text;

  BackTop({this.backPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
                alignment: Alignment.centerLeft,
                child: CircleBackButton(
                  onPressed: () {
                    backPressed!();
                  },
                ),
              ),
        Expanded(
          flex: 2,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppStyle.baseStyle.copyWith(
                fontSize: 22,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 40,
        ),
      ],
    );
  }
}
