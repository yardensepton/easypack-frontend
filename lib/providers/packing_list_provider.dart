import 'package:flutter/material.dart';

class PackingListProvider with ChangeNotifier {
  final TextEditingController tripTypeController = TextEditingController();
  Set<String> _selectedSpecialItems = {};
  Set<String> _selectedActivites = {};

  Set<String> get selectedSpecialItems => _selectedSpecialItems;

  Set<String> get selectedActivites => _selectedActivites;

  void addSpecialItem(String item) {
    _selectedSpecialItems.add(item);
    notifyListeners();
  }

  void removeSpecialItem(String item) {
    _selectedSpecialItems.remove(item);
    notifyListeners();
  }

  void addAcivity(String item) {
    _selectedActivites.add(item);
    notifyListeners();
  }

  void removeActivity(String item) {
    _selectedActivites.remove(item);
    notifyListeners();
  }
}
