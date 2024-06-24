// import 'dart:async';
// import 'dart:ffi';
// import 'package:flutter/material.dart';
// import 'package:easypack/services/user_service.dart';

// class AuthUserProvider with ChangeNotifier {
//   final UserService _userAPIService = UserService();
//   bool isAuthenticated = false;
//   String? accessToken;
//   String? refreshToken;

//   AuthUserProvider(){
//     getAccessToken();
//   }

//   Future<String?> authUser(
//       BuildContext context, String username, String password) async {
//     try {
//       String? result = await _userAPIService.authUser(username, password);
//       notifyListeners();
//       if (result == null) {
//         isAuthenticated = true;
//       }
//       return result;
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<String?> forgotPassword(BuildContext context, String email) async {
//     try {
//       String? result = await _userAPIService.forgotPassword(email);
//       notifyListeners();
//       return result;
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<void> getAccessToken() async {
//     // try {
//     accessToken = await _userAPIService.getAccessToken();
//     notifyListeners();
//     // return result;
//     // } catch (e) {
//     //   return e.toString();
//     // }
//   }

//   Future<void> getRefreshToken(BuildContext context) async {
//     // try {
//     refreshToken = await _userAPIService.getRefreshToken();
//     notifyListeners();
//     // return result;
//     // } catch (e) {
//     //   return e.toString();
//     // }
//   }

//   Future<void> logOutUser(BuildContext context) async {
//     isAuthenticated = false;
//     await _userAPIService.logOutUser();
//     notifyListeners();
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_service.dart';

class AuthUserProvider with ChangeNotifier {
  final UserService _userAPIService = UserService();
  bool isAuthenticated = false;
  String? accessToken;
  String? refreshToken;
  String? userName;

  AuthUserProvider(){
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    await getAccessToken();
    notifyListeners();
  }

  Future<String?> authUser(
      BuildContext context, String username, String password) async {
    try {
      String? result = await _userAPIService.authUser(username, password);
      if (result == null) {
        isAuthenticated = true;
        userName=username;
        notifyListeners();
      }
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> forgotPassword(BuildContext context, String email) async {
    try {
      String? result = await _userAPIService.forgotPassword(email);
      notifyListeners();
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  // Future<void> getAccessToken() async {
  //   accessToken = await _userAPIService.getAccessToken();
  //   print("access token in provider is${accessToken!}");
  //   isAuthenticated = accessToken != null;
  //   notifyListeners();
  // }

    Future<void> getAccessToken() async {
    try {
      accessToken = await _userAPIService.getAccessToken();
      if (accessToken != null) {
        isAuthenticated = true;
      } else {
        isAuthenticated = false;
      }
    } catch (e) {
      accessToken = null; 
      isAuthenticated = false;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getRefreshToken() async {
    try {
      refreshToken = await _userAPIService.getRefreshToken();
    } catch (e) {
      refreshToken = null; 
    } finally {
      notifyListeners();
    }
  }

  Future<void> logOutUser(BuildContext context) async {
    isAuthenticated = false;
    accessToken = null;
    refreshToken = null;
    userName=null;
    await _userAPIService.logOutUser();
    notifyListeners();
  }

  
  Future<void> checklogOutUser() async {
  accessToken = await _userAPIService.getAccessToken();
  refreshToken = await _userAPIService.getRefreshToken();
  if (accessToken == null || refreshToken==null){
    isAuthenticated = false;
    userName=null;
    notifyListeners();
  }
  }
}
