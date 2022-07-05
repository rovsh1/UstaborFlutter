import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usta_bor_android/core/utils/api_constants.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_constants.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/money_format.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_detail_response.dart';

import '../../../profile/my_masters/feedback_master/feedback_master_screen.dart';

class HideMasterTab extends StatelessWidget {
  final MyApplicationDetail application;

  HideMasterTab({required this.application});

  @override
  Widget build(BuildContext context) {
    final masterList = application.masters!.where((element) => element.status == 3).toList();

    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      separatorBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Divider(
            color: AppColor.grey20,
          ),
        );
      },
      itemBuilder: (_, index) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child:  CachedNetworkImage(
                    imageUrl: "https://www.${ApiConstants.url}/file/" + '${masterList[index].icon ?? ""}/',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 58.0,
                      height: 58.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.person,
                      color: AppColor.black40.withOpacity(.3),
                      size: 16,
                    ),
                  )
                ),
                Expanded(
                  child: SizedBox(
                    height: 72,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "${masterList[index].presentation}",
                            style: AppStyle.baseStyle.copyWith(fontWeight: FontWeight.w600, color: AppColor.black40),
                          ),
                        ),
                        if ((masterList[index].rating ?? 0) > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBar.builder(
                                  initialRating: (masterList[index].rating ?? 0).toDouble(),
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  itemSize: 14,
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.only(right: 2),
                                  itemBuilder: (context, index) => SvgPicture.asset(
                                    "assets/svg/star.svg",
                                    color: AppColor.starColor,
                                  ),
                                  unratedColor: AppColor.grey50,
                                  updateOnDrag: false,
                                  onRatingUpdate: (rating) {},
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "${masterList[index].reviewsCount ?? 0} ",
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
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: (application.masters![index].badges!.where((element) => 4 < element && element < 7))
                                      .map((element) => ClipRRect(
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
                                          ))
                                      .toList(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (int element in (application.masters![index].badges?.where((element) => element > 0 && element < 4).toList() ?? []))
                                      Container(
                                        height: 24,
                                        width: 24,
                                        padding: EdgeInsets.only(left: 0, right: 8, bottom: 8),
                                        child: SvgPicture.asset(
                                          AppConstants.applicationIcons[element - 1],
                                          height: 16,
                                          width: 16,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: !(masterList[index].message ?? '').isEmpty,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: SvgPicture.asset(
                      "assets/svg/detail.svg",
                      height: 16,
                      width: 16,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(child: Html(data: masterList[index].message ?? '')),
                ],
              ),
            ),
            Row(
              children: [
                Visibility(
                  visible: (masterList[index].price ?? 0) != 0,
                  child: Expanded(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/money.svg",
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          formatMoney(masterList[index].price),
                          style: AppStyle.baseStyle.copyWith(
                            color: AppColor.black40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await launch('tel:' + (masterList[index].phone ?? ''));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svg/called.svg",
                        height: 16,
                        width: 16,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        masterList[index].phone??'',
                        style: AppStyle.baseStyle.copyWith(
                          color: AppColor.black40,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: false,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/money.svg",
                          height: 16,
                          width: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          formatMoney(masterList[index].price),
                          style: AppStyle.baseStyle.copyWith(
                            color: AppColor.black40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Visibility(
              visible: masterList[index].feedbackUrl!=null,
                child: InkWell(
                onTap: () {
                  Get.to(() => FeedbackMasterScreen(url:masterList[index].feedbackUrl));
                },
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.darkBlue.withOpacity(.2),
                        offset: Offset(0, 6),
                        blurRadius: 24,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    'leave_feedback'.tr,
                    style: AppStyle.baseStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.black40,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                ),
              ),
            ),
          ],
        );
      },
      itemCount: masterList.length,
    );
  }
}
