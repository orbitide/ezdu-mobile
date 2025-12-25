import 'package:ezdu/features/leaderboard/models/leaderboard.dart';
import 'package:flutter/material.dart';
import 'leaderboard_tile.dart';

class LeaderboardList extends StatelessWidget {
  final List<LeaderboardModel> entries;

  const LeaderboardList({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text('No leaderboard data yet'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        // padding: const EdgeInsets.all(16),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final isTopThree = index < 3;

          return LeaderboardTile(
            entry: entry,
            rank: index + 1,
            isTopThree: isTopThree,
          );
        },
      ),
    );
  }
}
