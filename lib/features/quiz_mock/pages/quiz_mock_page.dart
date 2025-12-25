import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/subject_repository.dart';
import 'package:ezdu/features/quiz_mock/pages/lesson_topic_selection.dart';
import 'package:ezdu/features/quiz_mock/pages/subject_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuizMockTab extends ConsumerWidget {
  final SubjectRepository subjectRepository;
  final isQuizActive = false;

  const QuizMockTab({super.key, required this.subjectRepository});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSubjectSelected(SubjectModel subject) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LessonTopicSelectionPage(
            subject: subject,
            lessonRepository: sl(),
          ),
        ),
      );
    }

    if (isQuizActive) {
      return const Center(child: Text('Quiz in progress...'));
    }

    return SubjectSelectionPage(
      subjectListFuture: subjectRepository.getSubjectList(),
      onSubjectSelected: onSubjectSelected,
    );
  }
}
