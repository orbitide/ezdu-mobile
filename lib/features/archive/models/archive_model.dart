import 'package:equatable/equatable.dart';
import 'package:ezdu/data/models/question_model.dart';

// archived exam model
class ArchiveModel extends Equatable {
  final int id;
  final String name;

  final int classId;
  final int subjectId;
  final int instituteId;
  final int year;
  final List<QuestionModel> questions;

  const ArchiveModel({
    required this.id,
    required this.classId,
    required this.subjectId,
    required this.instituteId,
    required this.year,
    required this.name,
    required this.questions,
  });

  factory ArchiveModel.toModel(Map<String, dynamic> json) {
    return ArchiveModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      classId: json['classId'] ?? 0,
      subjectId: json['subjectId'] ?? 0,
      instituteId: json['instituteId'] ?? 0,
      year: json['year'] ?? 0,
      questions:
          (json['questions'] as List<dynamic>?)
              ?.map((q) => QuestionModel.toModel(q))
              .toList() ??
          [],
    );
  }

  @override
  List<Object?> get props => [];
}
