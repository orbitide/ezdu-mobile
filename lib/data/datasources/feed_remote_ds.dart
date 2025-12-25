import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/feed_model.dart';
import 'package:ezdu/services/dio_client.dart';

class FeedRemoteDataSource {
  final DioClient _dioClient;

  FeedRemoteDataSource(this._dioClient);

  Future<PagedList<FeedItem>> getFeedList({
        int? page,
        int? size,
      }) async {
    var params = {"pageSize": size ?? 50};

    var response = await _dioClient.get(
      'feed',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, FeedItem.toModel),
    );

    return response;
  }
}