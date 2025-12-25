import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/services/dio_client.dart';

class SubjectRemoteDataSource {
  final DioClient _dioClient;

  SubjectRemoteDataSource(this._dioClient);

  Future<PagedList<SubjectModel>> getSubjectList(
    int classId, int groupId, {
    int? page,
    int? size,
  }) async {
    var params = {
      "classId": classId,
      "groupId": groupId,
      "pageSize": size ?? 50,
      "orderBy": "name",
      "sortBy": "asc",
    };

    var response = await _dioClient.get(
      'subjects',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, SubjectModel.toModel),
    );

    return response;
  }

  Future<SubjectModel> getSubject(int subjectId) async {
    var response = await _dioClient.get(
      'subjects/$subjectId',
      fromJson: (json) => SubjectModel.toModel(json),
    );

    return response;
  }
}
