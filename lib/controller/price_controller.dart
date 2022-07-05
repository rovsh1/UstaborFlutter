import 'package:get/get.dart';
import 'package:usta_bor_android/data/model/application_create/category_response.dart';
import 'package:usta_bor_android/data/model/application_create/site_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/application_repository.dart';
import '../core/data_sources/local/local_source.dart';
import '../ui/force_update/force_update.dart';
import 'base_controller.dart';

class PriceController extends BaseController {
  List<Site> _site = [];
  Map<int, List<Category>> _category = Map();
  Site? _currentSite;

  @override
  void onReady() {
    getSite();
    super.onReady();
  }

  Future getSite() async {
    _site.clear();
    setLoading(true);


    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchSite();
    setLoading(false);
    if (response.data?.status?.code != "error") {
      _site.addAll(response.data?.result ?? []);
      _site.insert(0, Site(id: 0, name: "popular".tr));
      if (_site.isNotEmpty) {
        _currentSite = _site.first;
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

  Future getCategory({required int sideId}) async {
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchCategory(sideId: sideId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      if (sideId == 0) {
        _category[sideId] = (response.data?.result ?? []).where((element) => (element.index ?? 0) >= 0 && (element.index ?? 0) < 21).toList();
      } else {
        _category[sideId] = response.data?.result ?? [];
      }
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  List<Site> get site => _site;

  List<Category> get category => _category[_currentSite?.id] ?? [];

  Site? get currentSite => _currentSite;

  void setSite(Site site) {
    _currentSite = site;
    //if (!_category.containsKey(site.id)) {
      getCategory(sideId: site.id ?? 0);
   // }
    update();
  }
}
