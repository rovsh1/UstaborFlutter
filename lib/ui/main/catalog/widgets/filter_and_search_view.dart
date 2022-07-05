import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/data/model/catalog/tag_response.dart';

class FilterAndSearchView extends StatelessWidget {
  final Function filter, search, tag;

  FilterAndSearchView({required this.filter, required this.search, required this.tag});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatalogController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  filter();
                },
                borderRadius: BorderRadius.circular(24),
                child: Ink(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.darkBlue.withOpacity(.2),
                        offset: Offset(0, 6),
                        blurRadius: 24,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Badge(
                    position: BadgePosition(
                      top: 0,
                      end: 0,
                    ),
                    badgeContent: Center(
                      child: SizedBox(
                        height: 2,
                        width: 2,
                      ),
                    ),
                    toAnimate: true,
                    elevation: 0,
                    badgeColor: controller.hasFilter ? AppColor.lightRed : Colors.transparent,
                    child: SvgPicture.asset(
                      "assets/svg/filter.svg",
                      height: 22,
                      width: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Container(
                height: 48,
                width: Get.width - 96,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.darkBlue.withOpacity(.2),
                      offset: Offset(0, 6),
                      blurRadius: 24,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 1),
                        child: TypeAheadField<Tag>(
                          keepSuggestionsOnLoading: false,
                          hideOnLoading: true,
                          hideOnEmpty: true,
                          hideOnError: true,
                          loadingBuilder: (_) => SizedBox(),
                          textFieldConfiguration: TextFieldConfiguration(
                            textAlign: TextAlign.start,
                            focusNode: controller.searchFocus,
                            controller: controller.searchController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            onSubmitted: (value) {
                              search(value);
                            },
                            enableSuggestions: true,
                            onChanged: (value) {},
                            style: AppStyle.baseStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColor.black40,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 16, top: 12),
                                hintText: 'quick_search'.tr,
                                hintStyle: AppStyle.baseStyle.copyWith(
                                  color: AppColor.black40.withOpacity(.5),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                border: InputBorder.none,
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Visibility(
                                      visible: controller.searchController.text.isNotEmpty,
                                      child: InkWell(
                                        onTap: () {
                                          controller.searchController.clear();
                                          controller.setCatalogSelected(false);
                                          search("");
                                        },
                                        borderRadius: BorderRadius.circular(24),
                                        child: Ink(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/svg/clear.svg',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (controller.searchController.text.trim().isNotEmpty) {
                                            search(controller.searchController.text);
                                          }
                                        },
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 8),
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            color: AppColor.green,
                                          ),
                                          child: Icon(
                                            Icons.search,
                                            size: 20,
                                            color: AppColor.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                          suggestionsBoxDecoration: SuggestionsBoxDecoration(
                            color: AppColor.white,
                            hasScrollbar: true,
                            constraints: BoxConstraints(
                              maxHeight: 300,
                            ),
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suggestionsCallback: (pattern) async {
                            if (pattern.length == 0) return [];
                            return await controller.getTags(search: pattern);
                          },
                          debounceDuration: Duration(seconds: 1),
                          itemBuilder: (context, Tag tag) {
                            return SizedBox(
                              height: 40,
                              child: Container(
                                padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                child: Text(
                                  tag.text ?? '',
                                  style: AppStyle.baseStyle.copyWith(
                                    fontSize: 14,
                                    color: AppColor.black40,
                                  ),
                                ),
                              ),
                            );
                          },
                          onSuggestionSelected: (Tag value) {
                            tag(value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(controller.hasFilter ? 'results'.tr : "all_masters".tr,
                  style: AppStyle.baseStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(
                width: 8,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: AppColor.grey100),
                child: controller.catalogCountLoading
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: AppColor.black,
                                strokeWidth: 2,
                              )
                            : Theme(
                                data: ThemeData(
                                  cupertinoOverrideTheme: CupertinoThemeData(),
                                ),
                                child: CupertinoActivityIndicator(radius: 8, animating: true),
                              ),
                      )
                    : Text(
                  controller.catalog.length%10==0? '${controller.catalogCount}':"${controller.catalog.length}",
                        style: AppStyle.baseStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: AppColor.black40),
                      ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
