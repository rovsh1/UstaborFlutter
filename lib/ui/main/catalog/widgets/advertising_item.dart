import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/main/widgets/call_dialog.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/ui/main/catalog/advertising_detail/advertising_detail_screen.dart';

class AdvertisingItem extends StatelessWidget {
  const AdvertisingItem({
    Key? key,
    required this.catalog,
  }) : super(key: key);
  final Catalog catalog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
      child: InkWell(
        onTap: () {
          Get.to(()=>AdvertisingDetail(
            catalog: catalog,
          ));
        },
        borderRadius: BorderRadius.circular(6.0),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              width: 2.0,
              color: AppColor.yellow,
            ),
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
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16.0, right: 8, top: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: CachedNetworkImage(
                        imageUrl: catalog.advertiserAvatar ?? '',
                        height: 64,
                        fit: BoxFit.fill,
                        width: 64,
                        errorWidget: (_, __, ___) {
                          return Image.asset(
                            "assets/png/place_holder2.png",
                            height: 64,
                            width: 64,
                            fit: BoxFit.fill,
                          );
                        },
                        placeholder: (_, __) {
                          return Image.asset(
                            "assets/png/place_holder2.png",
                            height: 64,
                            width: 64,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        catalog.advertiserPresentation ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.baseStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.black40,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: 16,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(6.0),
                          ),
                          color: AppColor.yellow,
                        ),
                        child: Text(
                          'ads'.tr,
                          style: AppStyle.baseStyle.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          callDialog(catalog.advertiserPhone?.replaceAll(' ', ''));
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
                ],
              ),
              SizedBox(
                height: 16,
              ),
              if (catalog.preview != null && catalog.preview!.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: CachedNetworkImage(
                      imageUrl: catalog.preview ?? '',
                      height: 190,
                      fit: BoxFit.fill,
                      width: Get.width - 64,
                      placeholder: (_, __) {
                        return Container(
                          height: 190,
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
                          height: 190,
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
                ),
            ],
          ),
        ),
      ),
    );
  }
}
