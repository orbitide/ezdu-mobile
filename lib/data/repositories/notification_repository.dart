import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/notification_remote_ds.dart';

class NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;

  NotificationRepository({
    required NotificationRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  Future<ApiResponse> syncFcmToken(String token) async {
    try {
      final result = await _remoteDataSource.fcmToken(token);

      return ApiResponse.success(result.data, statusCode: result.statusCode);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
