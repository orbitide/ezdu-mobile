import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/user_quest_model.dart';
import 'package:ezdu/services/dio_client.dart';

class UserQuestRemoteDataSource {
  final DioClient _dioClient;

  UserQuestRemoteDataSource(this._dioClient);

  Future<PagedList<UserQuestModel>> getDailyQuestList({
    int? page,
    int? size,
  }) async {
    var params = {"pageSize": size ?? 50};

    var response = await _dioClient.get(
      'quests/daily',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, UserQuestModel.toModel),
    );

    return response;
  }
}
