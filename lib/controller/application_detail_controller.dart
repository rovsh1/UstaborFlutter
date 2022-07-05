import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/catalog/master_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';

class ApplicationDetailController extends  BaseController with GetSingleTickerProviderStateMixin  {
  Master? _master;
  late ScrollController scrollController;
  late TabController tabController;
  Set categories = {};
  @override
  onInit(){
    scrollController = ScrollController();
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }
  Future getMaster({required int id}) async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchMaster(
      id: id
    );
    setLoading(false);
    if (response.data?.status?.message != "error") {
      _master = response.data?.result;

      _master!.services!.forEach((element) {
        categories.add(element.categoryId);
      });




    }
    return;
  }

  Future<bool> addMyMaster({required int id, required String categoryId}) async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).addMyMaster(
      id: id, categoryId: categoryId,cookies: LocalSource.getInstance.promotedMastersIds
    );
    setLoading(false);
    if (response.data?.status?.code != "error") {
      return true;
    } else {
      return false;
    }
  }

  Master? get master => _master;
}
