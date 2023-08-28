import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final int? user_id;
  final String name;
  final String email;
  final String phone;
  final String password;

  UserModel({
    this.user_id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  UserModel copyWith({
    int? user_id,
    String? name,
    String? email,
    String? phone,
    String? password,
  }) {
    return UserModel(
      user_id: user_id ?? this.user_id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(user_id: $user_id, name: $name, email: $email, phone: $phone, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.user_id == user_id &&
      other.name == name &&
      other.email == email &&
      other.phone == phone &&
      other.password == password;
  }

  @override
  int get hashCode {
    return user_id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      password.hashCode;
  }
}
