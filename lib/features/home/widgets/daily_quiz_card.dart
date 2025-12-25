import 'package:ezdu/core/widgets/animation/jumping_icon.dart';
import 'package:ezdu/core/widgets/animation/shaking_icon.dart';
import 'package:flutter/material.dart';

class DailyQuizCard extends StatelessWidget {
  const DailyQuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.secondary.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Quest Challenge',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                ShakingIcon(
                  icon: Icons.card_giftcard,
                  size: theme.textTheme.titleLarge?.fontSize,
                  color: colorScheme.tertiary,
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: 0.33,
                minHeight: 6,
                color: colorScheme.secondary,
                backgroundColor: colorScheme.secondary.withValues(alpha: 0.15),
              ),
            ),
            const SizedBox(height: 8),

            // Bottom Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1/3 quizzes',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text('Start')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
