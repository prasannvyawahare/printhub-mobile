import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../model/google_sign_in/model/googgle_sign_in_request.dart';
import 'firebase_notification.dart';



class GoogleSignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  RxInt userID = 0.obs;
  RxString phoneNo = "".obs;
  RxString eMail = "".obs;
  RxString photoURL = "".obs;
  RxString displayName = "".obs;

  RxString firstName = "".obs;
  RxString lastName = "".obs;

  var isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    try {
      print("Attempting Google sign-in...");

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google sign-in was cancelled by the user.");
        Get.snackbar("Cancelled", "Google sign-in was cancelled by the user.");
        isLoading.value = false;
        return;
      }

      print(
          "Google sign-in successful. User: ${googleUser.displayName}, Email: ${googleUser.email}");

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        print("Error: Missing Google tokens.");
        Get.snackbar("Error", "Missing authentication tokens from Google.");
        isLoading.value = false;
        return;
      }

      print("Access Token: ${googleAuth.accessToken}");
      print("ID Token: ${googleAuth.idToken}");

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        eMail.value = user.email ?? "";
        phoneNo.value = user.phoneNumber ?? "";
        photoURL.value = user.photoURL ?? "";
        displayName.value = user.displayName ?? "";

        print(
            "Firebase sign-in successful. User ID: ${user.uid}, Email: ${user.email}");
        print("Photo URL: ${photoURL.value}");

        splitDisplayName();

        // Make your API call
        await googleloginAPI();

        Get.snackbar("Success", "Signed in successfully with Google.");
      } else {
        print("Error: Firebase user is null after sign-in.");
        Get.snackbar("Error", "Firebase user is null after Google sign-in.");
      }
    } catch (error) {
      print("Error signing in with Google: $error");
      if (error is PlatformException) {
        print("PlatformException code: ${error.code}");
        print("PlatformException message: ${error.message}");
        print("PlatformException details: ${error.details}");
        Get.snackbar("Error", "${error.message ?? 'Unknown error'}");
      } else {
        Get.snackbar("Error", "Something went wrong during Google sign-in.");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithApple() async {
    isLoading.value = true;
    try {
      AuthorizationCredentialAppleID appleCredential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (appleCredential.email != null && appleCredential.email != "") {}
      // print(appleCredential);
      // print("appleCredential.identityToken=>${appleCredential.identityToken}");
      // print("appleCredential.authorizationCode=>${appleCredential.authorizationCode}");
      // print("appleCredential.userIdentifier=>${appleCredential.userIdentifier}");
      // print("appleCredential.givenName=>${appleCredential.givenName}");
      // print("appleCredential.familyName=>${appleCredential.familyName}");

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode);
      print("oauthCredential: ${oauthCredential}");

      final authResult = await _auth.signInWithCredential(oauthCredential);
      print("authResult: ${authResult}");

      String displayNameTemp =
          '${appleCredential.givenName} ${appleCredential.familyName}';
      final userEmail = '${appleCredential.email}';

      final firebaseUser = authResult.user;
      print("firebaseUser: ${firebaseUser}");

      isLoading.value = false;
      if (firebaseUser != null) {
        // Update the user data after successful sign-in
        eMail.value = firebaseUser.email.toString();
        phoneNo.value = firebaseUser.phoneNumber.toString();
        photoURL.value = firebaseUser.photoURL.toString();
        displayName.value = displayNameTemp.toString();
        print("Photo URL: ${photoURL.value}");
        splitDisplayName();
        await firebaseUser.updateProfile(displayName: displayName.value);
        //await firebaseUser.updateEmail(userEmail);
        print(
            "Firebase sign-in successful. User ID: ${firebaseUser.uid}, Email: ${firebaseUser.email}");

        // Attempt API call after sign-in
        await googleloginAPI();

        isLoading.value = false;
      } else {
        print("Error: Firebase user is null after sign-in.");
      }
    } catch (error) {
      print("Error: Firebase user is null after sign-in.$error");

      isLoading.value = false;
    }
  }

  void splitDisplayName() {
    List<String> nameParts = displayName.value.split(' ');
    if (nameParts.length >= 2) {
      firstName.value = nameParts[0];
      lastName.value = nameParts[1];
    } else if (nameParts.length == 1) {
      firstName.value = nameParts[0];
      lastName.value = "";
    } else {
      firstName.value = "";
      lastName.value = "";
    }
  }

  Future<void> googleloginAPI() async {
    try {
      String? fcmToken;

      if (!Platform.isIOS) {
        fcmToken = await FirebaseService().getDeviceToken();
      }
//todo write server api call here
      final requestModel = GooggleSignInRequest(
        email: eMail.value,
        type: "email",
      );

      // final requestInstance = Request();
      // final results = await requestInstance.requestPost(
      //   context: Get.context,
      //   url: user_login,
      //   parameters: json.encode(requestModel),
      // );
      //
      // if (results == null) {
      //   errorSuccessDialog("No response from server", Get.context!, "0");
      //   return;
      // }
      //
      // final responseModel = GoogleSignInResponce1.fromJson(results);
      //
      // if (responseModel.success != "1") {
      //   errorSuccessDialog(responseModel.message ?? "Login failed", Get.context!, "0");
      //   return;
      // }
      //
      // userID.value = responseModel.userId ?? 0;
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('userId', userID.toString());
      //
      // // Create Account
      // await createAccount(
      //   email: eMail.value,
      //   fcmToken: fcmToken ?? "",
      //   name: displayName.value,
      //   password: "123456",
      //   userID: userID.toString(),
      //   userType: 'user',
      // );

      // Login
      // await logIn(
      //   email: eMail.value,
      //   fcmToken: fcmToken ?? "",
      //   password: "123456",
      //   userID: userID.toString(),
      //   userType: 'user',
      // );

      // final accountSetupController = Get.find<AccountSetupController>();
      // accountSetupController.txtName.text = firstName.value;
      // accountSetupController.txtLastName.text = lastName.value;
      //
      // if ((responseModel.randomGenNo ?? "").isEmpty) {
      //   final pref = await SharedPreferences.getInstance();
      //   await pref.setString('isNameAdded', 'true');
      //   Get.to(() => DashBoardScreen());
      // } else {
      //   Get.to(() => SetUpNameScreen());
      // }
    } catch (e, stack) {
      print("Login API Exception: $e\n$stack");
      //errorSuccessDialog("Failed... something went wrong", Get.context!, "0");
    }
  }


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
