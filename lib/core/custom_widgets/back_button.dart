import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';

class LeadingButton extends StatelessWidget {
  const LeadingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4, right: 4),
      child: InkWell(
        onTap: () {
          Get.back();
        },
        borderRadius: BorderRadius.circular(40),
        child: Ink(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.blue.withOpacity(.2),
                offset: Offset(0, 6),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: SvgPicture.asset(
                "assets/svg/ic_back.svg",
                height: 14,
                width: 11,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
