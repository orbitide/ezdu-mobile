import 'package:equatable/equatable.dart';
import 'package:ezdu/data/models/topic_model.dart';

class LessonModel extends Equatable {
  final int id;
  final String name;
  final int subjectId;

  const LessonModel({
    required this.id,
    required this.name,
    required this.subjectId,
  });

  @override
  List<Object?> get props => [];
}

class LessonWithTopicModel {
  final int id;
  final String name;

  final List<TopicModel>? topics;

  LessonWithTopicModel({required this.id, required this.name, this.topics});

  factory LessonWithTopicModel.toModel(Map<String, dynamic> json) {
    return LessonWithTopicModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      topics:
          (json['topics'] as List<dynamic>?)
              ?.map((topic) => TopicModel.toModel(topic))
              .toList() ??
          [],
    );
  }
}
