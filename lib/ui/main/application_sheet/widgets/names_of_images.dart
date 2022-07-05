import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';

class NamesOfImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApplicationController>(
      builder: (value) {
        return Wrap(
          runSpacing: 8,
          children: value.getImageList.map((item) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              color: AppColor.white,
              shadowColor: AppColor.black40.withOpacity(0.13),
              child: Container(
                height: 48,
                width: Get.width / 2 - 20,
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.file(
                        File(item.path),
                        height: 40,
                        fit: BoxFit.cover,
                        width: 40,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                      width: Get.width / 2 - 100,
                      child: Text(
                        item.name,
                        style: AppStyle.baseStyle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Center(
                      child: InkWell(
                        onTap: () {
                          value.removeImage(item);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Ink(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColor.black40.withOpacity(0.5),
                          ),
                          child: Icon(
                            Icons.clear_sharp,
                            size: 12,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
