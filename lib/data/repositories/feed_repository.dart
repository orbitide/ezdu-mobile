import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/feed_remote_ds.dart';
import 'package:ezdu/data/models/feed_model.dart';

class FeedRepository {
  final FeedRemoteDataSource _remoteDataSource;

  FeedRepository({required FeedRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<FeedItem>>> getFeedList(
  ) async {
    try {
      final result = await _remoteDataSource.getFeedList();

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
