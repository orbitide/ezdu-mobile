import 'package:equatable/equatable.dart';

class AuthUserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final int totalXP;
  final int streak;

  const AuthUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.totalXP,
    required this.streak,
  });

  factory AuthUserModel.toModel(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      totalXP: json['totalXP'] ?? '',
      streak: json['streak'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, email, totalXP, streak];
}
