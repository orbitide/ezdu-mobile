import 'package:ezdu/data/models/class_model.dart';
import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepClassSelection extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepClassSelection({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelection = ref.watch(onboardingSelectionProvider);
    final int? selectedSegment = currentSelection.segment;

    if (currentSelection.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (selectedSegment == null) {
      return Center(child: Text("Please go back and select a segment."));
    }

    final List<ClassModel> classGroups = currentSelection.classList;

    if (classGroups.isEmpty) {
      return const Center(
        child: Text("Error: No class options available for this segment."),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            selectedSegment == 1
                ? "I'm Studying in..."
                : selectedSegment == 2
                ? "I'm Preparing for..."
                : 'I’m targeting…',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: classGroups.map((classModel) {
              return ListTile(
                title: Text(classModel.name),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: ()async {
                 await ref
                      .read(onboardingSelectionProvider.notifier)
                      .updateClass(classModel.id);
                  onNext();
                },
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: TextButton(onPressed: onBack, child: const Text('Go Back')),
        ),
      ],
    );
  }
}
