class User {
  String? id;
  String name;
  String email;
  String gender;
  String residence;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.residence,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      gender: json['gender'],
      residence: json['residence'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'residence': residence,
    };
  }
}
