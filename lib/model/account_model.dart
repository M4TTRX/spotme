import 'dart:convert';

class Account {
  String? username;
  String? email;
  String? id;

  Account({
    this.username,
    this.email,
    this.id,
  });

  Account copyWith({
    String? username,
    String? email,
    String? id,
  }) {
    return Account(
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

  static Account? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return Account(
      username: map['username'],
      email: map['email'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static Account? fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Account(username: $username, email: $email, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Account &&
        o.username == username &&
        o.email == email &&
        o.id == id;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode ^ id.hashCode;
}
