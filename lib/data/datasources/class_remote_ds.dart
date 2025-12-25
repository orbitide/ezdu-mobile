import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/class_model.dart';
import 'package:ezdu/data/models/group_model.dart';
import 'package:ezdu/services/dio_client.dart';

class ClassRemoteDataSource {
  final DioClient _dioClient;

  ClassRemoteDataSource(this._dioClient);

  Future<PagedList<ClassModel>> getOnboardingClassList(
    int segment, {
    int? page,
    int? size,
  }) async {
    var params = {"segment": segment, "pageSize": size ?? 50};

    var response = await _dioClient.get(
      'classes/onboarding',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, ClassModel.toModel),
    );

    return response;
  }


  Future<PagedList<GroupModel>> getGroupList(
      int classId, {
        int? page,
        int? size,
      }) async {
    var params = {"classId": classId, "pageSize": size ?? 50};

    var response = await _dioClient.get(
      'groups/onboarding',
      queryParameters: params,
      fromJson: (json) => PagedList.toModel(json, GroupModel.toModel),
    );

    return response;
  }
}
