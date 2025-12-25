import 'package:equatable/equatable.dart';

import 'option_model.dart';

class QuestionModel extends Equatable {
  final int id;
  final String name;

  final int? subjectId;
  final int? lessonId;
  final int? topicId;
  final int? questionType;
  final String? passage;
  final String? imageUrl;
  final int? difficultyLevel;
  final int? marks;

  // final String tags;
  final String? hint;
  final String? explanation;
  final String? explanationImageUrl;
  final String? explanationResourceUrl;

  final List<OptionModel>? options;
  final int? examId;

  const QuestionModel({
    required this.id,
    required this.name,

    this.subjectId,
    this.lessonId,
    this.topicId,
    this.questionType,
    this.passage,
    this.imageUrl,
    this.difficultyLevel,
    this.marks,
    this.hint,
    this.explanation,
    this.explanationImageUrl,
    this.explanationResourceUrl,
    this.examId,
    this.options,
  });

  factory QuestionModel.toModel(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      subjectId: json['subjectId'],
      lessonId: json['lessonId'],
      topicId: json['topicId'],
      questionType: json['questionType'],
      passage: json['passage'],
      imageUrl: json['imageUrl'],
      difficultyLevel: json['difficultyLevel'],
      marks: json['marks'] ?? 1,
      hint: json['hint'],
      explanation: json['explanation'],
      explanationImageUrl: json['explanationImageUrl'],
      explanationResourceUrl: json['explanationResourceUrl'],
      examId: json['examId'],
      options:
          (json['options'] as List<dynamic>?)
              ?.map((opt) => OptionModel.toModel(opt))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [];
}
