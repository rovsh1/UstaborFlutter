import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LocalSource {
  GetStorage get _localStorage => GetStorage();

  LocalSource._();

  static LocalSource _instance = LocalSource._();

  static List<String> sitedomains = ["www","www","auto", "tech", "home"];


  static LocalSource get getInstance => _instance;

  Future<void> removeStorage() async {
    await _localStorage.remove("access_token");
    await _localStorage.remove("phone");
    await _localStorage.remove("username");
    await _localStorage.remove("user_id");
    await _localStorage.remove("has_account");
    await _localStorage.remove("debug");
    await _localStorage.remove("avatar");
    await _localStorage.remove("locale");
    await _localStorage.remove("on_boarding");
    await _localStorage.remove("promoted_masters");

    //For Signing Out Google User account from firebase. This is needed to enable choosing google user once again.

    if(LocalSource.getInstance.isGoogleSigning) {
      GoogleSignIn _googleSignIn = new GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      await _googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<void> setAccount({
    required String accessToken,
    required String phone,
    required String username,
    required String avatar,
    required int userId,
  }) async {
    await GetStorage().write('access_token', accessToken);
    await GetStorage().write('phone', phone);
    await GetStorage().write('username', username);
    await GetStorage().write('user_id', userId);
    await GetStorage().write('has_account', true);
    await GetStorage().write('on_boarding', false);
    await GetStorage().write('avatar', avatar);
  }

  Future<void> setOnBoarding(bool value) async => await _localStorage.write('on_boarding', value);
  Future<void> setIsGoogleSigning(bool value) async => await _localStorage.write('is_google_signing', value);

  Future<void> setUserName(String username) async => await _localStorage.write('username', username);

  Future<void> setDebug(bool value) async => await _localStorage.write('debug', value);

  Future<void> setAccessToken(String token) async => await _localStorage.write('access_token', token);

  Future<void> setUserId(String userId) async => await _localStorage.write('user_id', userId);
  Future<void> setUserAgent(String userAgent) async => await _localStorage.write('user_agent', userAgent);

  Future<void> setLocale(String lang) async => await _localStorage.write('locale', lang);

  Future<void> setAvatar(String path) async => await _localStorage.write('avatar', path);
  Future<void> setFeedBack(String feed) async => await _localStorage.write('feedback', feed);

  Future<void> setSiteId(int sideId) async => await _localStorage.write('site_id', sideId);
  Future<void> setPromotedMasters(List<dynamic> mastersIds) async => _localStorage.write('promoted_masters', mastersIds);

  int get userId => _localStorage.read<int>('user_id') ?? 0;
  String get userAgent => _localStorage.read<String>('user_agent') ?? "";

  int get siteId => _localStorage.read<int>('site_id') ?? 1;
  List<dynamic> get promotedMastersIds => _localStorage.read<List<dynamic>>('promoted_masters') ?? [];

  String get username => _localStorage.read<String>('username') ?? '';
  String get feedback => _localStorage.read<String>('feedback') ?? '';

  bool get onOpenBoarding => _localStorage.read<bool>('on_boarding') ?? true;

  String get phone => _localStorage.read<String>('phone') ?? '';

  bool get debug => _localStorage.read<bool>('debug') ?? true;
  bool get isGoogleSigning => _localStorage.read<bool>('is_google_signing') ?? false;

  bool get hasAccount => _localStorage.read<bool>('has_account') ?? false;

  String get locale => _localStorage.read<String>('locale') ?? 'ru';

  String get accessToken => _localStorage.read<String>('access_token') ?? '';

  String get avatar => _localStorage.read<String>('avatar') ?? '';

}
