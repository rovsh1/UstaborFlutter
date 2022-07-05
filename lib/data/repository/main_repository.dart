import 'dart:io';

import 'package:dio/dio.dart';
import 'package:usta_bor_android/data/model/catalog/add_my_master_response.dart';
import 'package:usta_bor_android/data/model/catalog/badge_response.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_count_response.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/data/model/catalog/city_response.dart';
import 'package:usta_bor_android/data/model/catalog/district_response.dart';
import 'package:usta_bor_android/data/model/catalog/master_response.dart';
import 'package:usta_bor_android/data/model/catalog/tag_response.dart';
import 'package:usta_bor_android/data/model/my_application/change_application_status_response.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_detail_response.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_response.dart';
import 'package:usta_bor_android/data/model/profile/delete_profile_response.dart';
import 'package:usta_bor_android/data/model/profile/edit_profile_response.dart';
import 'package:usta_bor_android/data/model/profile/my_masters_response.dart';
import 'package:usta_bor_android/data/provider/response_handler.dart';
import 'package:usta_bor_android/data/provider/server_error.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';

class MainRepository {
  final ApiClient apiClient;

  MainRepository({required this.apiClient});

  Future<ResponseHandler<MyApplicationResponse>> fetchMyApplications() async {
    MyApplicationResponse response;
    try {
      response = await apiClient.getMyApplications();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<ChangeApplicationStatusResponse>> fetchApplicationStatus({
    required int id,
    required String action,
  }) async {
    print('------------FETCH------');
    print(action);
    print(id);
    print(id.toString());
    ChangeApplicationStatusResponse response;
    try {
      response = await apiClient.changeApplicationStatus(id.toString(), action);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<ChangeApplicationStatusResponse>> fetchApplicationMasterStatus({
    required int id,
    required String action,
    required int masterId,
  }) async {
    ChangeApplicationStatusResponse response;
    try {
      response = await apiClient.changeApplicationMasterStatus(id, action, masterId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MyApplicationDetailResponse>> fetchMyApplicationDetail({required int id}) async {
    MyApplicationDetailResponse response;
    try {
      response = await apiClient.getMyApplicationDetail(id);
      printWrapped("REEEEESSSSSP ${response.toString()}");
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }
  Future<ResponseHandler<dynamic>> getCustomerMasters({required int id}) async {
    dynamic response;
    try {
      response = await apiClient.getCustomerMasters(id);
      printWrapped("REEEEESSSSSP ${response.toString()}");
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<CatalogResponse>> fetchCatalog(
      {required String siteId,
      required String? categoryId,
      required String? cityId,
      required String? districtId,
      required String? query,
      required String? sort,
      required int? limit,
      required int? page,}) async {
    CatalogResponse response;
    try {
      response = await apiClient.getCatalog(siteId, categoryId, cityId, districtId, sort, query, limit, page);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<CatalogCountResponse>> fetchCatalogCount(
      {required String siteId,required String? categoryId,required String? cityId,required String? districtId, required String? quickSearch}) async {
    CatalogCountResponse response;
    try {
      response = await apiClient.getCatalogCount(siteId, categoryId, cityId, districtId, quickSearch);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MasterResponse>> fetchMaster({required int id}) async {
    MasterResponse response;
    try {
      response = await apiClient.getMaster(id);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<AddMyMasterResponse>> addMyMaster({required int id, required String categoryId,required List<dynamic> cookies}) async {
    AddMyMasterResponse response;
    try {
      String a="promotion=";

      for(dynamic i in cookies) {
        if(i!=cookies.last) {
a = a + i.toString() + ",";
        }
        else {
          a = a + i.toString();
        }
      }
      print(a);

      response = await apiClient.addMyMaster(id, categoryId,a);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MyMastersResponse>> fetchMyMasters() async {
    MyMastersResponse response;
    try {
      response = await apiClient.getMyMasters();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<EditProfileResponse>> fetchEditProfile({required String name}) async {
    EditProfileResponse? response;
    try {
      response = await apiClient.editProfile(name);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<EditProfileResponse>> fetchEditPhone({required String phone}) async {
    EditProfileResponse? response;
    try {
      response = await apiClient.editPhone(phone);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<EditProfileResponse>> fetchEditAvatar({required File image}) async {
    EditProfileResponse? response;
    try {
      response = await apiClient.editAvatar(image);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<EditProfileResponse>> fetchEditPassword({required String password}) async {
    EditProfileResponse? response;
    try {
      response = await apiClient.editPassword(password);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<DeleteProfileResponse>> fetchDeleteProfile() async {
    DeleteProfileResponse response;
    try {
      response = await apiClient.deleteProfile();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<CityResponse>> fetchCities() async {
    CityResponse response;
    try {
      response = await apiClient.getCities();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<DistrictResponse>> fetchDistricts({required int cityId}) async {
    DistrictResponse response;
    try {
      response = await apiClient.getDistricts(cityId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<TagResponse>> fetchTags({required String search}) async {
    TagResponse response;
    try {
      response = await apiClient.getTags(search);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<BadgeResponse>> fetchBadges() async {
    BadgeResponse response;
    try {
      response = await apiClient.getBadges();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,300}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

}
