import 'dart:convert';

class User {
  String? name;
  String? email;
  String? password;

  User({
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map.containsKey('name') ? map['name'] : null,
      email: map['email'],
      password: map['password'],
    );
  }

  String toStringJson() => json.encode(toJson());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.email == email && other.password == password;
  }

  @override
  int get hashCode => Object.hash(email, password);
}
