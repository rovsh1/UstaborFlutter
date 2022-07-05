import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/api_constants.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/data/model/profile/my_masters_response.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/call_bottom_sheet.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/recall_bottom_sheet.dart';
import 'package:usta_bor_android/ui/main/profile/my_masters/feedback_master/feedback_master_screen.dart';

class MyMasterItem extends StatelessWidget {
  const MyMasterItem({
    Key? key,
    required this.master,
  }) : super(key: key);
  final MyMaster master;

  @override
  Widget build(BuildContext context) {
    print(master.feedbackUrl.toString());
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: CachedNetworkImage(
                  width: 40,
                  height: 40,
                  imageUrl: master.image ?? '',
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
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                         master.presentation.toString(),
                          // "${master.name} ${master.surname}",
                          style: AppStyle.baseStyle.copyWith(fontWeight: FontWeight.w600, color: AppColor.black40),
                        ),
                      ),
                      if ((master.rating ?? 0) > 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RatingBar.builder(
                                initialRating: (master.rating ?? 0).toDouble(),
                                minRating: 0,
                                direction: Axis.horizontal,
                                itemSize: 14,
                                unratedColor: AppColor.grey50,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.only(right: 2),
                                itemBuilder: (context, index) => SvgPicture.asset(
                                  "assets/svg/star.svg",
                                  color: AppColor.starColor,
                                ),
                                updateOnDrag: false,
                                onRatingUpdate: (rating) {},
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "${master.reviewsCount ?? 0} ",
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
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  final categoryId = master.categories!.isNotEmpty ? master.categories!.first.toString: "";
                  final subdomain = LocalSource.sitedomains[master.siteId ?? 1];
                  Share.share('https://${subdomain}.${ApiConstants.url}/catalog/view/${master.id}');
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 48.0,
                  width: 48.0,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.green,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.darkBlue.withOpacity(.2),
                        offset: Offset(0, 6),
                        blurRadius: 24,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svg/download.svg",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: () async {
                  final result = await Get.bottomSheet(
                    CallBottomSheet(
                      catalog: Catalog(
                        image: master.image,
                        presentation: master.presentation,
                        rating: master.rating,
                        reviewsCount: master.reviewsCount,
                        badges: [],
                        phone: master.phone?.replaceAll(' ', ''),
                      ),
                    ),
                    isScrollControlled: true,
                  );
                  if (result == true) {
                    Get.bottomSheet(
                      ReCallBottomSheet(
                        catalog: Catalog(
                          id: master.id,
                          phone: master.phone?.replaceAll(' ', ''),
                        ),
                      ),
                      isScrollControlled: true,
                    );
                  }
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 48.0,
                  width: 48.0,
                  decoration: BoxDecoration(
                    color: AppColor.green,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.darkBlue.withOpacity(.2),
                        offset: Offset(0, 6),
                        blurRadius: 24,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/svg/contacts.svg",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Visibility(
            visible: master.feedbackUrl!=null,
            child: CustomButton(
              onTap: () {
                Get.to(()=>FeedbackMasterScreen(
                  url:  master.feedbackUrl  // master: master,
                ));
              },
              boxShadow: [
                BoxShadow(
                  color: AppColor.darkBlue.withOpacity(.2),
                  offset: Offset(0, 6),
                  blurRadius: 24,
                  spreadRadius: 0,
                ),
              ],
              fontColor: AppColor.black40,
              backgroundColor: AppColor.white,
              text: "leave_feedback".tr,
            ),
          )
        ],
      ),
    );
  }
}
