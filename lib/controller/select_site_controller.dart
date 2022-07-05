import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/data/model/application_create/site_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/application_repository.dart';
import 'package:usta_bor_android/ui/force_update/force_update.dart';
import 'base_controller.dart';

class SelectSiteController extends BaseController {
  List<Site> _site = [];
  Site? _currentSite;
  late ExpandableController _controllerSite;

  @override
  void onInit(){
    _controllerSite = ExpandableController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getSite();
  }

  Future getSite() async {
    _site.clear();
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchSite();
    setLoading(false);
    if (response.data?.status?.code != "error") {
      _site.addAll(response.data?.result ?? []);
      _currentSite = _site.first;
      update();
    }

else if(response.data?.status?.error== 40) {
  Get.to(()=>ForceUpdateScreen());
    }


    else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  List<Site> get site => _site;

  Site? get currentSite => _currentSite;

  ExpandableController get controllerSite => _controllerSite;

  void setSite(Site site) {
    _currentSite = site;
    _controllerSite.toggle();
    update();
  }

  void toggleSite() {
    _controllerSite.toggle();
    update();
  }
}
