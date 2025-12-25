import 'package:ezdu/data/models/progress_model.dart';
import 'package:ezdu/services/dio_client.dart';

class UserProgressRemoteDataSource {
  final DioClient _dioClient;

  UserProgressRemoteDataSource(this._dioClient);

  Future<ProgressModel> getMyProgress() async {
    var response = await _dioClient.get(
      'progress',
      fromJson: (json) => ProgressModel.toModel(json),
    );
    return response;
  }


}
