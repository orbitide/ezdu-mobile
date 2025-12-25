import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/repositories/leaderboard_repository.dart';
import 'package:ezdu/features/leaderboard/entities/leaderboard.dart';
import 'package:ezdu/features/leaderboard/models/leaderboard.dart';
import 'package:ezdu/features/leaderboard/widgets/leaderboard_list.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key, required this.leaderboardRepository});

  final LeaderboardRepository leaderboardRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: FutureBuilder(
        future: leaderboardRepository.getWeeklyLeaderboard(),
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
            return LeaderboardList(entries: snapshot.data!.data!.items);
          }

          return Center(
            child: Text('No data found.'),
          );
        },
      ),
    );
  }
}
