import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:usta_bor_android/controller/sign_in_controller.dart';
import 'package:usta_bor_android/core/data_sources/local/local_source.dart';
import 'package:usta_bor_android/core/utils/api_constants.dart';
import 'package:usta_bor_android/core/utils/app_color.dart';
import 'package:usta_bor_android/ui/auth/widgets/sign_button.dart';
import 'package:usta_bor_android/ui/auth/widgets/sign_up_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/auth/widgets/top_text.dart';
import 'package:usta_bor_android/ui/auth/widgets/phone_button.dart';
import '../authentication/sign_in_page/sign_in_page.dart';
import 'bottom_part.dart';
import 'drag_container.dart';
import 'top_part.dart';

class SignInBottomSheet extends StatelessWidget {
  const SignInBottomSheet({Key? key}) : super(key: key);

  void printWrapped(String text) {
    final pattern = RegExp('.{1,300}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isAndroid ? 490 : 528 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DragContainer(),
          TopPart(
            text: 'enter'.tr,
          ),
          TopText(text: 'enter_bottom_sheet_message'.tr),
          if (Platform.isIOS)
            SignButton(
              label: 'enter_with_apple'.tr,
              iconPath: 'assets/svg/apple.svg',
              color: AppColor.apple,
              onPressed: () async {
                final userToken = await signInWithApple();
                LocalSource.getInstance.setIsGoogleSigning(false);
                Get.put(SignInController()).loginProviderApple(
                  "apple",
                  userToken,
                );
              },
            ),
          SizedBox(height: 16),
          SignButton(
            label: 'enter_with_facebook'.tr,
            iconPath: 'assets/svg/facebook.svg',
            color: AppColor.facebook,
            onPressed: () async {
              final token = await signInWithFacebook();
              LocalSource.getInstance.setIsGoogleSigning(false);
              Get.put(SignInController(), permanent: true).loginProvider(
                "facebook",
                token,
              );
            },
          ),
          SizedBox(height: 16),
          SignButton(
            label: 'enter_with_google'.tr,
            iconPath: 'assets/svg/google.svg',
            color: AppColor.google,
            onPressed: () async {
              print("BBB");
              final token = await signInWithGoogle();
              LocalSource.getInstance.setIsGoogleSigning(true);
              Get.put(SignInController()).loginProvider(
                "google",
                token,
              );
            },
          ),
          SizedBox(height: 16),
          PhoneButton(
            text: 'enter_with_phone_number'.tr,
            onPressed: () {
              Get.off(() => SignInPage());
            },
          ),
          SizedBox(
            height: 40,
          ),
          BottomPart(
            onPressed: () {
              Get.back();
              Get.bottomSheet(
                SignUpBottomSheet(),
                isScrollControlled: true,
                enableDrag: true,
              );
            },
            title: 'do_nt_have_account'.tr,
            titleButtonText: 'register'.tr,
            subtitle: "you_master".tr,
            subtitleButtonText: "go_site".tr,
            onLinkPressed: () async {
              await launchUrl(Uri.parse('https://www.${ApiConstants.url}/#signForm'));
            },
          ),
        ],
      ),
    );
  }


  Future<String> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = new GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    final GoogleSignInAccount? us = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? auth = await us?.authentication;
    return auth?.idToken ?? '';
  }


  Future<String> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ["public_profile", "email"], loginBehavior: LoginBehavior.webOnly);
    var token = "";
    if (loginResult.status == LoginStatus.success) {
      token = loginResult.accessToken!.token;
    }

    return token;
    }



  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<String> signInWithApple() async {
    final rawNonce = generateNonce();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
      accessToken: appleCredential.authorizationCode
    );
    return oauthCredential.accessToken ?? "";

  }

}



