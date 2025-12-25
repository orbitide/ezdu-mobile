import 'package:ezdu/data/models/class_model.dart';
import 'package:ezdu/data/models/group_model.dart';
import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepGroupSelection extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepGroupSelection({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelection = ref.watch(onboardingSelectionProvider);

    if (currentSelection.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final String className = currentSelection.className ?? "Unk";
    if (currentSelection.groupList.isEmpty) {
      return const Center(child: Text("Error: No group options available."));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Choose your Sub-field or Group for $className',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: currentSelection.groupList.map((group) {
              return ListTile(
                title: Text(group.name),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ref
                      .read(onboardingSelectionProvider.notifier)
                      .updateGroup(group.id);
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
