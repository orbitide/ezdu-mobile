import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/features/auth/models/auth_model.dart';
import 'package:ezdu/features/auth/models/login_request.dart';
import 'package:ezdu/features/auth/models/register_request.dart';
import 'package:ezdu/services/dio_client.dart';

class AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSource(this._dioClient);

  Future<AuthModel> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);

    var response = await _dioClient.post(
      'auth/login',
      data: request,
      fromJson: (json) {
        return AuthModel.toModel(json);
      },
    );

    return response;
  }

  Future<ApiResponse> register(RegisterRequestModel request) async {
    var response = await _dioClient.post(
      'auth/register',
      data: request,
      fromJson: (json) {
        return ApiResponse.toModel(json, null);
      },
    );

    return response;
  }

  Future<AuthModel> verifyCode(int code, String recipient) async {
    final request = {"code": code, "recipient": recipient};
    var response = await _dioClient.post(
      'auth/verify-otp',
      data: request,
      fromJson: (json) {
        return AuthModel.toModel(json);
      },
    );

    return response;
  }
}
