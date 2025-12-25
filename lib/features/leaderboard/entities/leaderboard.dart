import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final int userId;
  final String userName;
  final int xp;
  final int streak;
  final String? imageUrl;

  const LeaderboardEntry({
    required this.userId,
    required this.userName,
    required this.xp,
    required this.streak,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [userId, userName, xp, streak, imageUrl];
}

class LeaderboardData extends Equatable{
  final List<LeaderboardEntry> todayEntries;
  final List<LeaderboardEntry> weeklyEntries;
  final List<LeaderboardEntry> allTimeEntries;

  const LeaderboardData({
    required this.todayEntries,
    required this.weeklyEntries,
    required this.allTimeEntries,
  });

  @override
  List<Object?> get props => [todayEntries, weeklyEntries, allTimeEntries];
}
