import 'dart:io';

import 'package:dio/dio.dart';
import 'package:usta_bor_android/data/model/application_create/answer_response.dart';
import 'package:usta_bor_android/data/model/application_create/category_price_response.dart';
import 'package:usta_bor_android/data/model/application_create/category_response.dart';
import 'package:usta_bor_android/data/model/application_create/create_application_response.dart';
import 'package:usta_bor_android/data/model/application_create/service_response.dart';
import 'package:usta_bor_android/data/model/application_create/site_response.dart';
import 'package:usta_bor_android/data/provider/response_handler.dart';
import 'package:usta_bor_android/data/provider/server_error.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';

class ApplicationRepository {
  final ApiClient apiClient;

  ApplicationRepository({required this.apiClient});

  Future<ResponseHandler<SiteResponse>> fetchSite() async {
    SiteResponse response;
    try {
      response = await apiClient.getSites();


    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");


      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<CategoryResponse>> fetchCategory({required int sideId}) async {
    CategoryResponse response;
    try {
      response = await apiClient.getCategories(sideId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<CategoryPriceResponse>> fetchCategoryPrice({required int categoryId}) async {
    CategoryPriceResponse response;
    try {
      response = await apiClient.getCategoryPrice(categoryId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<ServiceResponse>> fetchService({required int categoryId}) async {
    ServiceResponse response;
    try {
      response = await apiClient.getServices(categoryId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<AnswerResponse>> fetchAnswer({required int serviceId}) async {
    AnswerResponse response;
    try {
      response = await apiClient.getAnswers(serviceId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<AnswerResponse>> fetchAnswerByParent({required int parentId}) async {
    AnswerResponse response;
    try {
      response = await apiClient.getAnswersBuParent(parentId);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<CreateApplicationResponse>> postApplication({
    required int siteId,
    required int categoryId,
    required int serviceId,
    required int answerId ,
    required String username,
    required String address,
    required String addressNote,
    required String contactPhone,
    required String date,
    required String time,
    required String note,
    required double price,
    required String text,
    required String cancelNote,
    required List<File> files,
  }) async {
    CreateApplicationResponse response;
    try {
      response = await apiClient.postApplication(
        siteId.toString(),
        categoryId.toString(),
        serviceId.toString(),
        answerId.toString(),
        username,
        address,
        addressNote,
        contactPhone,
        date,
        time,
        note,
        price.toString(),
        text,
        cancelNote,
        files,
      );
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }
}
