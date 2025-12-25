import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/datasources/user_remote_ds.dart';
import 'package:ezdu/data/models/user_config_model.dart';
import 'package:ezdu/data/models/user_model.dart';
import 'package:ezdu/features/settings/models/update_profile_model.dart';

class UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepository(
      this._remoteDataSource,
      );


  Future<ApiResponse<UserDetailsModel>> getUserDetails(int userId) async {
    try {
      final result = await _remoteDataSource.getUserDetails(userId: userId);
      final response =  ApiResponse.success(result);

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<UpdateProfileModel>> updateProfile(UpdateProfileModel data) async {
    try {
      final result = await _remoteDataSource.updateProfile(data);
      final response =  ApiResponse.success(result);

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }



  Future<ApiResponse> followUser(int userId) async {
    try {
      final result = await _remoteDataSource.followUser(userId: userId);
      final response =  ApiResponse.success(result.data);

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }



  Future<ApiResponse> unFollowUser(int userId) async {
    try {
      final result = await _remoteDataSource.unFollowUser(userId: userId);
      final response =  ApiResponse.success(result.data);

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<UserConfigModel>> getConfig() async {
    try {
      final result = await _remoteDataSource.getConfig();
      final response =  ApiResponse.success(result);

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }

  }

  Future<ApiResponse<UserConfigModel>> saveUserConfig(int classId, int? groupId) async {
    try {
      final result = await _remoteDataSource.saveUserConfig(classId, groupId);
      final response =  ApiResponse.success(result);

      return response;
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }




}
