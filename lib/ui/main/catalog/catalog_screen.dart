import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/infinite_scrolling_pagination.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/core/utils/app_style.dart';
import 'package:usta_bor_android/data/model/catalog/tag_response.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/filter_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/no_internet/no_internet.dart';
import 'widgets/advertising_item.dart';
import 'widgets/application_item.dart';
import 'widgets/filter_and_search_view.dart';

class CatalogScreen extends GetView<CatalogController> {
  CatalogScreen({Key? key}) : super(key: key);
  // final CatalogController controller = Get.find<CatalogController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0.2,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(49),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: FilterAndSearchView(
              filter: () {
                Get.bottomSheet(
                  FilterBottomSheet(),
                  isScrollControlled: true,
                );
              },
              search: (String query) {
                controller.setCatalogSelected(false);
               // controller.refreshPage();
                controller.getCatalog(query: query);
                controller.getCatalogCount(query: query);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              tag: (Tag tag) {
             //  controller.clearFilter();

             controller.setTag(tag);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<CatalogController>(
          builder: (value) {
        return value.catalogLoading
            ? Center(
          //SpinKitPouringHourGlass

                child: SpinKitFadingCircle(
                  color: AppColor.green,
                  size: 48,
                  duration: Duration(seconds: 2),
                ),
              )
            : value.noInternet
                ? Center(
                    child: NoInternet(
                      onPressed: () {
                        value.getCatalog();
                        value.getCatalogCount();
                      },
                    ),
                  )
                : value.catalog.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                value.refreshing();
                              },
                              icon: Icon(
                                Icons.refresh,
                                color: AppColor.green,
                                size: 36,
                              )),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "empty_search".tr,
                              style: AppStyle.baseStyle.copyWith(
                                color: AppColor.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    : ModalProgressHUD(
                        inAsyncCall: value.callLoading,
                        color: Colors.transparent,
                        child: InfiniteScrollingPagination(
                          onPagination: value.pagination,
                          isCallLoading: value.pageLoading,
                          child: ListView.builder(
                              itemCount: value.catalog.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (_, index) {
                                if (value.catalog[index].isAd == true) {
                                  return AdvertisingItem(
                                    catalog: value.catalog[index],
                                  );
                                } else {
                                  return ApplicationItem(
                                    catalog: value.catalog[index],
                                  );
                                }
                              }),
                        ),
                      );
      }),
    );
  }
}
