import 'package:get/get.dart';
import 'package:usta_bor_android/controller/my_application_controller.dart';
import 'package:usta_bor_android/controller/profile_controller.dart';

class MainController extends GetxController {
  int index = 0;


  void setIndex(int index) {
    this.index = index;
    if(index==2)
    {
      Get.find<MyApplicationController>().refreshPage();
    }
    if(index==3)
    {
      Get.find<ProfileController>().refreshPage();
    }
    if(index==0)
    {
      print("HOME");
       // Get.find<CatalogController>().refresh();
    }

    update();
  }

  void updateProfile() {
    Get.find<ProfileController>().refreshPage();
    update();
  }


  @override
  void onReady() {
    super.onReady();
  }


}
