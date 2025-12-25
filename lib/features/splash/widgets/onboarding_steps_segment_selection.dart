import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Map<String, int> _onboardingSegment = {
  'Student': 1,
  'Job': 2,
  'International Exam': 3,
};

class _Segment {
  final String name;
  final int id;

  _Segment({required this.name, required this.id});
}

class StepSegmentSelection extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepSegmentSelection({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<_Segment> segments = _onboardingSegment.entries
        .map((entry) => _Segment(name: entry.key, id: entry.value))
        .toList();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'What best describes you?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: segments.map((segment) {
              return ListTile(
                leading: segment.name.toLowerCase() == 'student'
                    ? const Icon(Icons.school)
                    : segment.name.toLowerCase() == 'job'
                    ? const Icon(Icons.work)
                    : const Icon(Icons.language),
                title: Text(segment.name),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ref
                      .read(onboardingSelectionProvider.notifier)
                      .updateSegment(segment.id);
                  onNext();
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
