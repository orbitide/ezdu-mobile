class UserQuizModel {
  final String title;
  final int type;
  final String time;
  final int percentage;

  UserQuizModel({
    required this.title,
    required this.type,
    required this.time,
    required this.percentage,
  });

  factory UserQuizModel.toModel(Map<String, dynamic> json) {
    return UserQuizModel(
      title: json['title'] ?? '',
      type: json['type'] ?? 0,
      time: json['time'] ?? '',
      percentage: json['percentage'] ?? 0,
    );
  }
}
