import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salonku/app/components/widgets/reusable_widgets.dart';
import 'package:salonku/app/data/providers/local/local_data_source.dart';
import 'package:salonku/app/routes/app_pages.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  final box = GetStorage();
  final _auth = FirebaseAuth.instance;
  final _messaging = FirebaseMessaging.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  late Rx<User?> firebaseUser;
  String? notificationToken;

  @override
  void onInit() async {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.authStateChanges().distinct());
    debounce(
      firebaseUser,
      _setInitialScreen,
      time: Duration(milliseconds: 500),
    );
    super.onInit();
  }

  void _setInitialScreen(User? user) async {
    final showOnboarding = Get.find<LocalDataSource>().getIsShowOnboarding();
    if (showOnboarding != false) {
      Get.toNamed(Routes.ONBOARDING);
    } else {
      if (user != null) {
        await requestNotificationPermission();
        Get.offAllNamed(Routes.BASE);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }

  Future<bool> requestNotificationPermission() async {
    NotificationSettings settings = await _messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Dapatkan token FCM (yang juga mengandalkan APNs di iOS)
      notificationToken = await _messaging.getToken();
      // Dapatkan APNs token (iOS only)
      await _messaging.getAPNSToken();
    }
    return true;
  }

  //perlu diperbaiki untuk UI/UX yang lebih bagus
  // Future<bool> requestCameraPermission() async {
  //   var status = await Permission.camera.status;
  //   if (status.isDenied || status.isRestricted) {
  //     status = await Permission.camera.request();
  //   }
  //   return true;
  // }

  Future<void> signInWithGoogle({bool isLinkingUser = false}) async {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    await EasyLoading.show();
    try {
      var r = await _signInWithCredentialGoogle(isLinkingUser);
      box.write('apple_login', null);
      if (r == null) {
        await EasyLoading.dismiss();
      }
    } catch (e) {
      ReusableWidgets.notifBottomSheet(subtitle: e.toString());
    }
    await EasyLoading.dismiss();
  }

  Future<UserCredential?> _signInWithCredentialGoogle(
    bool isLinkingUser,
  ) async {
    _googleSignIn.initialize();
    final googleSignInAccount = await _googleSignIn.authenticate();
    GoogleSignInAuthentication googleSignInAuthentication =
        googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      // accessToken: googleSignInAuthentication,
      idToken: googleSignInAuthentication.idToken,
    );

    if (isLinkingUser) {
      await _linkAccountCredential(credential);
      return null;
    } else {
      return await _auth.signInWithCredential(credential);
    }
  }

  Future<void> _linkAccountCredential(AuthCredential credential) async {
    User? user = _auth.currentUser;
    if (user != null) {
      if (user.email.toString().endsWith("privaterelay.appleid.com")) {
        if (EasyLoading.isShow) await EasyLoading.dismiss();
        ReusableWidgets.notifBottomSheet(
          subtitle:
              "Tidak dapat menautkan akun karena email Apple bersifat privat",
        );
      } else {
        try {
          await user.linkWithCredential(credential);
        } catch (e) {
          if (e.toString().toLowerCase().contains(
                "associated with a different user account",
              ) ||
              e.toString().toLowerCase().contains(
                "already in use by another account",
              )) {
            await _googleSignIn.disconnect();
            ReusableWidgets.notifBottomSheet(
              subtitle:
                  "Akun yang anda pilih sudah terhubung dengan pengguna lain",
            );
          } else if (e.toString().toLowerCase().contains(
            "do not correspond to the previously signed in user",
          )) {
            ReusableWidgets.notifBottomSheet(
              subtitle: "Tidak dapat menautkan akun dengan email yang berbeda",
            );
          } else {
            ReusableWidgets.notifBottomSheet(
              subtitle: "Terjadi kesalahan saat menautkan akun anda",
            );
          }
        }
      }
    }
    if (EasyLoading.isShow) await EasyLoading.dismiss();
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential?> _signInWithCredentialApple(bool isLinkingUser) async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
      accessToken: appleCredential.authorizationCode,
    );
    if (isLinkingUser) {
      await _linkAccountCredential(oauthCredential);
      return null;
    } else {
      return await _auth.signInWithCredential(oauthCredential);
    }
  }

  Future<void> signInWithApple({bool isLinkingUser = false}) async {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    await EasyLoading.show();
    try {
      await _signInWithCredentialApple(isLinkingUser);
      box.write('apple_login', true);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        ReusableWidgets.notifBottomSheet(subtitle: e.message);
      }
      await EasyLoading.dismiss();
    }
  }

  Future<void> singInWithPassword(String email, String pass) async {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    await EasyLoading.show();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
    } catch (e) {
      if (e.toString().toLowerCase().contains("no user record") ||
          e.toString().toLowerCase().contains("malformed")) {
        ReusableWidgets.notifBottomSheet(subtitle: "wrong_credential".tr);
      } else {
        ReusableWidgets.notifBottomSheet(subtitle: e.toString());
      }
    }
    await EasyLoading.dismiss();
  }

  Future<void> signOut({bool deleteToken = true}) async {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    await EasyLoading.show();
    //jangan lupa tambahkan delete notif tokennya
    await _auth.signOut();
    await _googleSignIn.disconnect();

    await EasyLoading.dismiss();
  }

  Future<void> deleteAccount() async {
    if (EasyLoading.isShow) EasyLoading.dismiss();
    await EasyLoading.show();
    UserCredential? userCredential;
    try {
      //jangan lupa tambahkan delete notif tokennya
      if (box.read('apple_login') == true) {
        userCredential = await _signInWithCredentialApple(false);
      } else {
        userCredential = await _signInWithCredentialGoogle(false);
      }
      if (userCredential?.user != null) {
        await userCredential!.user!.delete();
      }
      _auth.signOut();
      await _googleSignIn.disconnect();
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        ReusableWidgets.notifBottomSheet(subtitle: e.message);
      }
    } catch (e) {
      ReusableWidgets.notifBottomSheet(subtitle: e.toString());
    }
    await EasyLoading.dismiss();
  }
}
