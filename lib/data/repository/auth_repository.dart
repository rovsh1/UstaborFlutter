import 'package:dio/dio.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/data/model/auth/login_response.dart';
import 'package:usta_bor_android/data/model/auth/phone_confirm_response.dart';
import 'package:usta_bor_android/data/model/catalog/re_call_response.dart';
import 'package:usta_bor_android/data/model/profile/profile_response.dart';
import 'package:usta_bor_android/data/model/auth/registration_response.dart';
import 'package:usta_bor_android/data/model/auth/restore_password_response.dart';
import 'package:usta_bor_android/data/provider/response_handler.dart';
import 'package:usta_bor_android/data/provider/server_error.dart';
import 'package:usta_bor_android/data/provider/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({required this.apiClient});

  Future<ResponseHandler<ProfileResponse>> fetchProfile() async {
    ProfileResponse response;
    try {
      response = await apiClient.getProfile();
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<LoginResponse>> fetchLogin({required String login, required String password}) async {
    LoginResponse response;
    try {
      response = await apiClient.login(login, password);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<LoginResponse>> fetchLoginProvider({required String provider, required String token}) async {
    LoginResponse response;
    try {
      response = await apiClient.loginProvider(provider, token);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<LoginResponse>> fetchLoginProviderApple({required String provider, required String token}) async {
    LoginResponse response;
    try {
      response = await apiClient.loginProviderApple(provider, token);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }



  Future<ResponseHandler<ReCallResponse>> fetchReCall({required int id, required String phone, required String time}) async {
    ReCallResponse response;
    try {
      response = await apiClient.recall(id, phone, time);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<PhoneConfirmResponse>> fetchPhoneConfirm({required String phone}) async {
    PhoneConfirmResponse response;
    try {
      response = await apiClient.phoneConfirm(phone);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<RegistrationResponse>> fetchRegistration({required String username, required String phone}) async {
    RegistrationResponse response;
    try {
      response = await apiClient.registration(username, phone);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<RestorePasswordResponse>> fetchRestorePassword({required String login}) async {
    RestorePasswordResponse response;
    try {
      response = await apiClient.restorePassword(
          LocalSource.getInstance.accessToken.isNotEmpty? LocalSource.getInstance.locale : "ru",
          "529",
          LocalSource.getInstance.siteId.toString(),
          login);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ResponseHandler()..setException(ServerError.withError(error: error as DioError));
    }
    return ResponseHandler()..data = response;
  }
}
