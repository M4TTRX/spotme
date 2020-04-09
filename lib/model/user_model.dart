import 'dart:convert';

class User {
  String username;
  String email;
  String id;

  User({
    this.username,
    this.email,
    this.id,
  });

  User copyWith({
    String username,
    String email,
    String id,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'id': id,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      username: map['username'],
      email: map['email'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User(username: $username, email: $email, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.username == username &&
        o.email == email &&
        o.id == id;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ id.hashCode;
}
