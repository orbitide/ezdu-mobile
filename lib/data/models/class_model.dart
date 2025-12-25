import 'package:equatable/equatable.dart';

class ClassModel extends Equatable {
  final int id;
  final String name;

  const ClassModel({
    required this.id,
    required this.name,
  });

  factory ClassModel.toModel(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [];
}
