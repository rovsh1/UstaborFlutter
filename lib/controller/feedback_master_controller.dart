import 'package:flutter/material.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/main_repository.dart';
import 'package:get/get.dart';

import 'my_masters_controller.dart';

class FeedbackMasterController extends BaseController {
  double _ratingMaster = 0;
  double _ratingApp = 0;
  final masterNode = FocusNode();
  final priceNode = FocusNode();
  final appNode = FocusNode();
  final masterController = TextEditingController();
  final priceController = TextEditingController();
  final appController = TextEditingController();
  bool _masterError = false;
  bool _priceError = false;
  bool _appError = false;

  feedbackMaster() async {
    setLoading(true);
    final response = await MainRepository(apiClient: ApiClient.getInstance()).fetchMyMasters();
    setLoading(false);
    if (response.data?.status?.message != "error") {
      Get.find<MyMastersController>().getMyMasters();
      Get.back();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  void updateRatingMaster(double rating) {
    _ratingMaster = rating;
    update();
  }

  void updateRatingApp(double rating) {
    _ratingApp = rating;
    update();
  }

  double get ratingMaster => _ratingMaster;

  double get ratingApp => _ratingApp;

  bool get masterError => _masterError;

  bool get priceError => _priceError;

  bool get appError => _appError;
}
