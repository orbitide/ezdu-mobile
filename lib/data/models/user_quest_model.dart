class UserQuestModel {
  final int userId;
  final int questId;
  final bool completed;
  final String title;
  final String description;
  final int progress;
  final int target;

  UserQuestModel({
    required this.userId,
    required this.questId,
    required this.completed,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
  });

  factory UserQuestModel.toModel(Map<String, dynamic> json) {
    return UserQuestModel(
      userId: json['userId'] ?? 0,
      questId: json['questId'] ?? 0,
      completed: json['completed'] ?? false,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      progress: json['progress'] ?? 0,
      target: json['target'] ?? 0,
    );
  }
}
