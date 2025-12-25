import 'package:ezdu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/onboarding_provider.dart';

class StepFinal extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const StepFinal({super.key, required this.onNext, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSelection = ref.watch(onboardingSelectionProvider);
    final authState = ref.read(authProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: _buildAnimatedSuccessIcon(isDark),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'You\'re All Set!',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Your personalized learning path is ready',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  _buildSummaryContainer(context, currentSelection, isDark),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await ref
                        .read(onboardingSelectionProvider.notifier)
                        .finalizeOnboarding();

                    if(!context.mounted)return;
                    if (authState.isLoggedIn) {
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil('/home', (route) => false);
                    } else {
                      Navigator.of(context).pushNamed('/register');
                    }
                  },
                  child: const Text(
                    'Complete Onboarding',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Back Button
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: onBack,
                  child: const Text('Go Back', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryContainer(
    BuildContext context,
    dynamic currentSelection,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.blue[800]! : Colors.blue[200]!,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            'Focus Area',
            currentSelection.segment.toString(),
            Icons.category,
            context,
            isDark,
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Level',
            currentSelection.className ?? 'Not selected',
            Icons.layers,
            context,
            isDark,
          ),
          if (currentSelection.groupId != null) ...[
            const SizedBox(height: 12),
            _buildSummaryRow(
              'Specialization',
              currentSelection.groupName!,
              Icons.star,
              context,
              isDark,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    IconData icon,
    BuildContext context,
    bool isDark,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: isDark ? Colors.blue[400] : Colors.blue[600],
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedSuccessIcon(bool isDark) {
    return _WaveSuccessIcon(isDark: isDark);
  }
}

class _WaveSuccessIcon extends StatefulWidget {
  final bool isDark;

  const _WaveSuccessIcon({required this.isDark});

  @override
  State<_WaveSuccessIcon> createState() => _WaveSuccessIconState();
}

class _WaveSuccessIconState extends State<_WaveSuccessIcon>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.8,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Wave rings
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: 100 + (_scaleAnimation.value * 30),
              height: 100 + (_scaleAnimation.value * 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.green.withValues(
                    alpha: _opacityAnimation.value,
                  ),
                  width: 3,
                ),
              ),
            );
          },
        ),
        // Center icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isDark ? Colors.green[900] : Colors.green[100],
            boxShadow: [
              BoxShadow(
                color: Colors.green.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.check_circle,
            size: 60,
            color: widget.isDark ? Colors.green[400] : Colors.green[700],
          ),
        ),
      ],
    );
  }
}
