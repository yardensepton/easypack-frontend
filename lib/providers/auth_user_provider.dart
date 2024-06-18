import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_service.dart';

class AuthUserProvider with ChangeNotifier {
  final UserService _userAPIService = UserService();

  Future<String?> authUser(
      BuildContext context, String username, String password) async {
    try {
      String? result = await _userAPIService.authUser(username, password);
      notifyListeners();
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

  Future<String?> getAccessToken(BuildContext context) async {
    try {
      String? result = await _userAPIService.getAccessToken();
      notifyListeners();
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logOutUser(BuildContext context) async {
      await _userAPIService.logOutUser();
      notifyListeners();
  }
}
