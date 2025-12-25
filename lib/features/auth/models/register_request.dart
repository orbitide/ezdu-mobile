class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final RegisterProfileRequestModel profile;

  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    required this.profile,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'profile': profile,
    };
  }
}

class RegisterProfileRequestModel {
  final int classId;

  RegisterProfileRequestModel({required this.classId});

  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
    };
  }
}
