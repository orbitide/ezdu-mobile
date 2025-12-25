import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/features/archive/datasources/archive_remote_ds.dart';
import 'package:ezdu/features/archive/models/archive_model.dart';

class ArchiveRepository {
  final ArchiveRemoteDataSource _remoteDataSource;

  ArchiveRepository({required ArchiveRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<ArchiveModel>>> getArchivedExamList(
    subjectId,
  ) async {
    try {
      final result = await _remoteDataSource.getArchiveExamList(subjectId);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<ArchiveModel>> getArchivedExam(int subjectId) async {
    try {
      final result = await _remoteDataSource.getArchiveExam(subjectId);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
