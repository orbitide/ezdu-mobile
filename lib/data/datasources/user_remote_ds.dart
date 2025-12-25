import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/user_config_model.dart';
import 'package:ezdu/data/models/user_model.dart';
import 'package:ezdu/features/settings/models/update_profile_model.dart';
import 'package:ezdu/services/dio_client.dart';

class UserRemoteDataSource {
  final DioClient _dioClient;

  UserRemoteDataSource(this._dioClient);

  Future<UserDetailsModel> getUserDetails({
    required int userId,
    int? page,
    int? size,
  }) async {
    var params = {"pageSize": size ?? 50};

    var response = await _dioClient.get(
      'users/details/$userId',
      queryParameters: params,
      fromJson: (json) => UserDetailsModel.toModel(json),
    );

    return response;
  }

  Future<ApiResponse> followUser({required int userId}) async {
    var response = await _dioClient.get(
      'userfollow/follow/$userId',
      fromJson: (json) => ApiResponse.toModel(json, null),
    );

    return response;
  }

  Future<ApiResponse> unFollowUser({required int userId}) async {
    var response = await _dioClient.get(
      'userfollow/unfollow/$userId',
      fromJson: (json) => ApiResponse.toModel(json, null),
    );

    return response;
  }

  Future<UpdateProfileModel> updateProfile(UpdateProfileModel data) async {
    var response = await _dioClient.put(
      'users/update',
      data: data,
      fromJson: (json) => UpdateProfileModel.toModel(json),
    );

    return response;
  }

  Future<UserConfigModel> getConfig() async {
    var response = await _dioClient.get(
      'userconfig',
      fromJson: (json) => UserConfigModel.toModel(json),
    );

    return response;
  }

  Future<UserConfigModel> saveUserConfig(int classId, int? groupId) async {
    var data = {"classId": classId, "groupId": groupId};
    var response = await _dioClient.post(
      'userconfig/save',
      data: data,
      fromJson: (json) => UserConfigModel.toModel(json),
    );

    return response;
  }
}
