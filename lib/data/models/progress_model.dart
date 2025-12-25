import 'package:equatable/equatable.dart';

class ProgressModel extends Equatable {
  final int id;
  final int userId;
  final String userName;
  final String name;
  final String? userImageUrl;
  final int totalXp;
  final int weekXp;
  final int streakCount;
  final int coin;

  // final List<dynamic> dailyXps;

  const ProgressModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.name,
    required this.userImageUrl,
    required this.totalXp,
    required this.weekXp,
    required this.streakCount,
    required this.coin,
  });

  factory ProgressModel.toModel(Map<String, dynamic> json) {
    return ProgressModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      userName: json['userName'] ?? '',
      name: json['name'] ?? '',
      userImageUrl: json['userImageUrl'] ?? '',
      totalXp: json['totalXp'] ?? 0,
      weekXp: json['weekXp'] ?? 0,
      streakCount: json['streakCount'] ?? 0,
      coin: json['coin'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [];
}
