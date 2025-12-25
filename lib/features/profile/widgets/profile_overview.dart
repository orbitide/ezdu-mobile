import 'package:flutter/material.dart';

class ProfileOverView extends StatelessWidget {
  const ProfileOverView({
    super.key,
    required this.currentStreak,
    required this.percentage,
    required this.totalXp,
    required this.quizCount,
  });

  final int currentStreak;
  final int percentage;
  final int totalXp;
  final int quizCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: _buildOverviewItem(
                      icon: Icons.local_fire_department,
                      label: 'Streak',
                      value: '$currentStreak days',
                      iconColor: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 1,
                    child: _buildOverviewItem(
                      icon: Icons.trending_up,
                      label: 'Avg Score',
                      value: '$percentage%',
                      iconColor: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: _buildOverviewItem(
                      icon: Icons.quiz,
                      label: 'Quizzes',
                      value: '$quizCount quizzes',
                      iconColor: Colors.purpleAccent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    flex: 1,

                    child: _buildOverviewItem(
                      icon: Icons.flash_on,
                      label: 'Total XP',
                      value: '$totalXp XP',
                      iconColor: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
