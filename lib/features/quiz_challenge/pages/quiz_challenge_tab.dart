import 'package:flutter/material.dart';

class QuizChallengeTab extends StatelessWidget {
  const QuizChallengeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBackground = isDark
        ?  Colors.cyanAccent.withOpacity(0.2)
        : Colors.cyanAccent.withOpacity(0.15);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Challenge',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          // Main Challenge Card
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                  cardBackground.withOpacity(0.2),
                  cardBackground.withOpacity(0.4),
                      ]
                    : [
                        colorScheme.primary.withOpacity(0.9),
                        colorScheme.primary,
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: colorScheme.primary.withOpacity(isDark ? 0.3 : 0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(isDark ? 0.2 : 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: colorScheme.primary.withOpacity(isDark ? 0.05 : 0.1),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Large Icon
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(
                        alpha: isDark ? 0.15 : 0.3,
                      ),
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: const Icon(Icons.bolt, size: 80, color: Colors.white),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Ready to Test Your Knowledge?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Challenge yourself with quick questions based on your previous mock test',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(isDark ? 0.8 : 0.9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Start Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to quiz or start challenge
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primaryContainer,
                elevation: 4,
                shadowColor: colorScheme.primary.withOpacity(
                  isDark ? 0.3 : 0.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: colorScheme.primary.withOpacity(isDark ? 0.3 : 0.5),
                    width: 1,
                  ),
                ),
              ),
              child: const Text(
                'Start Challenge',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
