import 'package:equatable/equatable.dart';

class ForumPost extends Equatable {
  final int id;
  final String userId;
  final String userName;
  final String userAvatar;
  final String title;
  final String content;
  final List<String> images;
  final int subjectId;
  final int lessonId;
  final int topicId;
  final DateTime createdAt;
  int upvotes;
  int downvotes;
  bool isUpvoted;
  bool isDownvoted;
  bool isBookmarked;
  int commentCount;

  ForumPost({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.title,
    required this.content,
    required this.images,
    required this.subjectId,
    required this.lessonId,
    required this.topicId,
    required this.createdAt,
    this.upvotes = 0,
    this.downvotes = 0,
    this.isUpvoted = false,
    this.isDownvoted = false,
    this.isBookmarked = false,
    this.commentCount = 0,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
