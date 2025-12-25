class FeedItem {
  int id;
  String title;
  String message;
  int type;
  String? content;
  String name;
  int userId;
  String? userImageUrl;
  bool isRead;
  int? likeCount;

  int? subjectId;
  String? subject;
  String? subjectImageUrl;
  int? topicId;
  String? topic;

  String createdAt;

  FeedItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.content,
    required this.name,
    required this.userId,
    this.userImageUrl,
    required this.isRead,
    this.likeCount,
    this.subjectId,
    this.subject,
    this.subjectImageUrl,
    this.topicId,
    this.topic,
    required this.createdAt,
  });

  factory FeedItem.toModel(Map<String, dynamic> json) {
    return FeedItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      name: json['name'] ?? '',
      userId: json['userId'] ?? 0,
      userImageUrl: json['userImageUrl'],
      type: json['type'] ?? 0,
      message: json['message'] ?? '',
      content: json['content'] ?? '',
      isRead: json['isRead'] ?? false,
      likeCount: json['likeCount'] ?? 0,

      subjectId: json['subjectId'] ?? 0,
      subject: json['subject'] ?? '',
      subjectImageUrl: json['subjectImageUrl'] ?? '',

      topicId: json['topicId'] ?? 0,
      topic: json['topic'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
