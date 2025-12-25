import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/user_progress_ds.dart';
import 'package:ezdu/data/models/progress_model.dart';
import 'package:ezdu/features/play/datasources/play_quiz_remote_ds.dart';
import 'package:ezdu/features/play/models/user_quiz_model.dart';

class UserProgressRepository {
  final PlayQuizRemoteDataSource _playQuizRemoteDataSource;
  final UserProgressRemoteDataSource _userProgressDataSource;

  UserProgressRepository(
    this._playQuizRemoteDataSource,
    this._userProgressDataSource,
  );

  Future<ApiResponse<ProgressModel>> getMyProgress() async {
    try {
      final result = await _userProgressDataSource.getMyProgress();

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<ProgressModel>> getProgress(int userId) async {
    return ApiResponse(success: false);
  }

  Future<ApiResponse<ProgressModel>> submitQuiz(
    UserQuizSubmissionModel model,
  ) async {
    try {
      final result = await _playQuizRemoteDataSource.submitQuiz(model);
      final response = ApiResponse.success(result);

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
