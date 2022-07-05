import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_constants.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/top.dart';
import 'package:flutter/services.dart';

class CallBottomSheet extends StatelessWidget {
  final Catalog catalog;

  CallBottomSheet({required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 412 + MediaQuery.of(context).padding.bottom,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Top(
            showFilter: false,
            title: 'master_contact'.tr,
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(500),
                child: CachedNetworkImage(
                  imageUrl: catalog.image ?? '',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  placeholder: (_, __) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.grey100,
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppColor.black40.withOpacity(.3),
                        size: 16,
                      ),
                    );
                  },
                  errorWidget: (_, __, ___) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.grey100,
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppColor.black40.withOpacity(.3),
                        size: 16,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              SizedBox(
                height: 64,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${catalog.presentation}",
                      maxLines: 1,
                      style: AppStyle.baseStyle.copyWith(
                        color: AppColor.black40,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: (catalog.rating ?? 1).toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemSize: 14,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          updateOnDrag: false,
                          itemPadding: EdgeInsets.only(right: 2),
                          itemBuilder: (context, index) => SvgPicture.asset(
                            "assets/svg/star.svg",
                            color: AppColor.starColor,
                          ),
                          unratedColor: AppColor.grey50,
                          onRatingUpdate: (rating) {},
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "${catalog.reviewsCount ?? 0} ",
                              style: AppStyle.baseStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text: 'reviews'.tr,
                                  style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.grey60,
                                    fontSize: 10,
                                  ),
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: (catalog.badges?.where((element) => element > 4 && element < 7).toList() ?? [])
                          .map(
                            (element) => ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppConstants.getBadgeColor(element),
                                ),
                                child: Text(
                                  AppConstants.getBadgeName(element),
                                  style: AppStyle.baseStyle.copyWith(
                                    fontSize: 11,
                                    color: AppColor.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                catalog.phone ?? '',
                style: AppStyle.baseStyle.copyWith(
                  color: AppColor.black40,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    padding: EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      "assets/svg/copy.svg",
                      width: 16,
                      height: 16,
                    ),
                  ),
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: catalog.phone ?? ''));
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 44),
          CustomButton(
            onTap: () async {
              Get.back();
              try {
                await launch('tel:${catalog.phone}');
              } catch (e) {
                print(e);
              }
            },
            text: "call_".tr,
          ),
          SizedBox(
            height: 24,
          ),
          CustomButton(
            onTap: () {
              Get.back(result: true);
            },
            text: "re_call".tr,
            fontColor: AppColor.green,
            backgroundColor: AppColor.white,
          ),
          SizedBox(
            height: 8 + MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }
}
