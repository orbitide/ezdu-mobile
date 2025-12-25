import 'package:equatable/equatable.dart';

class GroupModel extends Equatable {
  final int id;
  final String name;

  const GroupModel({
    required this.id,
    required this.name,
  });

  factory GroupModel.toModel(Map<String, dynamic> json) {

    return GroupModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? ''
    );
  }

  @override
  List<Object?> get props => [];
}
