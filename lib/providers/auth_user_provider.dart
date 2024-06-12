import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_api_service.dart';

class AuthUserProvider with ChangeNotifier {
  final UserAPIService _userAPIService = UserAPIService();

  Future<String?> authUser(
      BuildContext context, String username, String password) async {
    try {
      String result = await _userAPIService.authUser(username, password);
      if (result=='authenticated') {
        notifyListeners();
        return null;
      }
      return result;
    } catch (e) {
      return e.toString();
    }
  }
}
