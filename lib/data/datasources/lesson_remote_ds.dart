import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/lesson_model.dart';
import 'package:ezdu/services/dio_client.dart';

class LessonRemoteDataSource {
  final DioClient _dioClient;

  LessonRemoteDataSource(this._dioClient);

  Future<PagedList<LessonWithTopicModel>> getLessonListWithTopics(int subjectId) async{
    var params = {'subjectId': subjectId};

    var response = await _dioClient.get(
      'lessons/withtopics',
      queryParameters: params,
        fromJson: (json) => PagedList.toModel(json, LessonWithTopicModel.toModel)
    );

    return response;
  }
}
