import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/data/model/application_create/category_price_response.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/application_repository.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';
import 'base_controller.dart';

class CategoryPriceController extends BaseController with SingleGetTickerProviderMixin {
  List<Catalog> _catalog = [];
  final int categoryId;
  final int siteId;
  double _minPrice = 0;
  double _maxPrice = 0;
  double _averagePrice = 0;
  late TabController tabController;
  bool _masterLoading = false;
  int _pageIndex = 1;
  int catalogCount = 0;
  bool _pageLoading = false;
  final _limit = 10;
  bool _pageEnd = false;

  setMasterLoading(bool value) {
    _masterLoading = value;
    update();
  }

  setPageLoading(bool value) {
    _pageLoading = value;
    update();
  }

  bool get pageLoading => _pageLoading;
  bool get masterLoading => _masterLoading;
  CategoryPriceController({required this.categoryId, required this.siteId});

  Result? _result;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 2);
    getCategoryPrice();
    getCatalog();
  }

  Future getCategoryPrice() async {
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchCategoryPrice(categoryId: categoryId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      _result = response.data?.result;
      try{
        final priceList = _result?.prices?.map((e) => double.parse((e.price ?? 0.0).toString())).toList() ?? [];
        _maxPrice = priceList.reduce(max);
        _minPrice = priceList.reduce(min);
        _averagePrice = priceList.reduce((value, element) => (value + element)) / priceList.length;
      }
      catch(e){
        print(e);
      }
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Result? get result => _result;

  double get minPrice => _minPrice;

  double get maxPrice => _maxPrice;

  double get averagePrice => _averagePrice;

  List<Catalog> get catalog => _catalog;

  Future getCatalog() async {
    _catalog.clear();
    _pageIndex = 0;
    _pageEnd = false;
    _pageLoading = false;
    setMasterLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchCatalog(
      siteId: siteId.toString(),
      categoryId: categoryId.toString(),
      cityId: null,
      sort: null,
      districtId: null,
      query: null,
      limit: _limit,
      page: _pageIndex,
    );

    final response1 = await MainRepository(apiClient: ApiClient.getInstance()).fetchCatalogCount(
      siteId: siteId.toString(),
      categoryId: categoryId.toString(),
      cityId: null,
      districtId: null,
      quickSearch: null,
    );




    setMasterLoading(false);
    if (response.data?.status?.message != "error") {
     // _catalog.addAll((response.data?.result ?? []).where((element) => element.isAd == false));
      _catalog.addAll((response.data?.result ?? []));
      if (((response.data?.result??[]).length) < _limit) {
        _pageEnd = true;
      } else {
        _pageIndex += (response.data?.result ?? []).length;
      //  _pageIndex += (response.data?.result ?? []).length - (response.data?.result ?? []).where((element) => element.isAd == true).length;

      }
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }

    if (response1.data?.status?.message != "error") {
      catalogCount = response1.data?.result?.count ?? 0;
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }


    return;
  }

  pagination() async {
    if (_pageEnd || _pageLoading)
      return;
    setPageLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchCatalog(
      siteId: siteId.toString(),
      categoryId: categoryId.toString(),
      cityId: null,
      sort: null,
      districtId: null,
      query: null,
      limit: _limit,
      page: _pageIndex,
    );
    setPageLoading(false);
    if (response.data?.status?.message != "error") {

      _catalog.addAll(response.data?.result??[]);
      if (((response.data?.result??[]).length) < _limit) {
        _pageEnd = true;
      } else {
        _pageIndex += (response.data?.result ?? []).length;
       // _pageIndex += (response.data?.result ?? []).length - (response.data?.result ?? []).where((element) => element.isAd == true).length;

      }
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  List<String> tabTitle = [
    "price".tr,
    "master".tr,
  ];
  List<String> tabIcon = [
    "assets/svg/wallet.svg",
    "assets/svg/ic_mastera.svg",
  ];
}
