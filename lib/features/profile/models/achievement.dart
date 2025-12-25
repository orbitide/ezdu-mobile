import 'package:equatable/equatable.dart';

class Achievement extends Equatable {
  final int id;
  final String title;
  final String description;
  final int xp;
  final DateTime unlockedAt;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.xp,
    required this.unlockedAt,
  });

  @override
  List<Object?> get props => [id, title, description, xp, unlockedAt];
}