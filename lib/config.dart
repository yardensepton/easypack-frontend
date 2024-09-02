import 'dart:convert';
import 'package:flutter/services.dart';

class Config {
  static late String backendUrl;

  static Future<void> loadConfig() async {
    final configString = await rootBundle.loadString('assets/config.json');
    final configData = json.decode(configString);
    backendUrl = configData['backendUrl'];
  }
}
