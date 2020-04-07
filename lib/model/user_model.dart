import 'dart:convert';

class User {
  String userName;
  String email;
  String id;

  User({
    this.userName,
    this.email,
    this.id,
  });

  User copyWith({
    String userName,
    String email,
    String id,
  }) {
    return User(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'id': id,
    };
  }

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      userName: map['userName'],
      email: map['email'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static User fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'User(userName: $userName, email: $email, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.userName == userName &&
        o.email == email &&
        o.id == id;
  }

  @override
  int get hashCode => userName.hashCode ^ email.hashCode ^ id.hashCode;
}
