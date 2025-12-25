import 'package:ezdu/data/models/progress_model.dart';
import 'package:ezdu/features/play/models/user_quiz_model.dart';
import 'package:ezdu/services/dio_client.dart';

class PlayQuizRemoteDataSource {
  final DioClient _dioClient;

  PlayQuizRemoteDataSource(this._dioClient);

  Future<ProgressModel> submitQuiz(UserQuizSubmissionModel model) async {
    var response = await _dioClient.post(
      'userquiz/save',
      data: model,
      fromJson: (json) => ProgressModel.toModel(json),
    );

    return response;
  }
}
