import 'dart:async';
import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/utils/string_extentsion.dart';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_service.dart';
import 'package:hive/hive.dart';


class AuthUserProvider with ChangeNotifier {
  final UserService _userAPIService = UserService();
  bool isAuthenticated = false;
  String? accessToken;
  String? refreshToken;
  TextEditingController userName = TextEditingController();
  Box<String> currentUserBox = Hive.box(Boxes.currentUserBox);

  AuthUserProvider() {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
     userName.text = currentUserBox.get("name")!.capitalize();
    notifyListeners();
  }

  Future<String?> authUser(
      BuildContext context, String username, String password) async {
    try {
      String? result = await _userAPIService.authUser(username, password);
      if (result == null) {
        isAuthenticated = true;
         userName.text = currentUserBox.get("name")!.capitalize();
         print(currentUserBox.get("name")!.capitalize());
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
    userName.clear();
    currentUserBox.clear();
    await _userAPIService.logOutUser();
    notifyListeners();
  }

  Future<void> checklogOutUser() async {
    accessToken = await _userAPIService.getAccessToken();
    refreshToken = await _userAPIService.getRefreshToken();
    if (accessToken == null || refreshToken == null) {
      isAuthenticated = false;
      userName.clear();
      notifyListeners();
    }
  }
}
