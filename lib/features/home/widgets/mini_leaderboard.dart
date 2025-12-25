import 'package:flutter/material.dart';

class MiniLeaderboardRow extends StatelessWidget {
  const MiniLeaderboardRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          LeaderboardCard(user: 'Alice', rank: 1, xp: 2450, avatar: '👩'),
          LeaderboardCard(user: 'Bob', rank: 2, xp: 2180, avatar: '👨'),
          LeaderboardCard(user: 'Charlie', rank: 3, xp: 1950, avatar: '🧑'),
          LeaderboardCard(user: 'You', rank: 5, xp: 1820, avatar: '😊', isCurrentUser: true),
        ],
      ),
    );
  }
}

class LeaderboardCard extends StatelessWidget {
  final String user;
  final int rank;
  final int xp;
  final String avatar;
  final bool isCurrentUser;

  const LeaderboardCard({
    super.key,
    required this.user,
    required this.rank,
    required this.xp,
    required this.avatar,
    this.isCurrentUser = false,
  });

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return const Color(0xFFFFD700);
      case 2:
        return const Color(0xFFC0C0C0);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return const Color(0xFF9C27B0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final rankColor = _getRankColor(rank);

    return Container(
      width: 105,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? colorScheme.primary.withOpacity(0.1)
            : rankColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser ? colorScheme.primary : rankColor.withOpacity(0.3),
          width: isCurrentUser ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            avatar,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            '#$rank',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: rankColor,
            ),
          ),
          Text(
            user,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            '$xp XP',
            style: TextStyle(
              fontSize: 9,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}