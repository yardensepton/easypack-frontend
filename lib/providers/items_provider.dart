import 'package:easypack/services/item_service.dart';
import 'package:flutter/material.dart';

class ItemsProvider extends ChangeNotifier{

  ItemService itemService = ItemService();
  List<String>? specialItemsNames = [];
  List<String>? activities = [];

  Future<void> fetchItemsNamesByCategory()async{
    try{
     specialItemsNames = await itemService.fetchItemsNamesByCategory();

    }catch(e){
      throw Exception('$e');
    }
    
  }







}