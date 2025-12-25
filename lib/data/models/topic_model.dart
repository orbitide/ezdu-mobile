import 'package:equatable/equatable.dart';

class TopicModel extends Equatable {
  final int id;
  final String name;
  final int lessonId;

  const TopicModel({
    required this.id,
    required this.name,
    required this.lessonId,
  });

  @override
  List<Object?> get props => [];

  factory TopicModel.toModel(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'],
      name: json['name'],
      lessonId: json['lessonId'] ?? 0,
    );
  }
}
