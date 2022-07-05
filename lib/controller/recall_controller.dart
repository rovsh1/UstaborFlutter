import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/controller/base_controller.dart';
import 'package:usta_bor_android/data/model/catalog/call_date.dart';
import 'package:usta_bor_android/data/model/catalog/re_call_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/auth_repository.dart';

class ReCallController extends BaseController {
  final phoneController = TextEditingController();
  final phoneNode = FocusNode();
  bool _phoneError = false;
  CallDate _date = CallDate.morning;
  bool get phoneError => _phoneError;

  CallDate get date => _date;

  void typePhone() {
    _phoneError = false;
    update();
  }

  reCallMethod(int masterId) async {
    final phone = "+998${phoneController.text.trim().replaceAll(' ', '').replaceAll('-', '')}";
    if (phone.length != 13) {
      _phoneError = true;
      update();
      return;
    } print("CAALDATE");
    print(callDates[_date.index].id);
    setLoading(true);
    final response = await AuthRepository(apiClient: ApiClient.getInstance()).fetchReCall(id: masterId,phone: phone, time: callDates[_date.index].id);
    setLoading(false);
    if (response.data is ReCallResponse && response.data?.status?.code != "error") {
      Get.back();
    } else {
      Get.snackbar("error".tr, response.data?.status?.message ?? "incorrect_login_or_password".tr);
    }
  }

  void changeDate(CallDate callDate) {
    _date = callDate;
    update();
  }
}
