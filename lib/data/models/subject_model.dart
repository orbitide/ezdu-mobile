import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable {
  final int id;
  final String name;
  final String code;
  final int activeQuizCount;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.code,
    required this.activeQuizCount,
  });

  factory SubjectModel.toModel(Map<String, dynamic> json) {

    return SubjectModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      activeQuizCount: 56
    );
  }

  @override
  List<Object?> get props => [];
}
