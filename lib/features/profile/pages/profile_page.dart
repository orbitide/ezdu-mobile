// self profile page

import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/data/repositories/user_repository.dart';
import 'package:ezdu/features/profile/models/progress.dart';
import 'package:ezdu/features/settings/pages/settings_page.dart';
import 'package:ezdu/features/profile/widgets/profile_details.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/achievement.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key, required this.userRepository});

  final UserRepository userRepository;

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Future<void> _refreshProfile() async {
    setState(() {
      // widget.userRepository.getUserDetails(auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider).data;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: double.infinity,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              authState!.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            onPressed: () {
              // Show calendar view
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            // Changed to Settings icon
            onPressed: () {
              Navigator.of(
                context,
              ).push(SlideUpRoute(page: const SettingsPage()));
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: widget.userRepository.getUserDetails(authState.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshProfile,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!.data!;
          return RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.of(
                                  //   context,
                                  // ).push(SlideUpRoute(page: AvatarGenerator()));
                                },
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 4,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/images/avatars/1.png',
                                    ),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UserDetailsWidget(
                    user: user,
                    isMyself: authState.id == user.id,
                    lastQuizzes: user.quizzes,
                    onFollowPressed: () {},
                    onFriendPressed: () => {},
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}








class _ProgressOverviewCard extends StatelessWidget {

  const _ProgressOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Progress',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_progress.totalXP}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Total XP',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_progress.currentStreak}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'day streak',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
final _progress = Progress(
  totalXP: 4233,
  currentStreak: 27,
  weeklyData: [
    DailyProgress(day: '21/11/25', xp: 32),
    DailyProgress(day: '2/21/25', xp: 58),
    DailyProgress(day: '3/12/25', xp: 8),
    DailyProgress(day: '4/12/25', xp: 5),
    DailyProgress(day: '5/12/25', xp: 66),
    DailyProgress(day: '6/12/25', xp: 53),
    DailyProgress(day: '7/12/25', xp: 25),
  ],
  achievements: [
    Achievement(
      id: 1,
      title: 'First Step',
      description: 'Complete your first lesson',
      xp: 50,
      unlockedAt: DateTime.utc(2025, 1, 1),
    ),
    Achievement(
      id: 2,
      title: 'Quiz Master',
      description: 'Score 100% in a quiz',
      xp: 100,
      unlockedAt: DateTime.utc(2025, 2, 10),
    ),
    Achievement(
      id: 3,
      title: "title",
      description: "description",
      xp: 66,
      unlockedAt: DateTime.utc(2025, 2, 10),
    ),
    Achievement(
      id: 4,
      title: 'Daily Streak',
      description: 'Maintain a 7-day streak',
      xp: 150,
      unlockedAt: DateTime.utc(2025, 3, 5),
    ),
    Achievement(
      id: 5,
      title: 'XP Collector',
      description: 'Earn over 1000 XP total',
      xp: 200,
      unlockedAt: DateTime.utc(2025, 3, 15),
    ),
  ],
);
