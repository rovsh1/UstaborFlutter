import 'dart:async';
import 'dart:io';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usta_bor_android/controller/profile_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/application_create/answer_response.dart';
import 'package:usta_bor_android/data/model/application_create/category_response.dart';
import 'package:usta_bor_android/data/model/application_create/date.dart';
import 'package:usta_bor_android/data/model/application_create/service_response.dart';
import 'package:usta_bor_android/data/model/application_create/site_response.dart';
import 'package:usta_bor_android/data/model/auth/phone_confirm_response.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';
import 'package:usta_bor_android/data/repository/application_repository.dart';
import 'package:usta_bor_android/data/repository/auth_repository.dart';
import '../ui/force_update/force_update.dart';
import 'base_controller.dart';

class ApplicationController extends BaseController {
  late ExpandableController _controllerSite;
  late ExpandableController _controllerCategory;
  late ExpandableController _controllerService;
  late ExpandableController _controllerAnswer;
  late ExpandableController _controllerDate;
  final _pageController = PageController(initialPage: 0);
  final nameController = TextEditingController();
  final noteController = TextEditingController();
  final codeController = TextEditingController();
  final priceController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final addressNoteController = TextEditingController();
  final textController = TextEditingController();
  final nameNode = FocusNode();
  final priceNode = FocusNode();
  final addressNode = FocusNode();
  final addressNoteNode = FocusNode();
  final phoneNode = FocusNode();
  final textNode = FocusNode();
  final dateTime = DateTime.now();
  bool _currentSiteError = false;
  bool _currentDateError = false;
  bool _addressError = false;
  bool _nameError = false;
  bool _noteError = false;
  bool _phoneError = false;
  bool _codeError = false;
  bool _success = false;
  String _phoneNumber = '';
  String _verificationCode = '';
  double _startPrice = 0;
  double _endPrice = 1500000;
  bool _currentCategoryError = false;
  ApplicationDateData _currentDate = ApplicationDateData(text: "", id: "-1");
  Site _currentSite = Site(name: "no_select".tr, id: -1);
  Category _currentCategory = Category(id: -1, name: "no_select".tr);
  Service _currentService = Service(name: "no_select".tr, id: -1);
  Answer _currentAnswer = Answer(id: -1, name: "no_select".tr);
  Map<Answer, List<Answer>> _answers = Map();
  List<ExpandableController> _answersExpendableController = [];
  List<Answer> _currentAnswers = [];
  final _picker = ImagePicker();
  List<XFile> _imageFileList = <XFile>[];
  dynamic _pickImageError;
  XFile? _selectedImage;

  bool isTime = false;

  Timer? _timer;
  int start = 60;
  // var oneSec = const Duration(seconds: 1);
  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    } else {
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) {
          if (start < 2) {
            isTime = true;
            _timer!.cancel();
            _timer = null;
            update();
          } else {
            start = start - 1;
            update();
          }
        },
      );
    }
  }


  List<XFile> get getImageList => _imageFileList;

  XFile? get getSelectedImage => _selectedImage;

  dynamic get getError => _pickImageError;

  Future<void> onPickImagePressed(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(source: source, imageQuality: 50);
      if (pickedImage != null) {
        _imageFileList.add(pickedImage);
        _selectedImage = pickedImage;
      }
    } catch (e) {
      _pickImageError = e;
    }

    update();
  }

  removeImage(XFile file) {
    _imageFileList.remove(file);
    update();
  }

  ApplicationDate _date = ApplicationDate.today;
  List<Site> _site = [];
  List<Category> _category = [];
  List<Service> _service = [];
  List<Answer> _answer = [];

  bool get success => _success;

  @override
  void onInit() {
    super.onInit();
    _controllerSite = ExpandableController();
    _controllerCategory = ExpandableController();
    _controllerService = ExpandableController();
    _controllerAnswer = ExpandableController();
    _controllerDate = ExpandableController();
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
    _category.clear();
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchCategory(sideId: sideId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      _category.add(_currentCategory);
      _category.addAll(response.data?.result ?? []);
      update();
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Future getService({required int categoryId}) async {
    _service.clear();
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchService(categoryId: categoryId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      if ((response.data?.result ?? []).isNotEmpty) {
        _service.add(_currentService);
        _service.addAll(response.data?.result ?? []);
        update();
      }
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Future getAnswer({required int serviceId}) async {
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchAnswer(serviceId: serviceId);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      if ((response.data?.result ?? []).isNotEmpty) {
        _answer = response.data?.result ?? [];
        _answer.insert(0, Answer(id: -1, name: "no_select".tr));
        update();
      }
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  Future getAnswerByParent({required Answer answer}) async {
    setLoading(true);
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).fetchAnswerByParent(parentId: answer.id ?? 0);
    setLoading(false);
    if (response.data?.status?.message != "error") {
      if ((response.data?.result ?? []).isNotEmpty) {
        _answers[answer] = response.data?.result ?? [];
        _answers[answer]?.insert(0, Answer(id: -1, name: "no_select".tr));
        _answersExpendableController.add(ExpandableController());
        _currentAnswers.add(Answer(id: -1, name: "no_select".tr));
        update();
      }
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  ApplicationDate get date => _date;

  List<Site> get site => _site;

  List<Category> get category => _category;

  List<Service> get service => _service;

  Map<Answer, List<Answer>> get answers => _answers;

  List<Answer> get answer => _answer;

  Site get currentSite => _currentSite;

  bool get currentSiteError => _currentSiteError;

  double get startPrice => _startPrice;

  double get endPrice => _endPrice;

  bool get currentDateError => _currentDateError;

  bool get addressError => _addressError;

  bool get nameError => _nameError;

  bool get noteError => _noteError;

  bool get phoneError => _phoneError;

  bool get codeError => _codeError;

  bool get currentCategoryError => _currentCategoryError;

  ApplicationDateData get currentDate => _currentDate;

  Category get currentCategory => _currentCategory;

  Service get currentService => _currentService;

  Answer get currentAnswer => _currentAnswer;

  List<Answer> get currentAnswers => _currentAnswers;

  PageController get pageController => _pageController;

  ExpandableController get controllerSite => _controllerSite;

  ExpandableController get controllerCategory => _controllerCategory;

  ExpandableController get controllerService => _controllerService;

  ExpandableController get controllerAnswer => _controllerAnswer;

  List<ExpandableController> get answersExpendableController => _answersExpendableController;

  ExpandableController get controllerDate => _controllerDate;

  void toggleDate() {
    _controllerDate.toggle();
    update();
  }

  void toggleSite() {
    _controllerSite.toggle();
    update();
  }

  void toggleCategory() {
    _controllerCategory.toggle();
    update();
  }

  void toggleService() {
    _controllerService.toggle();
    update();
  }

  void toggleAnswer() {
    _controllerAnswer.toggle();
    update();
  }

  void toggleAnswers(int index) {
    _answersExpendableController[index].toggle();
    update();
  }

  typeName() {
    _nameError = false;
    update();
  }

  void setSite(Site site) {
    if (_currentSite.id == site.id) {
      return;
    }
    _currentSite = site;
    _currentSiteError = false;
    _controllerSite.expanded = false;
    getCategory(sideId: site.id ?? 0);
    _currentCategory = Category(id: -1, name: "no_select".tr);
    _currentService = Service(name: "no_select".tr, id: -1);
    _currentAnswer = Answer(id: -1, name: "no_select".tr);
    _service.clear();
    _answers.clear();
    _answersExpendableController.clear();
    _currentAnswers.clear();
    _answer.clear();
    _startPrice = 0;
    _endPrice = 1500000;
    update();
  }

  void setCategory(Category category) {
    if (_currentCategory.id == category.id) {
      return;
    }
    _currentCategory = category;
    _currentCategoryError = false;
    _controllerCategory.expanded = false;
    _currentService = Service(name: "no_select".tr, id: -1);
    _currentAnswer = Answer(id: -1, name: "no_select".tr);
    _answers.clear();
    _answersExpendableController.clear();
    _currentAnswers.clear();
    _answer.clear();
    _service.clear();
    _startPrice = 0;
    _endPrice = 1500000;
    if (category.id != -1) {
      getService(categoryId: category.id ?? 0);
    }
    update();
  }

  void setService(Service service) {
    if (_currentService.id == service.id) {
      return;
    }
    _currentService = service;
    _controllerService.expanded = false;
    _startPrice = double.parse(service.prices?.min ?? "0.0");
    _endPrice = double.parse(service.prices?.max ?? "-1");

    _currentAnswer = Answer(id: -1, name: "no_select".tr);
    _answers.clear();
    _answersExpendableController.clear();
    _currentAnswers.clear();
    _answer.clear();

    if (_currentService.id != -1) {
      getAnswer(serviceId: service.id ?? 0);
    }
    update();
  }

  void setAnswer(Answer answer) {
    if (_currentAnswer.id == answer.id) {
      return;
    }
    _currentAnswer = answer;
    _controllerAnswer.expanded = false;
    if (_currentAnswer.question != null && _currentAnswer.question!.isNotEmpty) {
      getAnswerByParent(answer: _currentAnswer);
    }
    _currentAnswers.clear();
    _answersExpendableController.clear();
    _answers.clear();
    update();
  }

  void setAnswers(Answer answer, int index) {
    if (_currentAnswers[index].id == answer.id) {
      return;
    }
    _currentAnswers[index] = answer;
    _answersExpendableController[index].expanded = false;
    if (_currentAnswers.length > index) {
      _currentAnswers.removeRange(index + 1, _currentAnswers.length);
      _answersExpendableController.removeRange(index + 1, _currentAnswers.length);
      _answers.removeWhere((key, value) => _answers.keys.toList().indexOf(key) > index);
    }
    if (_currentAnswers[index].question != null && _currentAnswers[index].question!.isNotEmpty) {
      getAnswerByParent(answer: _currentAnswers[index]);
    }
    update();
  }

  void nextPage(int page) {
    switch (page) {
      case 0:
        if (nameController.text.trim().isEmpty) {
          _nameError = true;
          update();
        } else if (_currentSite.id == -1) {
          _currentSiteError = true;
          update();
        } else if (_currentCategory.id == -1) {
          _currentCategoryError = true;
          update();
        } else if (noteController.text.trim().isEmpty) {
          _noteError = true;
          update();
        } else {
          _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
        }
        break;
      case 1:
        if (_currentDate.id == "-1") {
          _currentDateError = true;
          update();
        } else {
          _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
        }
        break;
      case 2:
        if (addressController.text.trim().isEmpty) {
          _addressError = true;
          update();
        } else if (phoneController.text.trim().replaceAll(" ", '').replaceAll("-", '').length != 9) {
          _phoneError = true;
          Get.snackbar("error".tr, "error_count".tr);
          update();
        } else {
          phoneConfirm();
        }
        break;
      case 3:
        if (codeController.text.trim().replaceAll(" ", '').length == 4 && codeController.text == _verificationCode) {
          createApplication();
        } else {
          _codeError = true;
          update();
        }
        break;
    }
  }

  void changeDate(ApplicationDate date) {
    _date = date;
    update();
  }

  void prevPage() {
    _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  void setDate(ApplicationDateData date) {
    _currentDate = date;
    _currentDateError = false;
    _controllerDate.expanded = false;
    update();
  }

  void createApplication() async {
    final a = _imageFileList.map((e) => File(e.path)).toList();
    print(a.length);

    setLoading(true);
    int currentAnswerId = 0;
    if (_currentAnswers.where((element) => element.id != -1).isNotEmpty) {
      currentAnswerId = _currentAnswers.where((element) => element.id != -1).last.id ?? 0;
    } else {
      currentAnswerId = _currentAnswer.id != -1 ? _currentAnswer.id ?? 0 : 0;
    }
    final response = await ApplicationRepository(apiClient: ApiClient.getInstance()).postApplication(
      siteId: _currentSite.id ?? 0,
      categoryId: _currentCategory.id ?? 0,
      serviceId: _currentService.id ?? 0,
      answerId: currentAnswerId,
     // text: _currentService.name=="no_select".tr?"":_currentService.name!,
      text: noteController.text.trim(),
      date: getDate(),
      address: addressController.text.trim(),
      addressNote: addressNoteController.text.trim(),
      contactPhone: _phoneNumber,
      note: textController.text,
      price: priceController.text.trim().isNotEmpty ? double.parse(priceController.text.replaceAll(" ", '')) : 0.0,
      time: _currentDate.id,
     // cancelNote: textController.text,
      cancelNote: "cancelNote",
      username: nameController.text,
      files: _imageFileList.map((e) => File(e.path)).toList(),
    );
    setLoading(false);
    print("POST");
    if (response.data?.status?.message == "") {
      if(!LocalSource.getInstance.hasAccount){
        await LocalSource.getInstance.setAccount(accessToken: response.data?.result?.token??'', phone: _phoneNumber, username: nameController.text, avatar: '', userId: response.data?.result?.userId??0);
        Get.find<ProfileController>().getProfile();
      }
      if (_success == true) {
        _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
      } else {
        _success = true;
        update();
      }
    } else {
      Get.snackbar('error'.tr, 'error_text'.tr);
    }
  }

  phoneConfirm() async {
    _phoneNumber = "998${phoneController.text.trim().replaceAll(' ', '').replaceAll('-', '')}";
    if (_phoneNumber.length != 12) {
      _phoneError = true;
      update();
      return;
    }
    setLoading(true);
    final response = await AuthRepository(apiClient: ApiClient.getInstance()).fetchPhoneConfirm(phone: _phoneNumber);
    setLoading(false);
    if (response.data is PhoneConfirmResponse && response.data?.status?.code != "error") {

      _verificationCode = response.data?.result?.code ?? '';

      isTime = false;
      start = 60;
      startTimer();

      _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
    } else {
      Get.snackbar("error".tr, response.data?.status?.message ?? "error_text".tr);
    }
  }

  void resentCode() {}

  String getDate() {
    String text = '';
    switch (_date) {
      case ApplicationDate.today:
        text = "today";
        break;
      case ApplicationDate.tomorrow:
        text = "tomorrow";
        break;
      case ApplicationDate.master_free:
        text = "master";
        break;
      case ApplicationDate.in_week:
        text = "in_week";
        break;
    }
    return text;
  }
}
