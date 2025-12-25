import 'package:ezdu/data/models/lesson_model.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/models/topic_model.dart';
import 'package:ezdu/features/forum/models/forum_model.dart';
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  final List<SubjectModel> subjects;
  final Map<int, List<LessonModel>> lessons;
  final Map<int, List<TopicModel>> topics;
  final Function(ForumPost) onPostCreated;

  const CreatePostScreen({
    super.key,
    required this.subjects,
    required this.lessons,
    required this.topics,
    required this.onPostCreated,
  });

  @override
  State<StatefulWidget> createState() =>_CreatePostScreenState();

}


class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello from CreatePostScreen"),
    );
  }
}