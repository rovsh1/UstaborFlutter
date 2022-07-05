import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_detail_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';
import 'package:get/get.dart';

import 'my_application_controller.dart';

class MyApplicationDetailController extends BaseController with SingleGetTickerProviderMixin{
  late TabController tabController1;
  late TabController tabController2;
  MyApplicationDetail? _applicationDetail;

  @override
  void onInit() {
    tabController1 = TabController(vsync: this, length: 2);
    tabController2 = TabController(vsync: this, length: 3);
    super.onInit();
  }

  int _currentSegment = 1;

  void onValueChanged(int newValue,int id) {
    if(_applicationDetail?.masters?.isNotEmpty??false){
      _currentSegment = newValue;
      if(_currentSegment==0) {
        MainRepository(apiClient: ApiClient.getInstance()).getCustomerMasters(id: id);
        Get.find<MyApplicationController>().refreshPage();
      }
      update();
    }
  }

  Future changeApplicationMasterStatus(int id, int masterId, String action) async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchApplicationMasterStatus(id: id, action: action, masterId: masterId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      getMyApplicationDetail(id);
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    return;
  }


  Future getMyApplicationDetail(int id) async {
    setLoading(true);

    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchMyApplicationDetail(id: id);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      _applicationDetail = response.data?.result;
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    return;
  }

  List<String> tabTitle1 = [
    "actives".tr,
    "hide".tr,
  ];

  List<String> tabTitle2 = [
    "task".tr,
    "time_price".tr,
    "work_place".tr,
  ];

  int get currentSegment => _currentSegment;
  MyApplicationDetail? get applicationDetail => _applicationDetail;

  void hideMaster(int id, int masterId) {
    changeApplicationMasterStatus(id, masterId, "hide");
  }
}
