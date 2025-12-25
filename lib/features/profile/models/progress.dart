import 'package:equatable/equatable.dart';
import 'package:ezdu/features/profile/models/achievement.dart';

class Progress extends Equatable {
  final int totalXP;
  final int currentStreak;
  final List<DailyProgress> weeklyData;
  final List<Achievement> achievements;

  // final List<Achievement> achievements;

  const Progress({
    required this.totalXP,
    required this.currentStreak,
    required this.weeklyData,
    required this.achievements,
  });

  @override
  List<Object?> get props => [totalXP, currentStreak, weeklyData];
}

class DailyProgress extends Equatable {
  final String day;
  final int xp;

  const DailyProgress({required this.day, required this.xp});

  factory DailyProgress.toModel(Map<String, dynamic> json) {
    return DailyProgress(day: json['day'] ?? '', xp: json['xp'] ?? 0);
  }

  @override
  List<Object?> get props => [day, xp];
}
