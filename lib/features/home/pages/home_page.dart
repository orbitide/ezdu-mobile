import 'package:ezdu/data/repositories/quiz_repository.dart';
import 'package:ezdu/features/home/widgets/daily_quiz_card.dart';
import 'package:ezdu/features/home/widgets/home_grid_section.dart';
import 'package:ezdu/features/home/widgets/home_title.dart';
import 'package:ezdu/features/home/widgets/incomplete_profile_warning.dart';
import 'package:ezdu/features/home/widgets/mini_leaderboard.dart';
import 'package:ezdu/features/home/widgets/quic_challenge_card.dart';
import 'package:ezdu/features/home/widgets/recommended_section.dart';
import 'package:ezdu/features/home/widgets/upcoming_quiz_card.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:ezdu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.quizRepository});

  final QuizRepository quizRepository;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authProvider).isLoggedIn;
    final userState = ref.watch(userProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isProfileIncomplete = isLoggedIn && userState.classId == 0;

    return PopScope(
      canPop: !isLoggedIn,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: isProfileIncomplete
              ? IncompleteProfileWarning()
              : HomeTitle(isLoggedIn: isLoggedIn),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await quizRepository.getUpcomingQuiz();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // if (isLoggedIn) ...[DailyQuizCard(), SizedBox(height: 16)],

                if (isLoggedIn)
                  FutureBuilder(
                    future: quizRepository.getUpcomingQuiz(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0),
                                child: Text('Loading...'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (snapshot.hasData && snapshot.data!.data != null) {
                        return UpcomingQuizCard(
                          isLoggedIn: isLoggedIn,
                          quiz: snapshot.data!.data!,
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),

                if (!isLoggedIn) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          color: colorScheme.onErrorContainer,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'You must be logged in to access all features',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                HomeGridSection(isLoggedIn: isLoggedIn),
                SizedBox(height: 16),
                RecommendedSection(),
                SizedBox(height: 16),
                MiniLeaderboardRow(),
                SizedBox(height: 16),
                QuickChallengeCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
