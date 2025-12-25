import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/leaderboard_remote_ds.dart';
import 'package:ezdu/features/leaderboard/models/leaderboard.dart';

class LeaderboardRepository {
  final LeaderboardRemoteDataSource _remoteDataSource;

  LeaderboardRepository({required LeaderboardRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<LeaderboardModel>>> getWeeklyLeaderboard(
  ) async {
    try {
      final result = await _remoteDataSource.getWeeklyLeaderboard();

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
