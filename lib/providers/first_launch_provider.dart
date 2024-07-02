import 'package:easypack/constants/constants_classes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FirstLaunchProvider with ChangeNotifier {
  Box<bool> box = Hive.box(Boxes.settingsBox);

  bool isFirstLaunch() {
    if (box.containsKey('isFirstLaunch')) {
      return false;
    }
    return true;
  }

  void setLaunched() async {
    await box.put('isFirstLaunch', false);
    notifyListeners();
  }
}
