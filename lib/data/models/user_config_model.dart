import 'package:equatable/equatable.dart';

class UserConfigModel extends Equatable {
  final int segment;
  final int classId;
  final String className;
  final int groupId;
  final String groupName;

  const UserConfigModel({
    required this.segment,
    required this.classId,
    required this.className,
    required this.groupId,
    required this.groupName,
  });

  factory UserConfigModel.toModel(Map<String, dynamic> json) {
    return UserConfigModel(
      segment: json['segment'] ?? 0,
      classId: json['classId'] ?? 0,
      className: json['className'] ?? '',
      groupId: json['groupId'] ?? 0,
      groupName: json['groupName'] ?? '',
    );
  }

  @override
  List<Object?> get props => [];
}
