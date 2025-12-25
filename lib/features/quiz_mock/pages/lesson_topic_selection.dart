import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/lesson_model.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/lesson_repository.dart';
import 'package:ezdu/features/quiz_mock/pages/review_selection.dart';
import 'package:ezdu/features/quiz_mock/widgets/lesson_column.dart';
import 'package:flutter/material.dart';

class LessonTopicSelectionPage extends StatefulWidget {
  const LessonTopicSelectionPage({
    super.key,
    required this.subject,
    required this.lessonRepository,
  });

  final SubjectModel subject;
  final LessonRepository lessonRepository;

  @override
  State<LessonTopicSelectionPage> createState() =>
      _LessonTopicSelectionPageState();
}

class _LessonTopicSelectionPageState extends State<LessonTopicSelectionPage> {
  late Future<ApiResponse<PagedList<LessonWithTopicModel>>> _lessonListFuture;
  late Set<int> selectedLessonIds = {};
  late Set<int> selectedTopicIds = {};

  @override
  void initState() {
    super.initState();
    _lessonListFuture = widget.lessonRepository.getLessonWithTopics(
      widget.subject.id,
    );
  }

  void _onLessonSelected(int lessonId, List<int> topicIds) {
    setState(() {
      if (selectedLessonIds.contains(lessonId)) {
        selectedLessonIds.remove(lessonId);
        selectedTopicIds.removeAll(topicIds);
      } else {
        selectedLessonIds.add(lessonId);
        selectedTopicIds.addAll(topicIds);
      }
    });
  }

  void _onTopicSelected(int topicId) {
    setState(() {
      if (selectedTopicIds.contains(topicId)) {
        selectedTopicIds.remove(topicId);
      } else {
        selectedTopicIds.add(topicId);
      }
    });
  }

  void _onContinue(List<LessonWithTopicModel> lessons) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewSelectionPage(
          lessons: lessons,
          selectedTopicIds: selectedTopicIds,
          questionRepository: sl(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subject.name), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              'Choose Lessons & Topics:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          // Content
          Expanded(
            child: FutureBuilder(
              future: _lessonListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text('Loading lessons...'),
                        ),
                      ],
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Error loading lessons: ${snapshot.error}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (snapshot.hasData &&
                    snapshot.data!.data != null &&
                    snapshot.data!.data!.items.isNotEmpty) {
                  final lessons = snapshot.data!.data!.items;

                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(12),
                          child: Column(children: _buildLessonTopicTree(lessons)),
                        ),
                      ),

                      if (selectedTopicIds.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _onContinue(lessons),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }

                return const Center(child: Text('No lessons found.'));
              },
            ),
          ),

          // Start Button
        ],
      ),
    );
  }

  List<Widget> _buildLessonTopicTree(List<LessonWithTopicModel> lessons) {
    List<Widget> treeWidgets = [];

    for (int i = 0; i < lessons.length; i += 2) {
      List<Widget> rowChildren = [];

      // First lesson column
      rowChildren.add(
        Expanded(
          child: LessonColumn(
            lesson: lessons[i],
            isSelected: selectedLessonIds.contains(lessons[i].id),
            selectedTopicIds: selectedTopicIds,
            onLessonSelected: _onLessonSelected,
            onTopicSelected: _onTopicSelected,
          ),
        ),
      );

      rowChildren.add(const SizedBox(width: 8));

      // Second lesson column (if exists)
      if (i + 1 < lessons.length) {
        rowChildren.add(
          Expanded(
            child: LessonColumn(
              lesson: lessons[i + 1],
              isSelected: selectedLessonIds.contains(lessons[i + 1].id),
              selectedTopicIds: selectedTopicIds,
              onLessonSelected: _onLessonSelected,
              onTopicSelected: _onTopicSelected,
            ),
          ),
        );
      } else {
        rowChildren.add(const Expanded(child: SizedBox()));
      }

      treeWidgets.add(Row(children: rowChildren));
      treeWidgets.add(const SizedBox(height: 8));
    }

    return treeWidgets;
  }
}
