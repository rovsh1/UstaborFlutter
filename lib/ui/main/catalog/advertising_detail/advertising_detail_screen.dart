import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usta_bor_android/core/custom_widgets/back_button.dart';
import 'package:usta_bor_android/core/custom_widgets/buttons/custom_button.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';

class AdvertisingDetail extends StatelessWidget {
  final Catalog catalog;

  AdvertisingDetail({required this.catalog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: AppColor.white,
      //   leadingWidth: 68,
      //   leading: LeadingButton(),
      // ),
      body: ListView(
        padding: EdgeInsets.all(16),
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 5),
          Row(
            children: [
              SizedBox(
                  width: 70,
                  height: 56,
                  child: LeadingButton())
            ],
          ),
          SizedBox(height: 5),
          if (catalog.preview != null && catalog.preview!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: catalog.preview ?? '',
                height: 240,
                fit: BoxFit.fill,
                width: Get.width - 32,
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
            ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 8),
            child: Text(
              catalog.advertiserAboutLabel ?? '',
              style: AppStyle.baseStyle.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Html(
            data: catalog.advertiserAbout,
          ),
          if (catalog.companyUrl != null && catalog.companyUrl!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 8),
              child: Text(
                'address_company'.tr,
                style: AppStyle.baseStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (catalog.companyUrl != null && catalog.companyUrl!.isNotEmpty)
            TextButton(
                onPressed: () {
                  launch(catalog.companyUrl!);
                },
                style: ButtonStyle(
                  alignment: Alignment.centerLeft,
                ),
                child: Text(
                  catalog.companyUrl!,
                  textAlign: TextAlign.start,
                  style: AppStyle.baseStyle.copyWith(
                    color: AppColor.blue,
                    fontSize: 15,
                  ),
                )),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: catalog.advertiserPhone != null && catalog.advertiserPhone!.isNotEmpty
            ? CustomButton(
                onTap: () {
                  try {
                    UrlLauncher.launch('tel:' + catalog.advertiserPhone!);
                  } catch (e) {
                    print(e);
                  }
                },
                text: catalog.advertiserPhone?.replaceFirst(" ", ''),
              )
            : SizedBox(),
      ),
    );
  }
}
