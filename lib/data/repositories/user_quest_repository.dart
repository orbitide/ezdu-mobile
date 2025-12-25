import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/user_quest_remote_ds.dart';
import 'package:ezdu/data/models/user_quest_model.dart';

class UserQuestRepository {
  final UserQuestRemoteDataSource _remoteDataSource;

  UserQuestRepository({required UserQuestRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<UserQuestModel>>> getDailyQuestList() async {
    try {
      final result = await _remoteDataSource.getDailyQuestList();

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
