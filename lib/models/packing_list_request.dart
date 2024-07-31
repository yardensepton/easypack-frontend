class PackingListRequest {
  final List<String>? items;
  final List<String>? activities;
  final bool isWork;

  PackingListRequest({required this.isWork, this.items, this.activities});

  factory PackingListRequest.fromJson(Map<String, dynamic> json) {
    return PackingListRequest(
      isWork: json['is_work'],
      items: json['items_preferences'],
      activities: json['activities_preferences'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activities_preferences': activities,
      'items_preferences': items,
      'is_work': isWork,
    };
  }
}
