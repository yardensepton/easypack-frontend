class ItemDb {
  final String category;
  final String name;
  final String gender;
  final int tempMax;
  final int tempMin;
  final bool isDefault;

  ItemDb({
    required this.category,
    required this.name,
    required this.gender,
    required this.tempMax,
    required this.tempMin,
    required this.isDefault,
  });

  factory ItemDb.fromJson(Map<String, dynamic> json) {
    return ItemDb(
      category: json['category'],
      name: json['name'],
      gender: json['gender'],
      tempMax: json['temp_max'],
      tempMin: json['temp_min'],
      isDefault: json['default'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'name': name,
      'gender': gender,
      'temp_max': tempMax,
      'temp_min': tempMin,
      'default': isDefault,
    };
  }
}
