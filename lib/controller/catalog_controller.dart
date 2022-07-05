import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/application_create/category_response.dart';
import 'package:usta_bor_android/data/model/application_create/site_response.dart';
import 'package:usta_bor_android/data/model/catalog/badge_response.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/data/model/catalog/city_response.dart';
import 'package:usta_bor_android/data/model/catalog/district_response.dart';
import 'package:usta_bor_android/data/model/catalog/sort.dart';
import 'package:usta_bor_android/data/model/catalog/tag_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/application_repository.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';

import '../ui/force_update/force_update.dart';

class CatalogController extends BaseController {
  List<Catalog> _catalog = [];
   // final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final searchController = TextEditingController();
  final searchFocus = FocusNode();
  int _pageIndex = 0;
  bool _pageLoading = false;
  bool isCategorySelected = false;
  final _limit = 10;
  bool _pageEnd = false;

  List<Catalog> get catalog => _catalog;
  int catalogCount = 0;
  List<Site> _site = [];
  Map<int, List<Category>> _category = Map();
  List<Category> _allCategory = [];
  List<City> _city = [];
  List<Tag> _tag = [];
  Map<int, List<District>> _district = Map();
  List<Badge> _badges = [];
  bool _catalogLoading = false;
  bool _callLoading = false;
  bool _catalogCountLoading = false;

  bool get callLoading => _callLoading;

  setCatalogLoading(bool value) {
    _catalogLoading = value;
    update();
  }


  setCatalogCountLoading(bool value) {
    _catalogCountLoading = value;
    update();
  }
  setCatalogSelected(bool value) {
    isCategorySelected = value;
    update();
  }

  bool get catalogLoading => _catalogLoading;

  bool get catalogCountLoading => _catalogCountLoading;
  Site? _currentSite;
  Category? _currentCategory;
  City? _currentCity;
  District? _currentDistrict;
  Badge? _currentBadge;
  Sort _currentSort = sortData.first;

  bool get hasFilter => _currentCategory != null || _currentCity != null;

  @override
  onReady() async {
    refreshPage();
    super.onReady();
  }

  refreshPage() async {
    _allCategory.clear();
    _site.clear();
    _category.clear();
    _city.clear();
    _tag.clear();
    _badges.clear();
    _district.clear();

    setCatalogLoading(true);
    _allCategory.addAll(await getCategory(sideId: 0));
     _site.insert(0, Site(id: 0, name: "popular".tr));
    getCatalog();
    getCatalogCount();
    getSite();
    getCities();
    getBadge();
  }
  void clearFilter() {
    //final has = hasFilter;


    _site.forEach((element) {
      if (element.id == LocalSource.getInstance.siteId) {
        _currentSite = element;

        print(element);
      }
    });


    _currentCategory = null;
    _currentCity = null;
    _currentDistrict = null;
    _currentBadge = null;
    _currentSort = sortData.first;
   // if (has) {
    getCatalog(query: searchController.text);
    getCatalogCount(query: searchController.text);
  //  }
  }

  setPageLoading(bool value) {
    _pageLoading = value;
    update();
  }

  void setTag(Tag tag) async {

    print("SEARCHING ITEMS: ${tag}");
    print("----------------");
    if (tag.categoryId != null && _allCategory.map((e) => e.id).contains(tag.categoryId)) {
      _currentCategory = _allCategory.firstWhere((element) => element.id == tag.categoryId);
      _currentSite = _site.firstWhere((element) => element.id == _currentCategory?.siteId);
    }
    _currentCity = null;
    _currentDistrict = null;
    searchController.text = "";
    _catalog.clear();
    _pageIndex = 0;
    _pageEnd = false;
    _pageLoading = false;
    getCatalogCount(query: null);
    setCatalogLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchCatalog(
        siteId: _currentSite != null ? _currentSite!.id.toString() : LocalSource.getInstance.siteId.toString(),
        categoryId: tag.categoryId != null
            ? tag.categoryId.toString()
            : _currentCategory?.id != null && _currentCategory?.id != 0
                ? _currentCategory!.id.toString()
                : null,
        cityId: _currentCity?.id.toString(),
        sort: _currentSort.id,
        districtId: _currentDistrict?.id.toString(),
        query: tag.categoryId != null ? null : tag.text,
        limit: _limit,
        page: _pageIndex,
    );
    setCatalogLoading(false);
    if (response.data?.status?.message != "error") {
      print("ADDING");
      // _catalog.addAll(response.data?.result ?? []);
      _catalog.assignAll(response.data?.result ?? []);

      // catalogCount += _catalog.where((element) => element.isAd == true).length;
      if (((response.data?.result ?? []).length) < _limit) {
        _pageEnd = true;
      } else {
        _pageIndex = (response.data?.result ?? []).length - (response.data?.result ?? []).where((element) => element.isAd == true).length;
      }
      print("UPDATE");
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    
    print("MUSTAFO");
    update();
  }

  getCatalog({String? query}) async {
    searchController.text = query ?? "";
    if (_tag.isNotEmpty && _tag.where((element) => element.text == query).isNotEmpty) {
      final tag = _tag.where((element) => element.text == query).first;
      if (tag.categoryId != null && _allCategory.map((e) => e.id).contains(tag.categoryId)) {
        _currentCategory = _allCategory.firstWhere((element) => element.id == tag.categoryId);
        _currentSite = _site.firstWhere((element) => element.id == _currentCategory?.siteId);
        query = "";
      }
    }
    // final hasConnection = await InternetConnectionChecker().hasConnection;
    // setConnection(hasConnection);
    _catalog.clear();
    _pageIndex = 0;
    _pageEnd = false;
    _pageLoading = false;
    getCatalogCount(query: query);
    setCatalogLoading(true);
    print(query);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchCatalog(
        siteId: _currentSite != null ? (_currentSite!.id == 0 && _currentCategory?.siteId!=null) ? _currentCategory!.siteId.toString() : _currentSite!.id.toString() : LocalSource.getInstance.siteId.toString(),
        categoryId:  _currentCategory?.id == 0 ? null : _currentCategory?.id.toString(),
        cityId: _currentCity?.id.toString(),
        sort: _currentSort.id,
        districtId: _currentDistrict?.id.toString() ,
        query: query,
        limit: _limit,
        page: _pageIndex);
    setCatalogLoading(false);
    if (response.data?.status?.message != "error") {
      _catalog.addAll(response.data?.result ?? []);
      // catalogCount += _catalog.where((element) => element.isAd == true).length;
      if (((response.data?.result ?? []).length) < _limit) {
        _pageEnd = true;
      } else {
        _pageIndex = (response.data?.result ?? []).length - (response.data?.result ?? []).where((element) => element.isAd == true).length;
      }

      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  pagination() async {
    print("-----------PAGINATION --------");
    if (_pageEnd || _pageLoading) return;

    setPageLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchCatalog(
      siteId: _currentSite != null ? (_currentSite!.id == 0 && _currentCategory?.siteId!=null) ? _currentCategory!.siteId.toString() : _currentSite!.id.toString() : LocalSource.getInstance.siteId.toString(),
      categoryId: _currentCategory?.id == 0 ? null : _currentCategory?.id.toString(),
      cityId: _currentCity?.id.toString(),
      sort: _currentSort.id,
      districtId: _currentDistrict?.id.toString(),
      query: searchController.text.isEmpty ? null : searchController.text,
      page: _pageIndex,
      limit: _limit,
    );
    setPageLoading(false);
    if (response.data?.status?.message != "error") {
      _catalog.addAll(response.data?.result ?? []);
      if (((response.data?.result ?? []).length) < _limit) {
        _pageEnd = true;
      } else {
        _pageIndex += (response.data?.result ?? []).length - (response.data?.result ?? []).where((element) => element.isAd == true).length;
      }
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  getCatalogCount({String? query}) async {
   // searchController.text = query ?? "";
    setCatalogCountLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchCatalogCount(
      siteId: _currentSite != null ? (_currentSite!.id == 0 && _currentCategory?.siteId!=null) ? _currentCategory!.siteId.toString() : _currentSite!.id.toString() : LocalSource.getInstance.siteId.toString(),
      categoryId: _currentCategory?.id == 0 ? null : _currentCategory?.id.toString(),
      cityId: _currentCity?.id.toString(),
      districtId: _currentDistrict?.id.toString(),
      quickSearch: query,
    );



    setCatalogCountLoading(false);
    if (response.data?.status?.message != "error") {
      catalogCount = response.data?.result?.count ?? 0;
      // catalogCount += _catalog.where((element) => element.isAd == true).length;
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Future getSite() async {
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchSite();
    setLoading(false);
    if (response.data?.status?.code != "error") {
      _site.addAll(response.data?.result ?? []);
      if (_site.isNotEmpty) {
        _site.forEach((element) {
          if (element.id == LocalSource.getInstance.siteId) {
            _currentSite = element;
          }
        });
        getCategory(sideId: _currentSite?.id ?? 0);
      }
      update();
    }

    else if(response.data?.status?.error== 40) {
      Get.to(()=>ForceUpdateScreen());
    }


    else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Future<List<Category>> getCategory({required int sideId}) async {
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchCategory(sideId: sideId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      response.data?.result?.insert(0, Category(name: "all_category".tr, id: 0, icon: ""));
      if (sideId == 0) {
        _category[sideId] = (response.data?.result ?? []).where((element) => (element.index ?? 0) >= 0 && (element.index ?? 0) < 21).toList();
      } else {
        _category[sideId] = response.data?.result ?? [];
      }
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    return response.data?.result ?? [];
  }

  Future getCities() async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchCities();
    setLoading(false);
    if (response.data?.status?.message != "error") {
      response.data?.result?.insert(0, City(name: "all_city".tr, id: 0));
      _city.addAll(response.data?.result ?? []);
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Future getDistrict({required int cityId}) async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchDistricts(cityId: cityId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      response.data?.result?.insert(0, District(name: "all_district".tr, id: 0));
      _district[cityId] = (response.data?.result ?? []);
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Future<List<Tag>> getTags({required String search}) async {
    print('-----GET TAGS------');
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchTags(search: search);
    if (response.data?.status?.message != "error") {
      _tag = response.data?.result ?? [];
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    return _tag;
  }

  Future getBadge() async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchBadges();
    setLoading(false);
    if (response.data?.status?.message != "error") {
      _badges.addAll(response.data?.result ?? []);
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  bool get pageLoading => _pageLoading;

  List<Site> get site => _site;

  List<Category> get category => _category[_currentSite?.id ?? 0] ?? [];

  List<Category> get allCategory => _allCategory;

  List<Tag> get tag => _tag;

  List<City> get city => _city;

  List<District> get district => _district[_currentCity?.id ?? 0] ?? [];

  List<Badge> get badges => _badges;

  Site? get currentSite => _currentSite;

  Category? get currentCategory => _currentCategory;

  City? get currentCity => _currentCity;

  District? get currentDistrict => _currentDistrict;

  Badge? get currentBadge => _currentBadge;

  Sort get currentSort => _currentSort;

  void setSite(Site site) {
    _currentSite = site;
    if (!_category.containsKey(site.id)) {
      getCategory(sideId: site.id ?? 0);
    }
    update();
  }

  void setCategory(Category category) {
    _currentCategory = category;
    update();
  }

  void setCity(City city) {
    _currentCity = city;
    if (!_district.containsKey(city.id)) {
      getDistrict(cityId: city.id ?? 0);
    }
    update();
  }

  void setDistrict(District district) {
    _currentDistrict = district;
    update();
  }

  void setBadge(Badge badge) {
    _currentBadge = badge;
    update();
  }

  void setSort(Sort sort) {
    _currentSort = sort;
    update();
  }



  Future<bool> addMyMaster({required int id, required String categoryId}) async {
    _callLoading = true;
    update();

    print(LocalSource.getInstance.promotedMastersIds);

    final response = await MainRepository(apiClient: ApiClient.getInstance()).addMyMaster(
        id: id, categoryId: isCategorySelected?categoryId:"",cookies: LocalSource.getInstance.promotedMastersIds
    );
    _callLoading = false;
    update();
    if (response.data?.status?.code != "error") {
      print(response.data?.status?.code );
      return true;
    } else {
      return false;
    }
  }

  void refreshing() {
    clearFilter();
    searchController.clear();
    getCatalog();
    getCatalogCount();

    update();

  }
}
