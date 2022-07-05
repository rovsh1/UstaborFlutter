import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/money_format.dart';
import 'package:usta_bor_android/data/model/catalog/master_response.dart';

class InfoTab extends StatelessWidget {
  final Master master;
  final Function onTap;

  InfoTab({
    required this.master,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        // SizedBox(
        //   height: 24,
        // ),
        Text(
          'about_the_master'.tr + ":",
          style: AppStyle.baseStyle.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: AppColor.black40,
          ),
          textAlign: TextAlign.start,
        ),
        SizedBox(height: 16),
        Row(
          children: <Widget>[
            Container(
              height: 24,
              width: 24,
              child: Center(
                child: SvgPicture.asset("assets/svg/location.svg"),
              ),
            ),
            SizedBox(width: 8),
            Text(
              "${master.countryName}, ${master.cityName}",
              style: AppStyle.baseStyle.copyWith(
                fontSize: 14.0,
                color: AppColor.black40,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        if (master.about != null && master.about!.isNotEmpty)
          Text(
            master.about.toString().replaceAll("\r\n\r\n\r\n", "\r\n"),
            style: AppStyle.baseStyle.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
            ),
          ),
        SizedBox(height: 16),
        if (master.projects!.isNotEmpty)
          Text(
            'specialization'.tr + ':',
            style: AppStyle.baseStyle.copyWith(
              color: AppColor.black40,
              fontWeight: FontWeight.w700,
              fontSize: 14.0,
            ),
          ),
        if (master.projects!.isNotEmpty) SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: master.projects!
              .map((e) => e.categoryName)
              .toSet()
              .map((item) => Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColor.grey80,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      child: Text(
                        item ?? '',
                        style: AppStyle.baseStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.black40,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(
          height: 24,
        ),
        if (master.services!.isNotEmpty)
          Text(
            'price_service'.tr,
            style: AppStyle.baseStyle.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: AppColor.black40,
            ),
          ),
        if (master.services!.isNotEmpty)
          SizedBox(
            height: 16,
          ),
        for (int i = 0; i < master.categories!.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32,
                margin: EdgeInsets.only(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  color: AppColor.grey80,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Text(
                     Get.find<CatalogController>()
                                .allCategory
                                .where((element) =>
                                    element.id.toString() ==
                                    master.categories![i].toString())
                                .first
                                .name ??
                            '',
                    style: AppStyle.baseStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.black40,
                    ),
                  ),
                ),
              ),
              for (int j = 0; j < master.services!.length; j++)
                if(master.services![j].categoryId.toString()==master.categories![i].toString())
              Builder(builder: (context) {
                TextSelection selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: (master.services![j].name ?? '').length);
                final tp = TextPainter(
                    text: TextSpan(
                      text: master.services![j].name ?? '',
                      style: AppStyle.baseStyle.copyWith(
                        color: AppColor.black40,
                        fontSize: 14.0,
                      ),
                    ),
                    maxLines: 3,
                    textDirection: TextDirection.ltr);
                tp.layout(maxWidth: Get.width - 200);
                List<TextBox> boxes = tp.getBoxesForSelection(selection);
                int numberOfLines = boxes.length;

                return Container(
                  margin: EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: Get.width - 200),
                        child: Text(
                          master.services![j].name ?? '',
                          maxLines: numberOfLines,
                          style: AppStyle.baseStyle.copyWith(
                            color: AppColor.black40,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: numberOfLines == 1
                            ? Text(
                                ".....................................................................................",
                                style: AppStyle.baseStyle.copyWith(
                                  color: AppColor.black40.withOpacity(0.3),
                                  fontSize: 14.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            : SizedBox(),
                      ),
                      Text(
                        " ${"from".tr} ${formatMoney(double.parse(master.services![j].price ?? "0.0"))}",
                        style: AppStyle.baseStyle.copyWith(
                          color: AppColor.black40,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        SizedBox(height: 8.0),
        if (master.projects!.isNotEmpty)
          Text(
            'photo_projects'.tr,
            style: AppStyle.baseStyle.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: AppColor.black40,
            ),
          ),
        if (master.projects!.isNotEmpty) SizedBox(height: 24.0),
        GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 82 / 61,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            for (int i = 0;
                i < (master.projects!.length > 3 ? 3 : master.projects!.length);
                i++)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: master.projects![i].image ?? '',
                  height: 112,
                  width: Get.width - 32,
                  fit: BoxFit.cover,
                  placeholder: (_, __) {
                    return Container(
                      height: 112,
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
                      height: 112,
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
              ),
            if (master.projects!.length > 2)
              InkWell(
                onTap: () {
                  onTap();
                },
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  height: 112,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColor.green,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "all_photos".tr,
                          style: AppStyle.baseStyle.copyWith(
                            color: AppColor.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: SvgPicture.asset(
                            "assets/svg/triangle.svg",
                            width: 12,
                            height: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 24.0),
        if (master.updated != null && master.updated!.isNotEmpty)
          Container(
            decoration: BoxDecoration(
                color: AppColor.white90,
                borderRadius: BorderRadius.circular(6)),
            height: 56,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(
              "${'user_to'.tr} ${DateTime.parse(master.created!).year} ${'last_login'.tr} ${DateTime.parse(master.lastLogin!).day.toString().padLeft(2, '0')}.${DateTime.parse(master.lastLogin!).month.toString().padLeft(2, '0')}.${DateTime.parse(master.lastLogin!).year} в ${DateTime.parse(master.lastLogin!).hour.toString().padLeft(2, '0')}:${DateTime.parse(master.lastLogin!).minute.toString().padLeft(2, '0')}",
              textAlign: TextAlign.center,
              style: AppStyle.baseStyle.copyWith(
                color: AppColor.black40,
                fontSize: 14,
              ),
            ),
          ),
        SizedBox(height: 24.0),
      ],
    );
  }
}
