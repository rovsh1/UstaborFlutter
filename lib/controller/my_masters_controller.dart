import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/profile/my_masters_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';
import 'package:get/get.dart';

class MyMastersController extends BaseController {
  // final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>(debugLabel: "MASTER-MUSTAFO-----");
  List<MyMaster> _myMasters = [];

  @override
  void onReady() {
    if (LocalSource.getInstance.hasAccount)
      getMyMasters();
    super.onReady();
  }

  Future getMyMasters() async {
    _myMasters.clear();
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchMyMasters();
    setLoading(false);
    if (response.data?.status?.message != "error") {
      _myMasters.addAll(response.data?.result ?? []);


      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    return;
  }

  List<MyMaster> get myMasters => _myMasters;
}
