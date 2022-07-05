import 'package:get/get.dart';
import 'package:usta_bor_android/controller/application_controller.dart';
import 'package:usta_bor_android/controller/catalog_controller.dart';
import 'package:usta_bor_android/controller/edit_profile_controller.dart';
import 'package:usta_bor_android/controller/feedback_master_controller.dart';
import 'package:usta_bor_android/controller/main_controller.dart';
import 'package:usta_bor_android/controller/my_application_controller.dart';
import 'package:usta_bor_android/controller/my_application_detail_controller.dart';
import 'package:usta_bor_android/controller/my_masters_controller.dart';
import 'package:usta_bor_android/controller/price_controller.dart';
import 'package:usta_bor_android/controller/profile_controller.dart';
import 'package:usta_bor_android/controller/recall_controller.dart';
import 'package:usta_bor_android/controller/restore_password_controller.dart';
import 'package:usta_bor_android/controller/select_site_controller.dart';
import 'package:usta_bor_android/controller/sign_in_controller.dart';
import 'package:usta_bor_android/controller/sign_up_controller.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );
    Get.lazyPut<SelectSiteController>(
      () => SelectSiteController(),
      fenix: true,
    );
    Get.lazyPut<ApplicationController>(
      () => ApplicationController(),
      fenix: true,
    );
    Get.lazyPut<MyApplicationController>(
      () => MyApplicationController(),
      fenix: true,
    );
    Get.lazyPut<MyApplicationDetailController>(
      () => MyApplicationDetailController(),
      fenix: true,
    );
    Get.lazyPut<PriceController>(
      () => PriceController(),
      fenix: true,
    );
    Get.lazyPut<CatalogController>(
      () => CatalogController(),
      fenix: true,
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
      fenix: true,
    );
    Get.lazyPut<ReCallController>(
      () => ReCallController(),
      fenix: true,
    );
    Get.lazyPut<SignInController>(
      () => SignInController(),
      fenix: true,
    );
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
      fenix: true,
    );
    Get.lazyPut<RestorePasswordController>(
      () => RestorePasswordController(),
      fenix: true,
    );
    Get.lazyPut<MyMastersController>(
      () => MyMastersController(),
      fenix: true,
    );
    Get.lazyPut<FeedbackMasterController>(
      () => FeedbackMasterController(),
      fenix: true,
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
      fenix: true,
    );
  }
}
