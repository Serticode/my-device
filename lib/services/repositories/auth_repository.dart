/* // ignore_for_file: body_might_complete_normally_catch_error
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:my_device/services/cache/user_details_cache.dart';
import 'package:my_device/services/models/auth/user_model/user_model.dart';
import 'package:my_device/shared/utils/failure.dart';
import 'package:my_device/shared/utils/type_defs.dart';
import 'package:http/http.dart' as http;

final Provider<AuthRepository> authRepositoryProvider =
    Provider((ref) => const AuthRepository());

class AuthRepository {
  //! CONSTRUCTOR
  const AuthRepository();

  //! GET LOGGED IN USER
  Future<UserModel?> get loggedInUser async =>
      await UserDetailsCache.getUserDetails();

  //! IS USER SIGNED IN?
  Future<bool?> get isAlreadyLoggedIn async => await loggedInUser != null;

  //! REGISTER USER
  //! USING FUTURE EITHER -
  FutureEither<AuthResult> signUpUser(
      {required String email,
      required String password,
      required String firstName,
      required String lastName}) async {
    try {
      //! MAKE REQUEST
      http.Request request = http.Request("POST", Uri.parse(AppUrls.signUp));

      //! ADD HEADER SUPPORTS
      request.headers
          .addAll({"Content-Type": "application/json; charset=UTF-8"});

      //! REQUEST BODY
      request.body = jsonEncode({
        "password": password,
        "email": email,
        "firstname": firstName,
        "lastname": lastName
      });

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      switch (responseInMap["success"]) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case true:
          log(responseInMap.toString());
          //! CONVERT DATA TO MODEL
          UserModel registeredUser =
              UserModel.fromJSON(responseInMap["data"]["user"]);

          //! CACHE ACCESS TOKEN
          await TokenCache.cacheUserTokens(
              token: responseInMap["data"]["token"]);

          //! CACHE USER DETAILS
          await UserDetailsCache.cacheUserDetails(
              theUserDetails: registeredUser);

          return right(AuthResult.success);

        //! ACCOUNT ALREADY EXISTS
        case false:
          log("Sign Up Response Failure: $responseStream");
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["errors"]));

        //! SERVER REQUEST FAILED OR ANY OTHER FAILURE TYPE
        default:
          log("Default Sign Up Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}");
          return left(Failure(responseInMap["errors"]));
      }
    } catch (error) {
      log("User Sign Up Error ${error.toString()}");
      log(error.toString());
      return left(Failure(error.toString()));
    }
  }

  //!
  //!
  //! SIGN IN USER
  FutureEither<AuthResult> signInUser(
      {required String email, required String password}) async {
    try {
      //! MAKE REQUEST, ADD HEADER SUPPORTS, REQUEST BODY AND SEND REQUEST
      http.Request request = http.Request("POST", Uri.parse(AppUrls.login))
        ..headers.addAll({"Content-Type": "application/json; charset=UTF-8"})
        ..body = jsonEncode({"password": password, "emailOrUsername": email});

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      switch (responseInMap["success"]) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case true:
          await TokenCache.cacheUserTokens(
                  token: responseInMap["data"]["user"]["token"])
              .whenComplete(() {})
              .catchError((error) {
            log("Cache User Token Error: ${error.toString()}");
          });

          //! DECLARE DATE FOR REQUESTING TRANSACTION HISTORY
          final DateTime theDate = DateTime.now();

          //! CACHE USER TOKEN
          /* await Future.wait([
            ProfileRepository().getUserInfo(),
            ProfileRepository().fetchFavouritesList(),
            ProfileRepository().getUserNotifications(),
            WalletRepository().fetchTotalMonthlyDebitTransactionList(
                year: theDate.year.toString()),
            WalletRepository().fetchTotalMonthlyCreditTransactionList(
                year: theDate.year.toString()),
            WalletRepository().getTransactionHistoryByMonth(
                year: theDate.year.toString(),
                month: getMonth(dateTime: theDate)),
            WalletRepository().getWalletBalance(),
          ],
                  cleanUp: (successValue) => log(
                      "Future Wait Success Value: ${successValue.toString()}"))
              .catchError((error) {
            for (var element in error) {
              log(element.toString());
            }
          }); */

          return right(AuthResult.success);

        //! UNAUTHORIZED - WRONG PASSWORD
        case false:
          log("Response: $responseStream");
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          return left(Failure(responseInMap["errors"]));

        //! SERVER REQUEST FAILED OR ANY OTHER FAILURE TYPE
        default:
          log("Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}");

          return left(Failure(responseInMap["errors"]));
      }
    } catch (error) {
      log("CATCH ERROR ${error.toString()}");
      return left(Failure(error.toString()));
    }
  }

  //!
  //!
  //! CHANGE PASSWORD
  FutureEither<String> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      //! MAKE REQUEST, ADD HEADER SUPPORTS, REQUEST BODY AND SEND REQUEST
      http.Request request =
          http.Request("PATCH", Uri.parse(AppUrls.changePassword))
            ..headers.addAll({
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer ${userToken.first?.token}"
            })
            ..body = jsonEncode(
                {"oldPassword": oldPassword, "newPassword": newPassword});

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      //! SWITCH AND GET RESPONSE
      return authResponseSwitch(
          response: response,
          responseInMap: responseInMap,
          responseStream: responseStream);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  //!
  //!
  //! FORGOT PASSWORD
  FutureEither<String> forgotPassword({required String email}) async {
    try {
      //! MAKE REQUEST, ADD HEADER SUPPORTS, REQUEST BODY AND SEND REQUEST
      http.Request request = http.Request(
          "POST", Uri.parse(AppUrls.forgotPassword))
        ..headers.addAll({"Content-Type": "application/json; charset=UTF-8"})
        ..body = jsonEncode({"email": email});

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      log(responseInMap.toString());

      //! SWITCH AND GET RESPONSE
      return authResponseSwitch(
          response: response,
          responseInMap: responseInMap,
          responseStream: responseStream);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  //!
  //!
  //! RESET PASSWORD
  FutureEither<String> resetPassword(
      {required String email,
      required String password,
      required String emailedToken}) async {
    try {
      //! MAKE REQUEST, ADD HEADER SUPPORTS, REQUEST BODY AND SEND REQUEST
      http.Request request = http.Request(
          "PATCH", Uri.parse(AppUrls.resetPassword))
        ..headers.addAll({"Content-Type": "application/json; charset=UTF-8"})
        ..body = jsonEncode(
            {"email": email, "newPassword": password, "token": emailedToken});

      //! SEND REQUEST
      http.StreamedResponse response = await request.send();

      //! HOLD RESPONSE
      String responseStream = await response.stream.bytesToString();

      //! RESPONSE CONVERTED TO MAP, USED TO RUN AUTH TEST CASES AND DECIDE WHAT ACTION TO TAKE AS SEEN BELOW
      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      log(responseInMap.toString());

      //! SWITCH AND GET RESPONSE
      return authResponseSwitch(
          response: response,
          responseInMap: responseInMap,
          responseStream: responseStream);
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  //!
  //!
  //! REAUTHENTICATE WITH PIN
  FutureEither<String> reauthenticateWithPin({required String pin}) async {
    try {
      //! FETCH USER TOKEN
      final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

      http.Request request =
          http.Request("POST", Uri.parse(AppUrls.reauthenticateWithPin))
            ..headers.addAll({
              "Content-Type": "application/json; charset=UTF-8",
              "Authorization": "Bearer ${userToken.first?.token}"
            })
            ..body = jsonEncode({"pin": pin});

      http.StreamedResponse response = await request.send();

      String responseStream = await response.stream.bytesToString();

      Map<String, dynamic> responseInMap = jsonDecode(responseStream);

      log(responseInMap.toString());

      //! SWITCH AND GET RESPONSE
      switch (responseInMap["success"]) {
        //! SERVER REQUEST WAS SUCCESSFUL
        case true:
          await TokenCache.cacheUserTokens(
              token: responseInMap["data"]["token"]);

          return right(responseInMap["message"]);

        //! UNAUTHORIZED -  SOMETHING WENT WRONG
        case false:
          //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
          String theErrors = "";

          //! CHECK FOR RESPONSE TYPE
          responseInMap["errors"].runtimeType == List
              ? {
                  for (var error in responseInMap["errors"])
                    {theErrors += "$error \n"}
                }
              : {theErrors = responseInMap["errors"]};

          return left(Failure(theErrors));

        //! SERVER REQUEST FAILED OR ANY OTHER FAILURE TYPE
        default:
          log("Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}");
          return left(Failure(responseInMap["errors"]));
      }
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  //! LOGOUT
  Future<bool> logout() async {
    bool isCacheCleared = false;

    //! CLEAR ALL CACHE
    await Future.wait([
      Hive.deleteFromDisk()
          .whenComplete(() => isCacheCleared = true)
          .catchError((error) => log("Logout Error: $error"))
    ]);

    return isCacheCleared;
  }

  //! SWITCH FUNCTION
  FutureEither<String> authResponseSwitch(
      {required Map<String, dynamic> responseInMap,
      required http.StreamedResponse response,
      required String responseStream}) async {
    switch (responseInMap["success"]) {
      //! SERVER REQUEST WAS SUCCESSFUL
      case true:
        return right(responseInMap["message"]);

      //! UNAUTHORIZED -  SOMETHING WENT WRONG
      case false:
        //! RETURN THE FAILURE, SHOW THE MESSAGE USING SHORTCUT LEFT.
        String theErrors = "";

        //! CHECK FOR RESPONSE TYPE
        responseInMap["errors"].runtimeType == List
            ? {
                for (var error in responseInMap["errors"])
                  {theErrors += "$error \n"}
              }
            : {theErrors = responseInMap["errors"]};

        return left(Failure(theErrors));

      //! SERVER REQUEST FAILED OR ANY OTHER FAILURE TYPE
      default:
        log("Error Code: ${response.statusCode} \nResponse: $responseStream, \nReason: ${response.reasonPhrase}");
        return left(Failure(responseInMap["errors"]));
    }
  }
}
 */