
class NewUser {
  String? id;
  String email;
  String password;
  String role = 'member';

  NewUser({
    this.id,
    required this.password,
    required this.email,
  });

factory NewUser.fromJson(Map<String, dynamic> json) {
    return NewUser(
      id: json['_id'],
      email: json['email'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password
    };
  }


  
}
