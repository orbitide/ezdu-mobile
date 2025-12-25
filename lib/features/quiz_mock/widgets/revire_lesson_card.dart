import 'package:ezdu/data/models/lesson_model.dart';
import 'package:flutter/material.dart';

class ReviewLessonCard extends StatelessWidget {
  final LessonWithTopicModel lesson;
  final Set<int> selectedTopicIds;

  const ReviewLessonCard({
    super.key,
    required this.lesson,
    required this.selectedTopicIds,
  });

  @override
  Widget build(BuildContext context) {
    final topics = lesson.topics ?? [];
    final selectedTopics =
    topics.where((t) => selectedTopicIds.contains(t.id)).toList();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withAlpha(100),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary.withAlpha(25),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lesson Header
          Row(
            children: [
              Expanded(
                child: Text(
                  lesson.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  selectedTopics.length.toString(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Selected Topics
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < selectedTopics.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedTopics[i].name,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}