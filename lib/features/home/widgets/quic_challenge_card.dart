import 'package:flutter/material.dart';

class QuickChallengeCard extends StatelessWidget {
  const QuickChallengeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: colorScheme.tertiaryContainer.withValues(alpha: .8),
      child: ListTile(
        leading: const Icon(Icons.flash_on, size: 32),
        title: const Text('Quick Challenge'),
        subtitle: const Text('Answer 1 question now and earn 10 XP'),
        trailing: ElevatedButton(
          onPressed: () {},
          child: const Text('Answer Now'),
        ),
      ),
    );
  }
}