import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/archive_repository.dart';
import 'package:ezdu/features/archive/models/archive_model.dart';
import 'package:ezdu/features/archive/pages/archive_review_page.dart';
import 'package:flutter/material.dart';

class ExamListScreen extends StatefulWidget {
  const ExamListScreen({
    super.key,
    required this.subject,
    required this.archiveRepository,
  });

  final SubjectModel subject;
  final ArchiveRepository archiveRepository;

  @override
  State<ExamListScreen> createState() => _ExamListScreenState();
}

class _ExamListScreenState extends State<ExamListScreen> {
  late Future<ApiResponse<PagedList<ArchiveModel>>> archivedExamsFuture;
  late List<ArchiveModel> filteredExams;
  late int count = 0;

  String searchQuery = '';
  String selectedFilter = 'all';
  final List<String> filterOptions = ['all', 'mcq', 'cq'];


  @override
  void initState() {
    super.initState();
    final subjectId = widget.subject.id;
    archivedExamsFuture = widget.archiveRepository.getArchivedExamList(
      subjectId,
    );
    // filteredExams = List.from(allArchivedExamsFuture);
    // filteredExams = archivedExamsFuture
    // filteredExams = List.from([]);
    archivedExamsFuture.then((response) {
      if (mounted && response.data != null) {
        setState(() {
          count = response.data!.items.length;
        });
      }
    });
  }

  void _applyFiltersAndSearch() {
    // filteredExams = allExams.where((exam) {
    //   final matchesSearch = exam.title.toLowerCase().contains(
    //     searchQuery.toLowerCase(),
    //   );
    //   final matchesFilter =
    //       selectedFilter == 'all' || exam.type == selectedFilter;
    //   return matchesSearch && matchesFilter;
    // }).toList();
    //

    setState(() {});
  }

  Color _getScoreColor(int percentage) {
    if (percentage >= 80) return const Color(0xFF10B981);
    if (percentage >= 60) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Text(
                            //   widget.subject.emoji,
                            //   style: const TextStyle(fontSize: 28),
                            // ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.subject.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : const Color(0xFF1E293B),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$count exams available',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9EA7B5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    searchQuery = value;
                    _applyFiltersAndSearch();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search exam or topic...',
                    hintStyle: const TextStyle(
                      color: Color(0xFFAEB0BC),
                      fontSize: 14,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF94A3B8),
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Filter and Sort Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: filterOptions.map((filter) {
                  final bool isSelected = selectedFilter == filter;
                  final bool isDark = Theme.of(context).brightness == Brightness.dark;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                        _applyFiltersAndSearch();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          // Active color vs Inactive color
                          color: isSelected
                              ? (isDark ? Colors.blue.shade700 : Colors.blue.shade600)
                              : (isDark ? Colors.grey.shade800 : Colors.grey.shade100),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? (isDark ? Colors.blue.shade400 : Colors.blue.shade700)
                                : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filter.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              // Text color adaptivity
                              color: isSelected
                                  ? Colors.white
                                  : (isDark ? Colors.grey.shade400 : Colors.grey.shade700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Exam List
            Expanded(
              child: FutureBuilder(
                future: archivedExamsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: Text('Loading subjects...'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Error loading data: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasData && snapshot.data!.data!.totalCount > 0) {
                    final items = snapshot.data!.data!.items;

                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.95,
                          ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isDark =
                            Theme.of(context).brightness == Brightness.dark;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              SlideRightToLeftRoute(
                                page: ArchiveReviewPage(
                                  archivedExam: item,
                                  archiveRepository: sl(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark
                                    ? Colors.grey.withValues(alpha: 0.2)
                                    : Colors.grey.withValues(alpha: 0.15),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark
                                      ? Colors.black.withValues(alpha: 0.3)
                                      : Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: isDark
                                    ? [
                                        Colors.grey.shade900,
                                        Colors.grey.shade900,
                                        Colors.grey.shade900,
                                        Colors.grey.shade800,
                                      ]
                                    : [
                                        Colors.white,
                                        Colors.white,
                                        Colors.white,
                                        Colors.grey.shade50,
                                      ],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                children: [
                                  // Background accent
                                  Positioned(
                                    top: -20,
                                    right: -20,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(
                                          isDark ? 0.1 : 0.05,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  // Content
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Header with icon and type badge
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Type icon
                                                Container(
                                                  padding: const EdgeInsets.all(
                                                    10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue
                                                        .withOpacity(
                                                          isDark ? 0.2 : 0.1,
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "📝",
                                                    // or _getTypeIcon(item.type)
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                                // Type badge
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 6,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: isDark
                                                        ? Colors.blue.shade900
                                                        : const Color(
                                                            0xFFF1F5F9,
                                                          ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    "Exam",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: isDark
                                                          ? Colors.blue.shade200
                                                          : const Color(
                                                              0xFF475569,
                                                            ),
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            // Exam name
                                            Text(
                                              item.name,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: isDark
                                                    ? Colors.white
                                                    : const Color(0xFF1E293B),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        // Bottom stats
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: isDark
                                                  ? Colors.grey.shade700
                                                  : Colors.grey.shade200,
                                              height: 12,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 8),
                                            // Time and Questions row
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.schedule,
                                                        size: 14,
                                                        color: isDark
                                                            ? Colors
                                                                  .grey
                                                                  .shade400
                                                            : const Color(
                                                                0xFF94A3B8,
                                                              ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '20 m',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: isDark
                                                              ? Colors
                                                                    .grey
                                                                    .shade300
                                                              : const Color(
                                                                  0xFF64748B,
                                                                ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .check_circle_outline,
                                                        size: 14,
                                                        color: isDark
                                                            ? Colors
                                                                  .green
                                                                  .shade400
                                                            : Colors
                                                                  .green
                                                                  .shade600,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '35 Q',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: isDark
                                                              ? Colors
                                                                    .green
                                                                    .shade400
                                                              : Colors
                                                                    .green
                                                                    .shade600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🔍', style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        Text(
                          '${widget.subject.id.toString()} - ${widget.subject.name}',
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No exams found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
