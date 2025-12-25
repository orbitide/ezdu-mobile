class ForumComment {
  final int id;
  final int postId;
  final String userId;
  final String userName;
  final String userAvatar;
  final String content;
  final DateTime createdAt;
  int upvotes;
  bool isUpvoted;

  ForumComment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.content,
    required this.createdAt,
    this.upvotes = 0,
    this.isUpvoted = false,
  });
}
