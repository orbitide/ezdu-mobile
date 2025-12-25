import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/constants/app_constants.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/core/utils/helpers.dart';
import 'package:ezdu/data/models/quiz_model.dart';
import 'package:ezdu/data/repositories/quiz_repository.dart';
import 'package:ezdu/features/archive/models/archive_quiz_settings_model.dart';
import 'package:ezdu/features/play/pages/quiz_play_page.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.quizRepository});

  final QuizRepository quizRepository;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Admin Created Quizzes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          Column(
            children: [
              FutureBuilder(
                future: quizRepository.getQuizList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text('Loading subjects...'),
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
                          'Error loading data: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasData &&
                      snapshot.data!.data != null &&
                      snapshot.data!.data!.items.isNotEmpty) {
                    final quizzes = snapshot.data!.data!.items;

                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: quizzes.length,
                      itemBuilder: (context, index) {
                        final quiz = quizzes[index];
                        bool isExpired = TimeHelper.isUtcTimeExpired(
                          quiz.endTime,
                        );
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            quiz.name,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'subjectname',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: isExpired
                                            ? Colors.red[100]
                                            : Colors.green[100],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isExpired
                                                ? Icons.error
                                                : Icons.check_circle,
                                            color: isExpired
                                                ? Colors.red
                                                : Colors.green,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            isExpired ? 'Expired' : 'Active',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: isExpired
                                                  ? Colors.red
                                                  : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  quiz.description,
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 16,
                                      color: Colors.grey[600],
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        TimeHelper.formatUtcToLocal(
                                          quiz.startTime,
                                        ),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Duration: ${quiz.durationInMinutes} min',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: !isExpired
                                        ? () => _showQuizSettingsDialog(
                                            context,
                                            quiz.id,
                                          )
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isExpired
                                          ? Colors.grey
                                          : Colors.purple,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    child: Text(
                                      isExpired ? 'Quiz Expired' : 'Start Quiz',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Text(
                      'No quiz found.',
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showQuizSettingsDialog(BuildContext context, int quizId) async {
    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final response = await quizRepository.getQuiz(quizId);
    if (!context.mounted) return;
    Navigator.pop(context);

    if (response.success) {
      final quiz = response.data!;

      if (quiz.questions.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('No Data'),
            content: const Text(
              'No questions found, choose more or different topics',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Start quiz'),
          content: const Text('Are you ready?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                final settings = ArchiveQuizSettingsModel(
                  timeInMinutes: quiz.durationInMinutes,
                  enableNegativeMarking: false,
                  negativeMarkValue: 0,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPlayPage(
                      questions: quiz.questions,
                      settings: settings,
                      progressRepository: sl(),
                      quizType: QuizType.Quiz,
                      title: quiz.name,
                      quizId: quiz.id,
                    ),
                  ),
                );
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: Text(response.message ?? 'Failed to load questions.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
