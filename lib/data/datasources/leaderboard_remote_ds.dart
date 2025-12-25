import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/features/leaderboard/models/leaderboard.dart';
import 'package:ezdu/services/dio_client.dart';

class LeaderboardRemoteDataSource {
  final DioClient _dioClient;

  LeaderboardRemoteDataSource(this._dioClient);

  Future<PagedList<LeaderboardModel>> getWeeklyLeaderboard({
    int? page,
    int? size,
  }) async {
    var params = {"pageNumber": page ?? 1, "pageSize": size ?? 50};

    var response = await _dioClient.get(
      'leaderboard',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, LeaderboardModel.toModel),
    );

    return response;
  }
}
