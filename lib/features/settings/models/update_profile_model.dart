import 'package:equatable/equatable.dart';

class UpdateProfileModel extends Equatable {
  final String name;
  final String userName;
  final String email;
  final String avatar;

  // final AuthUserModel user;

  const UpdateProfileModel({
    required this.name,
    required this.userName,
    required this.email,
    required this.avatar
  });

  factory UpdateProfileModel.toModel(Map<String, dynamic> json) {
    return UpdateProfileModel(
      name: json['name'] ?? '',
      userName: json['username'] ?? '',
      email: json['email'] ?? '',
      avatar: json['photoUrl'] ?? '',

      // user: AuthUserModel.toModel(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': userName,
      'email': email,
      'photoUrl': avatar,
    };
  }

  @override
  List<Object?> get props => [email, name, userName];
}
