import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int user_id;
  final String name;
  final String email;
  final String phone;

  UserModel({
    required this.user_id,
    required this.name,
    required this.email,
    required this.phone,
  });

  UserModel copyWith({
    int? user_id,
    String? name,
    String? email,
    String? phone,
  }) {
    return UserModel(
      user_id: user_id ?? this.user_id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map['user_id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(user_id: $user_id, name: $name, email: $email, phone: $phone)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.user_id == user_id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^ name.hashCode ^ email.hashCode ^ phone.hashCode;
  }
}
