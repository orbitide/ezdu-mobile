import 'package:flutter/material.dart';

class ArchiveQuestionHeaderWidget extends StatelessWidget {
  final int questionNumber;
  final int totalQuestions;
  final int marks;
  final int difficulty;

  const ArchiveQuestionHeaderWidget({
    Key? key,
    required this.questionNumber,
    required this.totalQuestions,
    required this.marks,
    required this.difficulty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$marks Mark${marks > 1 ? 's' : ''}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.onSecondaryContainer,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: difficulty == 1
                ? Colors.green.withOpacity(0.2)
                : difficulty == 2
                ? Colors.orange.withOpacity(0.2)
                : Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            difficulty == 1
                ? 'Easy'
                : difficulty == 2
                ? 'Medium'
                : 'Hard',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: difficulty == 1
                  ? Colors.green
                  : difficulty == 2
                  ? Colors.orange
                  : Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
