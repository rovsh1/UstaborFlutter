import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/category_price_controller.dart';
import 'package:usta_bor_android/core/custom_widgets/infinite_scrolling_pagination.dart';
import 'package:usta_bor_android/core/custom_widgets/modal_progress_hud.dart';
import 'package:usta_bor_android/ui/main/catalog/widgets/application_item.dart';

import '../../../catalog/widgets/advertising_item.dart';

class MasterTab extends StatelessWidget {
  const MasterTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryPriceController>(builder: (value) {
      return ModalProgressHUD(
        inAsyncCall: value.masterLoading,
        color: Colors.transparent,
        child: InfiniteScrollingPagination(
          onPagination: value.pagination,
          isCallLoading: value.pageLoading,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              physics: BouncingScrollPhysics(),
              itemCount: value.catalog.length,
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
    });
  }
}
