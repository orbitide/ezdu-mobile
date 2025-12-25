import 'package:ezdu/data/models/lesson_model.dart';
import 'package:flutter/material.dart';
import 'topic_card.dart';

class LessonColumn extends StatelessWidget {
  final LessonWithTopicModel lesson;
  final bool isSelected;
  final Set<int> selectedTopicIds;
  final Function(int, List<int>) onLessonSelected;
  final Function(int) onTopicSelected;

  const LessonColumn({
    super.key,
    required this.lesson,
    required this.isSelected,
    required this.selectedTopicIds,
    required this.onLessonSelected,
    required this.onTopicSelected,
  });

  @override
  Widget build(BuildContext context) {
    final topics = lesson.topics ?? [];
    final allTopicsSelected =
        topics.isNotEmpty && topics.every((t) => selectedTopicIds.contains(t.id));

    return Column(
      children: [
        // Lesson Card
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? Theme.of(context).colorScheme.secondary.withAlpha(2)
                : Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onLessonSelected(
                    lesson.id,
                    topics.map((t) => t.id).toList(),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 20,
                        color: isSelected
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          lesson.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onLessonSelected(
                  lesson.id,
                  topics.map((t) => t.id).toList(),
                ),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.outline,
                      width: allTopicsSelected ? 0 : 1.5,
                    ),
                    color: allTopicsSelected
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.transparent,
                  ),
                  child: allTopicsSelected
                      ? Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSecondary,
                  )
                      : null,
                ),
              ),
            ],
          ),
        ),

        // Topics
        if (topics.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 2,
                ),
              ),
            ),
            child: Column(
              children: [
                for (int i = 0; i < topics.length; i++)
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: i < topics.length - 1 ? 8 : 0,
                      top: i == 0 ? 0 : 0,
                    ),
                    child: GestureDetector(
                      onTap: () => onTopicSelected(topics[i].id),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedTopicIds.contains(topics[i].id)
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.outlineVariant,
                            width: selectedTopicIds.contains(topics[i].id) ? 1.5 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: selectedTopicIds.contains(topics[i].id)
                              ? Theme.of(context).colorScheme.secondary.withAlpha(15)
                              : Theme.of(context).colorScheme.surface,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.tag_rounded,
                                    size: 16,
                                    color: selectedTopicIds.contains(topics[i].id)
                                        ? Theme.of(context).colorScheme.secondary
                                        : Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      topics[i].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: selectedTopicIds
                                            .contains(topics[i].id)
                                            ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                            : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedTopicIds.contains(topics[i].id)
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.outline,
                                  width: selectedTopicIds.contains(topics[i].id)
                                      ? 0
                                      : 1.5,
                                ),
                                color: selectedTopicIds.contains(topics[i].id)
                                    ? Theme.of(context).colorScheme.secondary
                                    : Colors.transparent,
                              ),
                              child: selectedTopicIds.contains(topics[i].id)
                                  ? Icon(
                                Icons.check_rounded,
                                size: 12,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary,
                              )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}