import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final int id;
  final String name;
  final String userName;
  final String token;

  // final AuthUserModel user;

  const AuthModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.token,
  });

  factory AuthModel.toModel(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      userName: json['username'] ?? '',
      token: json['token'] ?? '',

      // user: AuthUserModel.toModel(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': userName,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [token, name, userName, id];
}
