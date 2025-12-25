import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/question_model.dart';
import 'package:ezdu/services/dio_client.dart';

class QuestionRemoteDataSource {
  final DioClient _dioClient;

  QuestionRemoteDataSource(this._dioClient);

  Future<PagedList<QuestionModel>> getQuestionsByTopicIds(List<int> ids) async {
    var response = await _dioClient.post(
      'questions/by-topic-ids',
      data: ids,
      fromJson: (json) => PagedList.toModel(json, QuestionModel.toModel),
    );

    return response;
  }
}
