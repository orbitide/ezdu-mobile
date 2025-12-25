import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/features/splash/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

class IncompleteProfileWarning extends StatelessWidget {
  const IncompleteProfileWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 18,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "Profile not completed. Tap to continue.",
              style: TextStyle(
                fontSize: 13,
                color: Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OnboardingFlowPage(classRepository: sl()),
                ),
              );
            },
            child: const Text(
              "Complete",
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}
