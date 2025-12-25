import 'package:ezdu/data/repositories/classRepository.dart';
import 'package:ezdu/features/splash/widgets/onboarding_steps_class_selection.dart';
import 'package:ezdu/features/splash/widgets/onboarding_steps_final_selection.dart';
import 'package:ezdu/features/splash/widgets/onboarding_steps_group_selection.dart';
import 'package:ezdu/features/splash/widgets/onboarding_steps_segment_selection.dart';
import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingFlowPage extends ConsumerStatefulWidget {
  const OnboardingFlowPage({super.key, required this.classRepository});

  final ClassRepository classRepository;

  @override
  ConsumerState<OnboardingFlowPage> createState() => _OnboardingFlowPageState();
}

class _OnboardingFlowPageState extends ConsumerState<OnboardingFlowPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentStep = 0;
  final List<String> steps = ['Segment', 'Class', 'Group', 'Final'];

  void _onNext() {
    if (_currentStep == 1) {
      final currentSelection = ref.read(onboardingSelectionProvider);

      if (currentSelection.groupList.isEmpty) {
        _pageController.animateToPage(
          3,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() => _currentStep = 3);

        return;
      }
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentStep++);
  }

  void _onBack() {
    if (_currentStep == 3) {
      final currentSelection = ref.read(onboardingSelectionProvider);

      if (currentSelection.groupList.isEmpty) {
        _pageController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() => _currentStep = 1);
        return;
      }
    }

    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => _currentStep--);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = (_currentStep + 1) / steps.length;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (_currentStep > 0) {
            _onBack();
          } else {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Onboarding'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[400]!),
              ),
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          // Disable swipe, use buttons
          onPageChanged: (page) {
            setState(() => _currentStep = page);
          },
          children: [
            StepSegmentSelection(onNext: _onNext, onBack: _onBack),
            StepClassSelection(onNext: _onNext, onBack: _onBack),
            StepGroupSelection(onNext: _onNext, onBack: _onBack),
            StepFinal(onNext: _onNext, onBack: _onBack),
          ],
        ),
      ),
    );
  }
}
