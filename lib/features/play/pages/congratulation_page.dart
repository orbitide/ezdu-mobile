import 'package:ezdu/core/widgets/confetti.dart';
import 'package:flutter/material.dart';

class CongratulationPage extends StatefulWidget {
  final int score;
  final int totalMarks;
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onGoBack;
  final VoidCallback onRetry;

  const CongratulationPage({
    Key? key,
    required this.score,
    required this.totalMarks,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onGoBack,
    required this.onRetry,
  }) : super(key: key);

  @override
  State<CongratulationPage> createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _scaleController;
  

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final percentage = (widget.score / widget.totalMarks * 100).toStringAsFixed(
      1,
    );
    final isPassed = widget.score >= widget.totalMarks * 0.4;
    
    print(widget.score);
    print(widget.totalMarks);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: Tween<double>(begin: 0, end: 1).animate(
                            CurvedAnimation(
                              parent: _scaleController,
                              curve: Curves.elasticOut,
                            ),
                          ),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isPassed
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.orange.withOpacity(0.2),
                              border: Border.all(
                                color: isPassed ? Colors.green : Colors.orange,
                                width: 3,
                              ),
                            ),
                            child: Icon(
                              isPassed
                                  ? Icons.check_circle_outline
                                  : Icons.assignment_turned_in_outlined,
                              size: 60,
                              color: isPassed ? Colors.green : Colors.orange,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          isPassed ? 'Excellent!' : 'Good Effort!',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isPassed ? Colors.green : Colors.orange,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Quiz Completed',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 40),
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainer,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: colorScheme.outlineVariant),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Your Score',
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    '${widget.score}/${widget.totalMarks}',
                                    style: Theme.of(context).textTheme.titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.primary,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: widget.score / widget.totalMarks,
                                  minHeight: 12,
                                  backgroundColor: colorScheme.surfaceVariant,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isPassed ? Colors.green : Colors.orange,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '$percentage%',
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: isPassed
                                          ? Colors.green
                                          : Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    ResultRow(
                                      label: 'Correct Answers',
                                      value:
                                          '${widget.correctAnswers}/${widget.totalQuestions}',
                                    ),
                                    const SizedBox(height: 12),
                                    ResultRow(
                                      label: 'Incorrect',
                                      value:
                                          '${widget.totalQuestions - widget.correctAnswers}',
                                    ),
                                    const SizedBox(height: 12),
                                    ResultRow(
                                      label: 'Accuracy',
                                      value:
                                          '${((widget.correctAnswers / widget.totalQuestions) * 100).toStringAsFixed(1)}%',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: widget.onGoBack,
                                icon: const Icon(Icons.home),
                                label: const Text('Go Back'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: widget.onRetry,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Retry Quiz'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_confettiController.isAnimating)
            ConfettiWidget(controller: _confettiController),
        ],
      ),
    );
  }
}

class ResultRow extends StatelessWidget {
  final String label;
  final String value;

  const ResultRow({Key? key, required this.label, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
