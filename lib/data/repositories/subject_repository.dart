import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/subject_remote_ds.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/services/user_onboarding_service.dart';

class SubjectRepository {
  final SubjectRemoteDataSource _remoteDataSource;

  SubjectRepository({required SubjectRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  Future<ApiResponse<PagedList<SubjectModel>>> getSubjectList() async {
    try {
      final classId = await UserOnboardingService.getClassId();
      final groupId = await UserOnboardingService.getGroupId();
      if (classId == null) {
        ApiResponse.error("Please set up your profile in setting");
      }

      final result = await _remoteDataSource.getSubjectList(classId!, groupId!);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<SubjectModel>> getSubject(int subjectId) async {
    try {
      final result = await _remoteDataSource.getSubject(subjectId);

      return ApiResponse.success(result);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
