import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/features/archive/models/archive_model.dart';
import 'package:ezdu/services/dio_client.dart';

class ArchiveRemoteDataSource {
  final DioClient _dioClient;

  ArchiveRemoteDataSource(this._dioClient);

  Future<PagedList<ArchiveModel>> getArchiveExamList(int subjectId, {
    int? page,
    int? size,
  }) async{
    var params = {"subjectId": subjectId, "pageSize": size ?? 50};

    var response = await _dioClient.get(
      'archiveexams',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, ArchiveModel.toModel),
    );

    return response;
  }

  Future<ArchiveModel> getArchiveExam(int archiveId) async {
    var response = await _dioClient.get(
      'archiveexams/$archiveId',
      fromJson: (json) => ArchiveModel.toModel(json),
    );

    return response;
  }
}
