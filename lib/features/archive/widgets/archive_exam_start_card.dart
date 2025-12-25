import 'package:ezdu/features/archive/models/archive_model.dart';
import 'package:flutter/material.dart';

class ArchiveExamStatsCard extends StatelessWidget {
  final ArchiveModel archiveModel;

  const ArchiveExamStatsCard({Key? key, required this.archiveModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final totalMarks = archiveModel.questions.fold<int>(
      0,
          (sum, q) => sum + (q.marks ?? 0),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatItem(
            icon: Icons.quiz,
            label: 'Questions',
            value: archiveModel.questions.length.toString(),
          ),
          Container(width: 1, height: 50, color: colorScheme.outlineVariant),
          _StatItem(
            icon: Icons.grade,
            label: 'Total Marks',
            value: totalMarks.toString(),
          ),
          Container(width: 1, height: 50, color: colorScheme.outlineVariant),
          _StatItem(
            icon: Icons.info_outline,
            label: 'Institute',
            value: archiveModel.instituteId.toString(),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Icon(icon, color: colorScheme.primary, size: 28),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
