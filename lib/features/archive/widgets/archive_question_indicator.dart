import 'package:flutter/material.dart';

class ArchiveQuestionIndicatorBar extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final int answeredCount;
  final List<bool> visitedQuestions;
  final Function(int) onQuestionSelected;

  const ArchiveQuestionIndicatorBar({
    Key? key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.answeredCount,
    required this.visitedQuestions,
    required this.onQuestionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: colorScheme.surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Q$currentQuestion / $totalQuestions',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Answered: $answeredCount',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: totalQuestions,
              itemBuilder: (context, index) {
                final isAnswered = visitedQuestions[index];
                final isCurrent = index == currentQuestion - 1;

                return GestureDetector(
                  onTap: () => onQuestionSelected(index),
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isCurrent
                          ? colorScheme.primary
                          : isAnswered
                          ? colorScheme.tertiary
                          : colorScheme.surfaceContainerHighest,
                      border: Border.all(
                        color: isCurrent
                            ? colorScheme.primary
                            : colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isCurrent
                              ? colorScheme.onPrimary
                              : isAnswered
                              ? colorScheme.onTertiary
                              : colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
