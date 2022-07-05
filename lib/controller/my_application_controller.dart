import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/main/main_page.dart';
import 'package:usta_bor_android/ui/main/my_application/my_application_desription/my_application_detail_screen.dart';

import 'main_controller.dart';

class MyApplicationController extends BaseController {
  // final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  List<MyApplication> _myApplication = [];

  List actionsOptions(bool hasMaster) => [
        if (hasMaster)
          {
            'title': 'hide_application'.tr,
            'icon': 'assets/svg/ic_more.svg',
            'value': 'hide_application',
          },
        {
          'title': 'more'.tr,
          'icon': 'assets/svg/ic_more.svg',
          'value': 'more',
        },
        {
          'title': 'delete'.tr,
          'icon': 'assets/svg/ic_trash.svg',
          'value': 'delete',
        },
      ];

  @override
  void onInit() {
    refreshPage();
    super.onInit();
  }

  @override
  void onReady() {
    refreshPage();
    super.onReady();
  }

  refreshPage() async{
    if (LocalSource.getInstance.hasAccount) {
      await getMyApplications();
    }
    update();
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,300}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }


  Future getMyApplications() async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchMyApplications();
    if (response.data?.status?.message != "error") {
      _myApplication.clear();
      _myApplication = (response.data?.result ?? []);
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    setLoading(false);

    return false;
  }

  Future changeApplicationStatus(int id, String action) async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchApplicationStatus(id: id, action: action);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      if (action == "delete") {
        _myApplication.removeWhere((element) => element.id == id);
      //  Get.find<MyApplicationController>().getMyApplications();
        print("${_myApplication.length}" + "AAAAAA");
        // update();
       // Get.appUpdate();
      }
      else if (action == "close") {
        _myApplication.firstWhere((element) => element.id == id).status = 3;
      }
      Get.offAll(() => MainPage());
      Get.find<MainController>().setIndex(2);

      refreshPage();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
    return;
  }

  List<MyApplication> get myApplication => _myApplication;

  void popUpMenuChoiceHandler(String value, MyApplication application) {
    switch (value) {
      case "more":
        Get.to(()=>MyApplicationDetailScreen(
          application: application,
        ));
        break;
      case "delete":
        changeApplicationStatus(application.id ?? 0, "delete");

        break;
      case "hide_application":
        changeApplicationStatus(application.id ?? 0, "close");
        break;
    }
  }
}
