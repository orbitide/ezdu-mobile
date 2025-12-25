import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/data/repositories/archive_repository.dart';
import 'package:ezdu/features/archive/models/archive_model.dart';
import 'package:ezdu/features/archive/pages/archive_quiz_start_page.dart';
import 'package:flutter/material.dart';

class ArchiveReviewPage extends StatefulWidget {
  const ArchiveReviewPage({
    super.key,
    required this.archivedExam,
    required this.archiveRepository,
  });

  final ArchiveModel archivedExam;
  final ArchiveRepository archiveRepository;

  @override
  State<ArchiveReviewPage> createState() => _ArchiveReviewPageState();
}

class _ArchiveReviewPageState extends State<ArchiveReviewPage> {
  late ArchiveModel archivedExam = widget.archivedExam;
  late Future<ApiResponse<ArchiveModel>> _examDetailsFuture;
  bool _showAnswers = false;
  final Map<int, bool> _expandedQuestions = {};

  @override
  void initState() {
    super.initState();
    _examDetailsFuture = _loadArchiveDetails();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(archivedExam.name), elevation: 0),
      body: FutureBuilder(
        future: _examDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    "Error: ${snapshot.error}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => setState(() => _loadArchiveDetails()),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData && snapshot.data!.success) {
            final examDetails = snapshot.data!.data!;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Questions: ${examDetails.questions.length}",
                              style: const TextStyle(),
                            ),
                            Text(
                              "Total Marks: ${35}",
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Control Panel
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _showAnswers,
                                onChanged: (value) {
                                  setState(() {
                                    _showAnswers = value ?? false;
                                  });
                                },
                              ),
                              const Text("Show Answers"),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (snapshot.hasData &&
                                  snapshot.data!.data == null) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('No Data Found'),
                                      content: const Text(
                                        'There’s no information available right now.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  SlideUpRoute(
                                    page: ArchiveQuizStartPage(
                                      archivedExam: examDetails,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.play_arrow),
                            label: const Text("Start Quiz"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Questions List
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: examDetails.questions.length,
                    itemBuilder: (context, index) {
                      final question = examDetails.questions[index];
                      final isExpanded =
                          _expandedQuestions[question.id] ?? false;

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 1,
                        child: Column(
                          children: [
                            // Question Header
                            InkWell(
                              onTap: () => {
                                // _toggleQuestionExpand(question.id)
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Question Number
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Question Title and Meta
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      question.name,
                                                      style: theme
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                            // Use theme for larger text
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            // Stronger weight for the main title
                                                            color: colorScheme
                                                                .onSurface, // Theme-aware color
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // Difficulty Level Badge (using custom function and onPrimary)
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      // NOTE: Using your custom color function, ensuring it's vibrant
                                                      color:
                                                          _getDifficultyColor(
                                                            2,
                                                          ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ), // Slightly larger border radius
                                                    ),
                                                    child: Text(
                                                      _getDifficultyText(
                                                        question
                                                            .difficultyLevel!,
                                                      ),
                                                      style: theme
                                                          .textTheme
                                                          .labelSmall
                                                          ?.copyWith(
                                                            // Assuming _getDifficultyColor is vibrant/dark, use light text
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),

                                                  const SizedBox(width: 12),

                                                  // Marks Display
                                                  Text(
                                                    "${question.marks} Mark${question.marks != 1 ? 's' : ''}",
                                                    style: theme
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          // Use a subtle, theme-aware color for secondary info
                                                          color: colorScheme
                                                              .onSurfaceVariant,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            question.passage ?? "",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Expanded Content
                            Container(
                              color: Colors.grey[50],
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(height: 0),
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Options
                                        const Text(
                                          "Options:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              question.options?.length ?? 0,
                                          itemBuilder: (context, optionIndex) {
                                            final option =
                                                question.options![optionIndex];
                                            final isCorrect = option.isCorrect;
                                            final shouldHighlight =
                                                _showAnswers && isCorrect;

                                            return Container(
                                              margin: const EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: shouldHighlight
                                                    ? Colors.green[50]
                                                    : Colors.white,
                                                border: Border.all(
                                                  color: shouldHighlight
                                                      ? Colors.green
                                                      : Colors.grey[300]!,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: shouldHighlight
                                                            ? Colors.green
                                                            : Colors.grey,
                                                      ),
                                                      color: shouldHighlight
                                                          ? Colors.green
                                                          : Colors.transparent,
                                                    ),
                                                    child: shouldHighlight
                                                        ? const Icon(
                                                            Icons.check,
                                                            size: 16,
                                                            color: Colors.white,
                                                          )
                                                        : null,
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Text(
                                                      option.name,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            shouldHighlight
                                                            ? FontWeight.w600
                                                            : FontWeight.normal,
                                                        color: shouldHighlight
                                                            ? Colors.green[700]
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 16),

                                        // Hint
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[50],
                                            border: Border(
                                              left: BorderSide(
                                                color: Colors.blue[500]!,
                                                width: 4,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Hint",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                question.hint ??
                                                    "No hint available",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 12),

                                        // Explanation (only if show answers is enabled)
                                        if (_showAnswers)
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.indigo[50],
                                              border: Border(
                                                left: BorderSide(
                                                  color: Colors.indigo[500]!,
                                                  width: 4,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Explanation",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.indigo,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  question.explanation ??
                                                      "No explanation available",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text("No exam details found"));
        },
      ),
    );
  }

  Future<ApiResponse<ArchiveModel>> _loadArchiveDetails() async {
    return await widget.archiveRepository.getArchivedExam(
      widget.archivedExam.id,
    );
  }

  Color _getDifficultyColor(int level) {
    switch (level) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getDifficultyText(int level) {
    switch (level) {
      case 1:
        return "Easy";
      case 2:
        return "Medium";
      case 3:
        return "Hard";
      default:
        return "Tricky";
    }
  }
}
