import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/api_constants.dart';
import 'package:usta_bor_android/data/model/application_create/answer_response.dart';
import 'package:usta_bor_android/data/model/application_create/category_price_response.dart';
import 'package:usta_bor_android/data/model/application_create/category_response.dart';
import 'package:usta_bor_android/data/model/application_create/create_application_response.dart';
import 'package:usta_bor_android/data/model/application_create/service_response.dart';
import 'package:usta_bor_android/data/model/application_create/site_response.dart';
import 'package:usta_bor_android/data/model/auth/login_response.dart';
import 'package:usta_bor_android/data/model/auth/phone_confirm_response.dart';
import 'package:usta_bor_android/data/model/catalog/add_my_master_response.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_count_response.dart';
import 'package:usta_bor_android/data/model/catalog/master_response.dart';
import 'package:usta_bor_android/data/model/catalog/re_call_response.dart';
import 'package:usta_bor_android/data/model/catalog/tag_response.dart';
import 'package:usta_bor_android/data/model/my_application/change_application_status_response.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_detail_response.dart';
import 'package:usta_bor_android/data/model/profile/delete_profile_response.dart';
import 'package:usta_bor_android/data/model/profile/edit_profile_response.dart';
import 'package:usta_bor_android/data/model/profile/my_masters_response.dart';
import 'package:usta_bor_android/data/model/profile/profile_response.dart';
import 'package:usta_bor_android/data/model/auth/registration_response.dart';
import 'package:usta_bor_android/data/model/auth/restore_password_response.dart';
import 'package:usta_bor_android/data/model/catalog/badge_response.dart';
import 'package:usta_bor_android/data/model/catalog/catalog_response.dart';
import 'package:usta_bor_android/data/model/catalog/city_response.dart';
import 'package:usta_bor_android/data/model/catalog/country_response.dart';
import 'package:usta_bor_android/data/model/catalog/district_response.dart';
import 'package:usta_bor_android/data/model/my_application/my_application_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  static CancelToken cancelToken = CancelToken();

  static ApiClient getInstance({String baseUrl = ApiConstants.baseUrl}) {
    return ApiClient(Dio(), cancelToken, baseUrl);
  }

  factory ApiClient(Dio dio, CancelToken cancelToken, String baseUrl) {
    dio.options = BaseOptions(
        receiveTimeout: 90000,
        connectTimeout: 90000,
        sendTimeout: 90000,
    );
    dio.options.headers = {
      "Api-Access-Key": "PEtQOkwmJyY5NiVgIn18eXYrJmdUY3JMX3B",
      "User-Agent": LocalSource.getInstance.userAgent,
      "Accept": "application/json",
      "X-Country-id": "529",
      "Accept-Version": "3.0.0",
      "Accept-Language": LocalSource.getInstance.locale,
      "Content-Type": "application/json",
     "Authorization": "auth=${LocalSource.getInstance.accessToken}",
    };

    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
          responseBody: true,
          requestBody: true,
          requestHeader: true,
          request: true,
          error: true));
      // dio.interceptors.add(alice.getDioInterceptor());
    }
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @POST("login/")
  Future<LoginResponse> login(
    @Query("login") String login,
    @Query("password") String password,
  );

  @POST("login/")
  Future<LoginResponse> loginProvider(
    @Query("provider") String provider,
    @Query("token") String token,
  );

  @POST("login/")
  Future<LoginResponse> loginProviderApple(
      @Query("provider") String provider,
      @Query("code") String token,
      );


  @POST("master/{id}/callback/")
  Future<ReCallResponse> recall(
    @Path("id") int id,
    @Query("phone") String login,
    @Query("time") String time,
  );

  @POST("phone/confirmation/")
  Future<PhoneConfirmResponse> phoneConfirm(
    @Query("phone") String phone,
  );

  @POST("registration/customer/")
  Future<RegistrationResponse> registration(
    @Query("presentation") String username,
    @Query("phone") String phone,
  );

  @POST("profile/password/")
  Future<RestorePasswordResponse> restorePassword(
      @Header("Accept-Language") String language,
      @Header("X-Country-id") String countryId,
      @Header("X-Site-id") String siteId,
      @Query("login") String login,
      );

  @POST("profile/")
  Future<EditProfileResponse> editProfile(
    @Query("presentation") String? presentation,
  );

  @POST("profile/")
  Future<EditProfileResponse> editPhone(
    @Query("phone") String? phone,
  );

  @POST("profile/")
  Future<EditProfileResponse> editPassword(
    @Query("password") String? password,
  );

  @POST("profile/")
  Future<EditProfileResponse> editAvatar(
    @Part(name: "avatar") File avatar,
  );

  @POST("profile/")
  Future<DeleteProfileResponse> deleteProfile();

  @POST("customer/request/{id}/{action}/")
  Future<ChangeApplicationStatusResponse> changeApplicationStatus(
    @Path("id") String id,
    @Path("action") String action,
  );

  @POST("customer/request/{id}/{action}/")
  Future<ChangeApplicationStatusResponse> changeApplicationMasterStatus(
    @Path("id") int id,
    @Path("action") String action,
    @Query("value") int masterId,
  );

  @GET('reference/sites/')
  Future<SiteResponse> getSites();

  @GET('category/search/')
  Future<CategoryResponse> getCategories(
    @Header("X-Site-Id") int sideId,
  );

  @GET('price/category/{category_id}/')
  Future<CategoryPriceResponse> getCategoryPrice(
    @Path("category_id") int categoryId,
  );

  @GET('profile/')
  Future<ProfileResponse> getProfile();


  @GET('customer/request/services/')
  Future<ServiceResponse> getServices(
    @Query("category_id") int categoryId,
  );

  @GET('customer/request/answers/')
  Future<AnswerResponse> getAnswers(
    @Query("service_id") int serviceId,
  );

  @GET('customer/request/answers/')
  Future<AnswerResponse> getAnswersBuParent(
    @Query("parent_id") int parentId,
  );

  @GET('customer/requests/')
  Future<MyApplicationResponse> getMyApplications();

  @GET('customer/request/{id}/')
  Future<MyApplicationDetailResponse> getMyApplicationDetail(
    @Path("id") int id,
  );
 @HEAD('customer/request/{id}/masters/')
  Future<dynamic> getCustomerMasters(
     @Path("id") int id,
  );


  @GET('profile/masters/')
  Future<MyMastersResponse> getMyMasters();

  @GET('/master/search/')
  Future<CatalogResponse> getCatalog(
    @Header("X-Site-id") String siteId,
    @Query("category_id") String? categoryId,
    @Query("city_id") String? cityId,
    @Query("district_id") String? districtId,
    @Query("order") String? sort,
    @Query("quicksearch") String? quickSearch,
    @Query("step") int? limit,
    @Query("offset") int? page,
  );

  @GET('/master/count/')
  Future<CatalogCountResponse> getCatalogCount(
      @Header("X-Site-id") String siteId,
      @Query("category_id") String? categoryId,
      @Query("city_id") String? cityId,
      @Query("district_id") String? districtId,
      @Query("quicksearch") String? quickSearch
      );

  @GET('master/{id}/')
  Future<MasterResponse> getMaster(
    @Path("id") int id,
  );

  @POST('master/{id}/contact/')
  Future<AddMyMasterResponse> addMyMaster(
    @Path("id") int id,
    @Query("category_id") String categoryId,
    @Header("Cookie") String cookie,
  );
  @GET('reference/badges/')
  Future<BadgeResponse> getBadges();
  
  @GET('reference/countries/')
  Future<CountryResponse> getCountries();

  @GET('reference/cities/')
  Future<CityResponse> getCities();

  @GET('reference/districts/')
  Future<DistrictResponse> getDistricts(@Query("city_id") int cityId);

  @GET('category/tags/')
  Future<TagResponse> getTags(@Query("quicksearch") String search);


  @POST("customer/request/create/")
  @MultiPart()
  Future<CreateApplicationResponse> postApplication(
    @Part(name: "site_id") String siteId,
    @Part(name: "category_id") String categoryId,
    @Part(name: "service_id") String serviceId,
    @Part(name: "answer_id") String answerId,
    @Part(name: "username") String username,
    @Part(name: "address") String address,
    @Part(name: "address_note") String addressNote,
    @Part(name: "contact_phone") String contactPhone,
    @Part(name: "date") String date,
    @Part(name: "time") String time,
    @Part(name: "note") String note,
    @Part(name: "price") String price,
    @Part(name: "text") String text,
    @Part(name: "cancel_note") String cancelNote,
      @Part(name: "documents[]") List<File> documents,
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Alice alice = Alice(
//   showNotification: true,
//   navigatorKey: GlobalKey(debugLabel: "UstaBor"),
//   showInspectorOnShake: true,
// );
