import 'dart:ui';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/controller/my_application_controller.dart';
import 'package:usta_bor_android/controller/price_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/profile/profile_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/auth_repository.dart';
import 'base_controller.dart';

class ProfileController extends BaseController{
  Profile? profile;
  String _lang = Get.locale.toString();
  String _avatar = LocalSource.getInstance.avatar;
  String get avatar => _avatar;
  //Profile? get profile => _profile;
  setImage(String image){
    _avatar = image;
    profile?.image = image;
    update();
  }

  get lang => _lang;

  void setLang(String value) async {
    _lang = value;
    await LocalSource.getInstance.setLocale(value);
    Get.updateLocale(Locale(value));
    Get.find<CatalogController>().refreshPage();
    Get.find<MyApplicationController>().refreshPage();
    Get.find<PriceController>().getSite();
    update();
    Get.back();
  }

  @override
  void onInit(){
    profile = Profile(
      name: LocalSource.getInstance.username,
      image: LocalSource.getInstance.avatar,
      id: LocalSource.getInstance.userId,
      phone: LocalSource.getInstance.phone,
      presentation: LocalSource.getInstance.username,
    );
    getProfile();
    super.onInit();
  }
  @override
  void onReady() {

   // getProfile();
    super.onReady();
  }

  refreshPage() async{
    if (LocalSource.getInstance.hasAccount) {
      await getProfile();
      print("REFRESH-----");
      // update();
    }
  }


  Future getProfile() async {
    print('---GET PROFILE------->>>>');
    if(LocalSource.getInstance.hasAccount){
      setLoading(true);
      final response = await AuthRepository(apiClient: ApiClient.getInstance()).fetchProfile();
      setLoading(false);
      if (response.data?.status?.message != "error") {
        profile = response.data?.result;

        await LocalSource.getInstance.setAccount(accessToken: LocalSource.getInstance.accessToken, phone: response.data?.result?.phone??'', username: response.data?.result?.presentation??'', userId: LocalSource.getInstance.userId, avatar: response.data?.result?.image ?? '');
        await LocalSource.getInstance.setFeedBack(response.data?.result?.feedback??"");
        update();
      } else {
        Get.snackbar('error'.tr, 'error_text'.tr);
      }
    }
  }


}
