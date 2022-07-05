import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';

class ProjectTab extends StatelessWidget {
  final List<Projects> projects;

  ProjectTab({required this.projects,});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, index) {
        return SizedBox(
          height: 16,
        );
      },
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: projects.length,
      itemBuilder: (_, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: projects[index].image ?? '',
            height: 240,
            width: Get.width - 32,
            fit: BoxFit.cover,
            placeholder: (_, __) {
              return Container(
                height: 240,
                width: Get.width - 32,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.grey50,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    color: AppColor.black40.withOpacity(.3),
                  ),
                ),
              );
            },
            errorWidget: (_, __, ___) {
              return Container(
                height: 240,
                width: Get.width - 32,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColor.grey50,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    Icons.image,
                    color: AppColor.black40.withOpacity(.3),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
