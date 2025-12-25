import 'package:ezdu/data/models/user_quiz_model.dart';
import 'package:ezdu/features/profile/models/progress.dart';

class UserDetailsModel {
  final int id;
  final String userName;
  final String email;
  final String name;
  final String photoUrl;
  final String createdAt;
  final String lastActive;
  late bool isFollowing;
  late int following;
  late int followers;
  final int streak;
  final int totalXp;
  final int weekXp;
  final bool streakActive;
  final int percentage;
  final int quizCount;
  final List<DailyProgress> weeklyXp;
  final List<UserQuizModel> quizzes;

  UserDetailsModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.name,
    required this.photoUrl,
    required this.createdAt,
    required this.lastActive,
    required this.isFollowing,
    required this.following,
    required this.followers,
    required this.streak,
    required this.totalXp,
    required this.weekXp,
    required this.streakActive,
    required this.percentage,
    required this.quizCount,
    required this.weeklyXp,
    required this.quizzes,
  });

  factory UserDetailsModel.toModel(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] ?? 0,
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      createdAt: json['createdAt'] ?? '',
      lastActive: json['lastActive'] ?? '',
      following: json['following'] ?? 0,
      followers: json['followers'] ?? 0,
      streak: json['streak'] ?? 0,
      totalXp: json['totalXp'] ?? 0,
      weekXp: json['weekXp'] ?? 0,
      streakActive: json['streakActive'] ?? false,
      isFollowing: json['isFollowing'] ?? false,
      percentage: json['percentage'] ?? 0,
      quizCount: json['quizCount'] ?? 0,
      weeklyXp:
          (json['weeklyXp'] as List<dynamic>?)
              ?.map((q) => DailyProgress.toModel(q))
              .toList() ??
          [],
      quizzes:
          (json['quizzes'] as List<dynamic>?)
              ?.map((q) => UserQuizModel.toModel(q))
              .toList() ??
          [],
    );
  }
}
