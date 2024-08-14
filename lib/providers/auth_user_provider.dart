import 'dart:async';
import 'package:easypack/constants/constants_classes.dart';
import 'package:easypack/models/city.dart';
import 'package:easypack/models/user.dart';
import 'package:easypack/utils/string_extentsion.dart';
import 'package:flutter/material.dart';
import 'package:easypack/services/user_service.dart';
import 'package:hive/hive.dart';

class AuthUserProvider with ChangeNotifier {
  bool isAuthenticated = false;
  String? accessToken;
  String? refreshToken;
  TextEditingController userName = TextEditingController();
  late String cityName;
  late String gender;
  TextEditingController userNameUpdate = TextEditingController();
  Box<String> currentUserBox = Hive.box(Boxes.currentUserBox);

  AuthUserProvider() {
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    String? name = currentUserBox.get("name");
    if (name != null) {
      userName.text = name.capitalize();
    } else {
      userName.text = '';
    }
    notifyListeners();
  }

  Future<String?> authUser(
      BuildContext context, String username, String password) async {
    try {
      String? result = await UserService().authUser(username, password);
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
      String? result = await UserService().forgotPassword(email);
      notifyListeners();
      return result;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> getAccessToken() async {
    try {
      accessToken = await UserService.getAccessToken();
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
      refreshToken = await UserService.getRefreshToken();
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
    await UserService.logOutUser();
    notifyListeners();
  }

  Future<void> checklogOutUser() async {
    accessToken = await UserService.getAccessToken();
    refreshToken = await UserService.getRefreshToken();
    if (accessToken == null || refreshToken == null) {
      isAuthenticated = false;
      userName.clear();
      notifyListeners();
    }
  }

  Future<void> getCurrentUser() async {
    try {
      User? currentUser = await UserService().getCurrentUser();
      cityName = currentUser!.city!.text;
      gender = currentUser.gender;
      userNameUpdate.text = currentUser.name;
      print(cityName);
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<User?> updateCurrentUser(
      String? newGender, String? newName, City? newCity) async {
    try {
      User? user = await UserService().updateCurrentUser(
          newCity: newCity, newGender: newGender, newName: newName);
          _initializeAuth();
          return user;
    } catch (e) {
      throw Exception('$e');
    }
  }
}
