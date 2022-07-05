import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/recall_bottom_sheet.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_constants.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/money_format.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/main/catalog/application_detail/application_detail_screen.dart';

import 'call_bottom_sheet.dart';
import 'login_bottom_sheet.dart';

class ApplicationItem extends StatelessWidget {
  ApplicationItem({
    Key? key,
    required this.catalog,
  }) : super(key: key);

  final Catalog catalog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: InkWell(
        onTap: () async {
          Get.to(() => ApplicationDetailScreen(catalog: catalog));
        },
        borderRadius: BorderRadius.circular(6.0),
        child: Ink(
          padding: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.darkBlue.withOpacity(.2),
                offset: Offset(0, 6),
                blurRadius: 24,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: CachedNetworkImage(
                        width: 64,
                        height: 64,
                        imageUrl: catalog.image ?? '',
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
                        height: 72,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "${catalog.presentation}",
                                overflow: TextOverflow.ellipsis,
                                style: AppStyle.baseStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.black40),
                              ),
                            ),
                            if (catalog.rating > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RatingBar.builder(
                                      initialRating:
                                          (catalog.rating ?? 1).toDouble(),
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      itemSize: 14,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.only(right: 2.0),
                                      itemBuilder: (context, index) =>
                                          SvgPicture.asset(
                                        "assets/svg/star.svg",
                                        color: AppColor.starColor,
                                      ),
                                      unratedColor: AppColor.grey50,
                                      updateOnDrag: false,
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
                                              style:
                                                  AppStyle.baseStyle.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.grey60,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: (catalog.badges
                                            ?.where((element) =>
                                                element > 4 && element < 7)
                                            .toList() ??
                                        [])
                                    .map((element) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: AppConstants.getBadgeColor(
                                                  element),
                                            ),
                                            child: Text(
                                              AppConstants.getBadgeName(
                                                  element),
                                              style:
                                                  AppStyle.baseStyle.copyWith(
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
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (LocalSource.getInstance.hasAccount) {

                         var res = await Get.find<CatalogController>().addMyMaster(
                              id: catalog.id ?? 0,
                              categoryId: catalog.categoryId.toString());
if(res){

  final result = await Get.bottomSheet(
    CallBottomSheet(
      catalog: catalog,
    ),
    isScrollControlled: true,
  );
  if (result == true) {
    Get.bottomSheet(
      ReCallBottomSheet(
        catalog: catalog,
      ),
      isScrollControlled: true,
    );
  }
}
else {
  Get.snackbar("error".tr, "Вы нажали кнопку \"контакты\" более 8 раз. Если Вам так и не удалось найти мастера, пожалуйста, оставьте заявку или свяжитесь с нами. Мы сами подберем для Вас проверенных специалистов".tr);
}

                        }

                        else if(catalog.promotion!=null){
                          var mastersIds = LocalSource.getInstance.promotedMastersIds;

                            var res = await Get.find<CatalogController>().addMyMaster(
                                id: catalog.id ?? 0,
                                categoryId:mastersIds.contains(catalog.id)?"": catalog.categoryId.toString());



                            if(res){
                              if(!mastersIds.contains(catalog.id)) {
                                mastersIds.add(catalog.id!.toInt());
                                LocalSource.getInstance.setPromotedMasters(mastersIds);
                              }



                              final result = await Get.bottomSheet(
                                CallBottomSheet(
                                  catalog: catalog,
                                ),
                                isScrollControlled: true,
                              );
                              if (result == true) {
                                Get.bottomSheet(
                                  ReCallBottomSheet(
                                    catalog: catalog,
                                  ),
                                  isScrollControlled: true,
                                );
                              }
                            }
                            else {
                              Get.snackbar("error".tr, "Вы нажали кнопку \"контакты\" более 8 раз. Если Вам так и не удалось найти мастера, пожалуйста, оставьте заявку или свяжитесь с нами. Мы сами подберем для Вас проверенных специалистов".tr);
                            }
                        }

                        // else if(catalog.promotion!=null) {
                        //   final result = await Get.bottomSheet(
                        //     CallBottomSheet(
                        //       catalog: catalog,
                        //     ),
                        //     isScrollControlled: true,
                        //   );
                        //   if (result == true) {
                        //     Get.bottomSheet(
                        //       ReCallBottomSheet(
                        //         catalog: catalog,
                        //       ),
                        //       isScrollControlled: true,
                        //     );
                        //   }
                        // }
                        //
                        else {
                           await Get.bottomSheet(
                            LoginBottomSheet(),
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
              ),
              SizedBox(height: catalog.categories!.isNotEmpty ? 16 : 0),
              SizedBox(
                height: catalog.categories!.isNotEmpty ? 32 : 0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, index) {
                    return SizedBox(
                      width: 8,
                    );
                  },
                  itemBuilder: (_, index) {
                    return Container(
                      height: 32,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColor.grey80,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "${Get.find<CatalogController>().allCategory.where((element) => element.id == catalog.categories![index]).isNotEmpty ? Get.find<CatalogController>().allCategory.where((element) => element.id == catalog.categories![index]).first.name : ""}",
                          style: AppStyle.baseStyle.copyWith(
                            color: AppColor.black40.withOpacity(.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: catalog.categories!.length,
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: catalog.services!.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: (catalog.services!.length > 3
                                ? catalog.services!.getRange(0, 3)
                                : catalog.services!)
                            .map(
                          (e) {
                            TextSelection selection = TextSelection(
                                baseOffset: 0,
                                extentOffset: (e.name ?? '').length);
                            final tp = TextPainter(
                                text: TextSpan(
                                  text: e.name ?? "",
                                  style: AppStyle.baseStyle.copyWith(
                                    color: AppColor.black40,
                                    fontSize: 11,
                                  ),
                                ),
                                maxLines: 3,
                                textDirection: TextDirection.ltr);
                            tp.layout(maxWidth: Get.width - 200);
                            List<TextBox> boxes =
                                tp.getBoxesForSelection(selection);
                            int numberOfLines = boxes.length;
                            return Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: Get.width - 200),
                                      child: Text(
                                        e.name ?? '',
                                        maxLines: numberOfLines,
                                        style: AppStyle.baseStyle.copyWith(
                                          color: AppColor.black40,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: numberOfLines == 1
                                          ? Text(
                                              "....................................................................................................",
                                              style:
                                                  AppStyle.baseStyle.copyWith(
                                                color: AppColor.black40
                                                    .withOpacity(0.3),
                                                fontSize: 11,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            )
                                          : SizedBox(),
                                    ),
                                    Text(
                                      "  ${'from'.tr} ${formatMoney(double.tryParse((e.price ?? '0').toString()))}",
                                      style: AppStyle.baseStyle.copyWith(
                                        color: AppColor.black40,
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        ).toList(),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: AppColor.white90,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 0,
                        child: Center(
                            child: Text("no_price_master".tr,
                                textAlign: TextAlign.center,
                                style: AppStyle.baseStyle.copyWith(
                                    color: AppColor.black40.withOpacity(.5)))),
                      ),
              ),
              SizedBox(height: catalog.services!.isEmpty ? 0 : 16),
              catalog.projects!.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColor.white90,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      margin: EdgeInsets.only(left: 16, right: 16),
                      height: 0,
                      child: Center(
                          child: Text("no_photo_master".tr,
                              textAlign: TextAlign.center,
                              style: AppStyle.baseStyle.copyWith(
                                  color: AppColor.black40.withOpacity(.5)))),
                    )
                  : SizedBox(
                      height: 64,
                      child: ListView.separated(
                        separatorBuilder: (_, index) {
                          return SizedBox(
                            width: 8,
                          );
                        },
                        itemCount: catalog.projects!.length < 4
                            ? 4
                            : catalog.projects!.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          left: 16,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          if (catalog.projects!.length > index)
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: CachedNetworkImage(
                                imageUrl: catalog.projects![index].image ?? '',
                                height: 64,
                                width: (Get.width - 88) / 3,
                                fit: BoxFit.cover,
                                placeholder: (_, __) {
                                  return Container(
                                    height: 64,
                                    width: (Get.width - 80) / 3,
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
                                    height: 64,
                                    width: (Get.width - 80) / 3,
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
                          return Container(
                            height: 64,
                            width: (Get.width - 80) / 3,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: AppColor.white,
                                ),
                                color: AppColor.white90),
                            child: Center(
                              child: Container(
                                height: 64,
                                width: (Get.width - 80) / 3,
                                color: AppColor.white90,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              SizedBox(
                height: catalog.services!.isEmpty && catalog.projects!.isEmpty
                    ? 0
                    : 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
