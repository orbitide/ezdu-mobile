import 'package:equatable/equatable.dart';

class OptionModel extends Equatable {
  final int id;
  final String name;

  final bool isCorrect;

  const OptionModel({
    required this.id,
    required this.name,
    required this.isCorrect,
  });

  factory OptionModel.toModel(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'],
      name: json['name'],
      isCorrect: json['isCorrect'],
    );
  }

  @override
  List<Object?> get props => [];
}
