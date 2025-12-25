import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/quiz_model.dart';
import 'package:ezdu/services/dio_client.dart';

class QuizRemoteDataSource {
  final DioClient _dioClient;

  QuizRemoteDataSource(this._dioClient);




  Future<PagedList<QuizModel>> getQuizList(
      int classId, {
        int? page,
        int? size,
      }) async {
    var params = {"classId": classId, "pageSize": size ?? 50};

    var response = await _dioClient.get(
      'quizzes',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, QuizModel.toModel),
    );

    return response;
  }

  Future<QuizModel> getQuiz(int quizId) async {
    var response = await _dioClient.get(
      'quizzes/details/$quizId',
      fromJson: (json) => QuizModel.toModel(json),
    );

    return response;
  }

  Future<QuizModel> getUpcomingQuiz(int classId) async {
    var response = await _dioClient.get(
      'quizzes/upcomming/$classId',
      fromJson: (json) => QuizModel.toModel(json),
    );

    return response;
  }
}
