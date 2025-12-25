import 'dart:async';

import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/data/models/option_model.dart';
import 'package:ezdu/data/models/question_model.dart';
import 'package:ezdu/data/repositories/user_progress_repository.dart';
import 'package:ezdu/features/play/models/user_quiz_model.dart';
import 'package:ezdu/features/archive/models/archive_quiz_settings_model.dart';
import 'package:ezdu/features/play/pages/congratulation_page.dart';
import 'package:ezdu/features/archive/widgets/archive_option.dart';
import 'package:ezdu/features/archive/widgets/archive_question.dart';
import 'package:ezdu/features/archive/widgets/archive_question_indicator.dart';
import 'package:flutter/material.dart';

class QuizPlayPage extends StatefulWidget {
  final int quizType;
  final int quizId;
  final String title;
  final ArchiveQuizSettingsModel settings;
  final List<QuestionModel> questions;

  final UserProgressRepository progressRepository;

  const QuizPlayPage({
    super.key,
    required this.quizType,
    required this.quizId,
    required this.title,
    required this.settings,
    required this.questions,
    required this.progressRepository,
  });

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  late int currentQuestionIndex;
  late Timer timer;
  late int remainingSeconds;
  Map<int, int> userAnswers = {};
  List<bool> visitedQuestions = [];
  bool isSubmitted = false;
  int correctAnswers = 0;
  int totalMarks = 0;
  int earnedMarks = 0;

  @override
  void initState() {
    super.initState();
    currentQuestionIndex = 0;
    remainingSeconds = widget.settings.timeInMinutes * 60;
    visitedQuestions = List.filled(widget.questions.length, false);
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          submitQuiz();
        }
      });
    });
  }

  void selectOption(OptionModel option) {
    setState(() {
      final question = widget.questions[currentQuestionIndex];

      userAnswers[question.id] = option.id;
      visitedQuestions[currentQuestionIndex] = true;

      // if (option.isCorrect) {
      //   earnedMarks += question.marks ?? 1;
      //   correctAnswers++;
      // }
    });
  }

  void skipQuestion() {
    setState(() {
      visitedQuestions[currentQuestionIndex] = true;
    });
    goToNextQuestion();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void submitQuiz() async {
    calculateTotalMarks();

    final percentage = widget.questions.isNotEmpty
        ? ((correctAnswers / widget.questions.length) * 100).round()
        : 0;

    var quizModel = UserQuizSubmissionModel(
      quizType: widget.quizType,
      quizId: widget.quizId,
      markPercentage: percentage,
    );

    // submit
    timer.cancel();
    var result = await widget.progressRepository.submitQuiz(quizModel);

    if (result.success) {
      setState(() {
        isSubmitted = true;
      });
    } else {
      // todo: show notification or redirect somewhere
    }
  }

  void calculateTotalMarks() {
    int newTotalMarks = 0;
    int newEarnedMarks = 0;
    int newCorrectAnswers = 0;

    for (var question in widget.questions) {
      final marks = question.marks ?? 1;

      newTotalMarks += marks;
      final selectedOptionId = userAnswers[question.id];

      final isCorrect =
          question.options?.any(
            (option) => option.id == selectedOptionId && option.isCorrect,
          ) ??
          false;

      if (isCorrect) {
        newCorrectAnswers++;
        newEarnedMarks += marks;
      }
    }

    setState(() {
      totalMarks = newTotalMarks;
      earnedMarks = newEarnedMarks;
      correctAnswers = newCorrectAnswers;
    });
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isSubmitted) {
      print('earned score, ${earnedMarks}');
      print('total marks, ${totalMarks}');

      return CongratulationPage(
        score: earnedMarks,
        totalMarks: totalMarks,
        correctAnswers: correctAnswers,
        totalQuestions: widget.questions.length,
        onGoBack: () {
          Navigator.pop(context);
        },
        onRetry: () {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuizPlayPage(
                questions: widget.questions,
                settings: widget.settings,
                quizType: widget.quizType,
                title: widget.title,
                quizId: widget.quizId,
                progressRepository: sl(),
              ),
            ),
          );
        },
      );
    }

    final question = widget.questions[currentQuestionIndex];
    final colorScheme = Theme.of(context).colorScheme;
    final isTimeRunningOut = remainingSeconds < 300;

    return WillPopScope(
      onWillPop: () async {
        return await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit Quiz?'),
                content: const Text('Your progress will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                    ),
                    child: const Text('Exit'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isTimeRunningOut
                    ? colorScheme.error
                    : colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.schedule,
                    color: isTimeRunningOut
                        ? colorScheme.onError
                        : colorScheme.onPrimaryContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    formatTime(remainingSeconds),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isTimeRunningOut
                          ? colorScheme.onError
                          : colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            ArchiveQuestionIndicatorBar(
              currentQuestion: currentQuestionIndex + 1,
              totalQuestions: widget.questions.length,
              answeredCount: userAnswers.length,
              visitedQuestions: visitedQuestions,
              onQuestionSelected: (index) {
                setState(() => currentQuestionIndex = index);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ArchiveQuestionHeaderWidget(
                      //   questionNumber: currentQuestionIndex + 1,
                      //   totalQuestions: widget.archiveModel.questions.length,
                      //   marks: question.marks ?? 0,
                      //   difficulty: question.difficultyLevel ?? 1,
                      // ),
                      // const SizedBox(height: 24),
                      ArchiveQuestionWidget(
                        title: question.name,
                        passage: question.passage,
                        hint: question.hint,
                      ),
                      const SizedBox(height: 24),
                      if (question.options != null &&
                          question.options!.isNotEmpty)
                        ArchiveOptionsWidget(
                          options: question.options!,
                          selectedOption: userAnswers.containsKey(question.id)
                              ? userAnswers[question.id]
                              : 0,
                          onSelectOption: selectOption,
                        ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer,
                border: Border(
                  top: BorderSide(color: colorScheme.outlineVariant),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: skipQuestion,
                    icon: const Icon(Icons.skip_next),
                    label: const Text(''),
                  ),
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: currentQuestionIndex > 0
                            ? goToPreviousQuestion
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text(''),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed:
                            currentQuestionIndex < widget.questions.length - 1
                            ? goToNextQuestion
                            : submitQuiz,
                        icon: Icon(
                          currentQuestionIndex < widget.questions.length - 1
                              ? Icons.arrow_forward
                              : Icons.done_all,
                        ),
                        label: Text(
                          currentQuestionIndex < widget.questions.length - 1
                              ? ''
                              : 'Submit',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              currentQuestionIndex < widget.questions.length - 1
                              ? null
                              : colorScheme.primary,
                          foregroundColor:
                              currentQuestionIndex < widget.questions.length - 1
                              ? null
                              : colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
