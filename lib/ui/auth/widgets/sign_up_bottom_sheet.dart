import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
import 'package:usta_bor_android/ui/auth/widgets/sign_in_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:usta_bor_android/ui/auth/widgets/top_part.dart';
import 'package:usta_bor_android/ui/auth/widgets/top_text.dart';
import 'package:usta_bor_android/ui/auth/widgets/phone_button.dart';
import '../authentication/sign_up_page/sign_up_page.dart';
import 'bottom_part.dart';
import 'drag_container.dart';

class SignUpBottomSheet extends StatelessWidget {
  const SignUpBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isAndroid ? 468 : 528 + MediaQuery.of(context).padding.bottom,
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
          TopPart(text: 'registration'.tr),
          TopText(text: 'register_bottom_sheet_message'.tr),
          if (Platform.isIOS)
            SignButton(
              label: 'register_with_apple'.tr,
              iconPath: 'assets/svg/apple.svg',
              color: AppColor.apple,
              onPressed: () async {
                final user = await signInWithApple();
                LocalSource.getInstance.setIsGoogleSigning(false);
                print("Ketti -------");
                print(user);
                print(user.credential?.token);
                Get.put(SignInController()).loginProvider(
                  "apple",
                  user.user?.uid??'',
                );
              },
            ),
          SizedBox(height: 16),
          SignButton(
            label: 'register_with_facebook'.tr,
            iconPath: 'assets/svg/facebook.svg',
            color: AppColor.facebook,
            onPressed: () async {
              final tokenfb = await signInWithFacebook();
              LocalSource.getInstance.setIsGoogleSigning(false);
              Get.put(SignInController()).loginProvider(
                "facebook",
                tokenfb,
              );
            },
          ),
          SizedBox(height: 16),
          SignButton(
            label: 'register_with_google'.tr,
            iconPath: 'assets/svg/google.svg',
            color: AppColor.google,
            onPressed: () async {
              print("BBBBBBBBBBb");
              final token = await signInWithGoogle();

              LocalSource.getInstance.setIsGoogleSigning(true);
              print("AAAAAAAAAA");
              // final user = await signInWithGoogleNew();
              Get.put(SignInController()).loginProvider(
                "google",
                token,
              );
            },
          ),
          SizedBox(height: 16),
          PhoneButton(
            text: 'register_with_phone_number'.tr,
            onPressed: () {
              Get.off(() => SignUpPage());
            },
          ),
          Spacer(),
          BottomPart(
            onPressed: () {
              Get.back();
              Get.bottomSheet(
                SignInBottomSheet(),
                isScrollControlled: true,
                enableDrag: true,
              );
            },
            title: 'already_registered'.tr,
            titleButtonText: 'come_in'.tr,
            subtitle: "you_master".tr,
            subtitleButtonText: "go_site".tr,
            onLinkPressed: () async {
              await launch(
                'https://www.${ApiConstants.url}/#registration-master',
                forceSafariVC: false,
                forceWebView: false,
              );
            },
          ),
          SizedBox(
            height: 8 + MediaQuery.of(context).padding.bottom,
          ),
        ],
      ),
    );
  }

  // Future<UserCredential?> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   try {
  //     print("signInWithGoogle Started");
  //
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn(
  //       scopes: [
  //         'email',
  //         'https://www.googleapis.com/auth/contacts.readonly',
  //       ],
  //     ).signIn();
  //
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth = await googleUser
  //         ?.authentication;
  //
  //     // Create a new credential
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     print("googleAuth ${googleAuth?.accessToken}");
  //     print("googleAuth ${googleAuth?.idToken}");
  //
  //     // Once signed in, return the UserCredential
  //     return await FirebaseAuth.instance.signInWithCredential(credential);
  //   }catch(error){
  //     print("signInWithGoogleError ${error.toString()}");
  //   }
  //
  // }

  //NEW METHOD
  Future<String> signInWithGoogle() async {

    GoogleSignIn _googleSignIn = new GoogleSignIn(
      scopes: [
        'email',
        'openid',
        'profile',
      ],
    );

    final GoogleSignInAccount? us = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? auth = await us?.authentication;

    return auth?.idToken ?? '';
  }



  // Future<GoogleSignInAuthentication?> signInWithGoogleNew() async {
  //   // Trigger the authentication flow
  //   try {
  //     print("signInWithGoogle Started");
  //
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn(
  //       scopes: [
  //         'email',
  //         'https://www.googleapis.com/auth/contacts.readonly',
  //       ],
  //     ).signIn();
  //
  //     // Obtain the auth details from the request
  //     final GoogleSignInAuthentication? googleAuth = await googleUser
  //         ?.authentication;
  //
  //     // Create a new credential
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     print("googleAuth ${googleAuth?.accessToken}");
  //     print("googleAuth ${googleAuth?.idToken}");
  //
  //     // Once signed in, return the UserCredential
  //      await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //      return googleAuth;
  //   }catch(error){
  //     print("signInWithGoogleError ${error.toString()}");
  //   }
  //
  // }



  Future<String> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken?.token ?? '');
    var token = "";
    if (loginResult.status == LoginStatus.success) {
      token = loginResult.accessToken!.token;
    }
    // Once signed in, return the UserCredential
    return token;
  }

  String generateNonce([int length = 32]) {
    final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
