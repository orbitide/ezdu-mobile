import 'package:ezdu/data/models/question_model.dart';
import 'package:ezdu/features/archive/models/archive_quiz_settings_model.dart';
import 'package:flutter/material.dart';

class ArchiveQuizSettingsDialog extends StatefulWidget {
  final List<QuestionModel> questions;
  final Function(ArchiveQuizSettingsModel) onConfirm;

  const ArchiveQuizSettingsDialog({
    Key? key,
    required this.questions,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<ArchiveQuizSettingsDialog> createState() => _ArchiveQuizSettingsDialogState();
}

class _ArchiveQuizSettingsDialogState extends State<ArchiveQuizSettingsDialog> {
  late int minutes;
  late bool negativeMarking;
  late double negativeMarkValue;

  @override
  void initState() {
    super.initState();
    minutes = 20;
    negativeMarking = false;
    negativeMarkValue = 0.25;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final totalMarks = widget.questions.fold<int>(
      0,
          (sum, q) => sum + (q.marks ?? 0),
    );

    return AlertDialog(
      title: const Text('Quiz Settings'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Duration',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<int>(
                value: minutes,
                isExpanded: true,
                underline: const SizedBox(),
                items: [15, 20, 30, 40, 60].map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text('$value minutes'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => minutes = value);
                  }
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Negative Marking',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Switch(
                  value: negativeMarking,
                  onChanged: (value) {
                    setState(() => negativeMarking = value);
                  },
                ),
              ],
            ),
            if (negativeMarking) ...[
              const SizedBox(height: 12),
              Text(
                'Mark per Wrong Answer: -${negativeMarkValue.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Slider(
                value: negativeMarkValue,
                min: 0.1,
                max: 1.0,
                divisions: 9,
                label: negativeMarkValue.toStringAsFixed(2),
                onChanged: (value) {
                  setState(() => negativeMarkValue = value);
                },
              ),
            ],
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz Summary',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Questions: ${widget.questions.length}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    'Total Marks: $totalMarks',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final settings = ArchiveQuizSettingsModel(
              timeInMinutes: minutes,
              enableNegativeMarking: negativeMarking,
              negativeMarkValue: negativeMarkValue,
            );
            widget.onConfirm(settings);
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
