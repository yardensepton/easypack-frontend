import 'package:easypack/services/item_service.dart';
import 'package:flutter/material.dart';

class ItemsProvider extends ChangeNotifier {
  ItemService itemService = ItemService();
  List<String>? specialItemsNames = [];
  List<String>? activities = [];

  Future<void> fetchStepperData() async {
    try {
      specialItemsNames = await itemService.fetchItemsNamesByCategory();
      activities = await itemService.fetchCategories(activity: true);
      print('Special Items Names: $specialItemsNames');
      print('Activities: $activities');
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Future<void> fetchItemsNamesByCategory() async {
  //   try {
  //     specialItemsNames = await itemService.fetchItemsNamesByCategory();
  //   } catch (e) {
  //     throw Exception('$e');
  //   }
  // }

  // Future<void> fectchActivitiesNames() async {
  //   try {
  //     activities = await itemService.fetchCategories();
  //   } catch (e) {
  //     throw Exception('$e');
  //   }
  // }
}
