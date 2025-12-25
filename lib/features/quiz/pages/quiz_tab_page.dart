import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/features/quiz_challenge/pages/quiz_challenge_tab.dart';
import 'package:ezdu/features/quiz/pages/quiz_page.dart';
import 'package:ezdu/features/quiz_mock/pages/quiz_mock_page.dart';
import 'package:flutter/material.dart';

class QuizTabPage extends StatefulWidget {
  const QuizTabPage({super.key});

  @override
  State<StatefulWidget> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // bottom: const Text('Quiz Center'),
        // elevation: 0,
        title: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Challenge'),
            Tab(text: 'Mock'),
            Tab(text: 'Quiz'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          QuizChallengeTab(),
          QuizMockTab(subjectRepository: sl()),
          QuizPage(quizRepository: sl(),),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
