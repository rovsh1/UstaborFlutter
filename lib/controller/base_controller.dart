import 'package:get/get.dart';

class BaseController extends GetxController {
  bool _loading = false;
  bool _noInternet = false;


  setLoading(bool value) {
    _loading = value;
    update();
  }

  bool get loading => _loading;

  setConnection(bool value) {
    _noInternet = value;
    update();
  }

  bool get noInternet => _noInternet;
}
