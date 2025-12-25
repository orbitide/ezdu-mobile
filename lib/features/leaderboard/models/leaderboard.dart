class LeaderboardModel {
  final int rank;
  final int userId;
  final String userName;
  final String name;
  final String userImageUrl;
  final int xp;
  final int streakCount;

  LeaderboardModel({
    required this.rank,
    required this.userId,
    required this.userName,
    required this.name,
    required this.userImageUrl,
    required this.xp,
    required this.streakCount,
  });

  factory LeaderboardModel.toModel(Map<String, dynamic> json) {
    return LeaderboardModel(
      rank: json['rank'] ?? 0,
      userId: json['userId'] ?? 0,
      userName: json['userName'] ?? '',
      name: json['name'] ?? '',
      userImageUrl: json['userImageUrl'] ?? '',
      xp: json['xp'] ?? '',
      streakCount: json['streakCount'] ?? 0,
    );
  }
}
