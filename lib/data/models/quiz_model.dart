import 'package:ezdu/data/models/question_model.dart';

class QuizModel {
  final int id;
  final String name;
  final String description;
  final int type;
  final int totalMarks;
  final int passingMarks;
  final int durationInMinutes;
  final bool hasNegativeMarks;
  final String startTime;
  final String endTime;
  final List<QuestionModel> questions;

  QuizModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.totalMarks,
    required this.passingMarks,
    required this.durationInMinutes,
    required this.hasNegativeMarks,
    required this.startTime,
    required this.endTime,
    required this.questions,
  });

  factory QuizModel.toModel(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 0,
      totalMarks: json['totalMarks'] ?? 0,
      passingMarks: json['passingMarks'] ?? 0,
      durationInMinutes: json['durationInMinutes'] ?? 0,
      hasNegativeMarks: json['hasNegativeMarks'] ?? false,
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((q) => QuestionModel.toModel(q))
              .toList() ??
          [],
    );
  }


}
