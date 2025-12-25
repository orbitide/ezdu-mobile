import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/question_remote_ds.dart';
import 'package:ezdu/data/models/question_model.dart';

class QuestionRepository {
  final QuestionRemoteDataSource _remoteDataSource;

  QuestionRepository({required QuestionRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<QuestionModel>>> getQuestionsByTopicIds(
    List<int> ids,
  ) async {
    try {
      final result = await _remoteDataSource.getQuestionsByTopicIds(ids);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
