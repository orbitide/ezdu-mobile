import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/services/dio_client.dart';

class NotificationRemoteDataSource {
  final DioClient _dioClient;

  NotificationRemoteDataSource(this._dioClient);

  Future<ApiResponse> fcmToken(String token) async {
    final Map<String, dynamic> tokenRegisterDto = {'token': token};

    var response = await _dioClient.post(
      'feed/fcm-token',
      data: tokenRegisterDto,
      fromJson: (json) => ApiResponse.toModel(json, null),
    );

    return response;
  }
}
