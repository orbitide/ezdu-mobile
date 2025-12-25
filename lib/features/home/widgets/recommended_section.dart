import 'package:flutter/material.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended for You',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildLessonCard(
                context,
                title: 'English Grammar',
                subtitle: 'Tenses • Level 2',
                icon: Icons.translate,
                color: colorScheme.secondaryContainer,
              ),
              _buildLessonCard(
                context,
                title: 'General Knowledge',
                subtitle: 'Bangladesh • 15 Questions',
                icon: Icons.public,
                color: colorScheme.tertiaryContainer,
              ),
              _buildLessonCard(
                context,
                title: 'Science',
                subtitle: 'Physics • Force & Motion',
                icon: Icons.science,
                color: colorScheme.primaryContainer,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLessonCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/lesson-detail'),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: colorScheme.onSurfaceVariant),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
