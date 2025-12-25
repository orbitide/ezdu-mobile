import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/lesson_remote_ds.dart';
import 'package:ezdu/data/models/lesson_model.dart';

class LessonRepository {
  final LessonRemoteDataSource _remoteDataSource;

  LessonRepository({required LessonRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<LessonWithTopicModel>>> getLessonWithTopics(
    int subjectId,
  ) async {
    try {
      final result = await _remoteDataSource.getLessonListWithTopics(subjectId);
      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
