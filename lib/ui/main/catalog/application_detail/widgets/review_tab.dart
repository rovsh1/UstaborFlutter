import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/master_response.dart';

class ReviewTab extends StatelessWidget {
  final Master master;

  ReviewTab({
    required this.master,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      physics: BouncingScrollPhysics(),
      children: [
        for (int index = 0; index < master.reviews!.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: CachedNetworkImage(
                        imageUrl: master.reviews![index].image ?? '',
                        width: 40,
                        height: 40,
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
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            master.reviews![index].name ?? '',
                            maxLines: 1,
                            style: AppStyle.baseStyle.copyWith(
                              color: AppColor.black40,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                (master.reviews![index].date ?? '').replaceAll("-", '.'),
                                maxLines: 1,
                                style: AppStyle.baseStyle.copyWith(
                                  color: AppColor.grey90,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              RatingBar.builder(
                                initialRating: (master.reviews![index].rating ?? 0).toDouble(),
                                minRating: 0,
                                direction: Axis.horizontal,
                                itemSize: 14,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.only(right: 2),
                                updateOnDrag: false,
                                itemBuilder: (context, index) => SvgPicture.asset(
                                  "assets/svg/star.svg",
                                  color: AppColor.starColor,
                                ),
                                unratedColor: AppColor.grey50,
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (master.reviews![index].text != null && master.reviews![index].text!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Html(
                        data: master.reviews![index].text ?? '',
                      )
                    ],
                  ),
              ],
            ),
          ),
        for (int index = 0; index < master.feedbacks!.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: CachedNetworkImage(
                        imageUrl: master.feedbacks![index].userAvatar ?? '',
                        width: 40,
                        height: 40,
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
                    SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      height: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            master.feedbacks![index].userPresentation ?? '',
                            maxLines: 1,
                            style: AppStyle.baseStyle.copyWith(
                              color: AppColor.black40,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                (master.feedbacks![index].created ?? '').split(" ").first.replaceAll("-", '.'),
                                maxLines: 1,
                                style: AppStyle.baseStyle.copyWith(
                                  color: AppColor.grey90,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              RatingBar.builder(
                                initialRating: (master.feedbacks![index].rating ?? 0).toDouble(),
                                minRating: 0,
                                direction: Axis.horizontal,
                                itemSize: 14,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.only(right: 2),
                                updateOnDrag: false,
                                itemBuilder: (context, index) => SvgPicture.asset(
                                  "assets/svg/star.svg",
                                  color: AppColor.starColor,
                                ),
                                unratedColor: AppColor.grey50,
                                onRatingUpdate: (rating) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (master.feedbacks![index].comment != null && master.feedbacks![index].comment!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      Html(
                        data: master.feedbacks![index].comment ?? '',
                      )
                    ],
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
