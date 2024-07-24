import 'package:easypack/enums/enum_actions.dart';
import 'package:easypack/models/item_list.dart';

class PackingListUpdate {
  final EnumActions action;
  final ItemList details;

  PackingListUpdate({
    required this.action,
    required this.details,
  });

  factory PackingListUpdate.fromJson(Map<String, dynamic> json) {
    return PackingListUpdate(
      action: json['action'],
      details: ItemList.fromJson(json['details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'action': action.toString().split('.').last,  // Convert Enum to String
      'details': details.toJson(),
    };
  }
}
