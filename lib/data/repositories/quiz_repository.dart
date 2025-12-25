import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/quiz_remote_ds.dart';
import 'package:ezdu/data/models/quiz_model.dart';
import 'package:ezdu/services/user_onboarding_service.dart';

class QuizRepository {
  final QuizRemoteDataSource _remoteDataSource;

  QuizRepository({required QuizRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<QuizModel>>> getQuizList() async {
    try {
      final classId = await UserOnboardingService.getClassId();
      if (classId == null) {
        ApiResponse.error("Please set up your profile in setting");
      }

      final result = await _remoteDataSource.getQuizList(classId!);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<QuizModel>> getQuiz(int quizId) async {
    try {
      final result = await _remoteDataSource.getQuiz(quizId);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<QuizModel>> getUpcomingQuiz() async {
    try {
      final classId = await UserOnboardingService.getClassId();
      if (classId == null) {
        ApiResponse.error("Please set up your profile in setting");
      }

      final result = await _remoteDataSource.getUpcomingQuiz(classId!);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }




}
