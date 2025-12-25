import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/repositories/subject_repository.dart';
import 'package:ezdu/features/archive/pages/exams_page.dart';
import 'package:ezdu/features/archive/widgets/archive_stat_card.dart';
import 'package:ezdu/features/archive/widgets/archive_subject_card.dart';
import 'package:ezdu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchivePage extends ConsumerStatefulWidget {
  const ArchivePage({super.key, required this.subjectRepository});

  final SubjectRepository subjectRepository;

  @override
  ConsumerState<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends ConsumerState<ArchivePage> {
  late Future<ApiResponse<PagedList<SubjectModel>>> _subjectListFuture;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _subjectListFuture = widget.subjectRepository.getSubjectList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.read(userProvider);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

            if (isKeyboardOpen) {
              FocusScope.of(context).unfocus();
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      if (Navigator.canPop(context)) ...[
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : const Color(0xFF1E293B),
                            size: 22,
                          ),
                        ),

                        const SizedBox(width: 12),
                      ],

                      // Page Title
                      Expanded(
                        child: Text(
                          'Archive',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          label: 'Streak',
                          value: userState.streak.toString(),
                          icon: '🔥',
                          backgroundColor: const Color(0xFFD4765F),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          label: 'Points',
                          value: userState.totalXp.toString(),
                          icon: '⭐',
                          backgroundColor: const Color(0xFFD4B84E),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          icon: '🪙',
                          label: 'Coin',
                          value: userState.coin.toString(),
                          backgroundColor: const Color(0xFF70AD47),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickySearchDelegate(
                  context: context,
                  child: Container(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF0F172A)
                        : Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withValues(alpha: 0.08)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white.withValues(alpha: 0.1)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value.toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search subjects...',
                          hintStyle: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white54
                                : const Color(0xFF94A3B8),
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white54
                                : const Color(0xFF94A3B8),
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white54
                                        : const Color(0xFF94A3B8),
                                  ),
                                )
                              : null,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Explore Subjects',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      FutureBuilder(
                        future: _subjectListFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      'Loading subjects...',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      color: Colors.red[400],
                                      size: 48,
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Error loading data',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          if (snapshot.hasData &&
                              snapshot.data!.data != null &&
                              snapshot.data!.data!.totalCount > 0) {
                            final subjects = snapshot.data!.data!.items;

                            // CHANGED: Filter subjects based on search
                            final filteredSubjects = _searchQuery.isEmpty
                                ? subjects
                                : subjects
                                      .where(
                                        (subject) => subject.name
                                            .toLowerCase()
                                            .contains(_searchQuery),
                                      )
                                      .toList();

                            // CHANGED: Show no results message if search returns empty
                            if (filteredSubjects.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No subjects match your search',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.85,
                                  ),
                              itemCount: filteredSubjects.length,
                              itemBuilder: (context, index) {
                                final subject = filteredSubjects[index];
                                final cardColor =
                                    _cardColors[index % _cardColors.length];

                                return SubjectCard(
                                  subject: subject,
                                  cardColor: cardColor,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      SlideRightToLeftRoute(
                                        page: ExamListScreen(
                                          subject: subject,
                                          archiveRepository: sl(),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }

                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No subjects found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final List<Color> _cardColors = [
  const Color(0xFFFF9800), // Deep Orange
  const Color(0xFF2196F3), // Deep Blue
  const Color(0xFF4CAF50), // Deep Green
  const Color(0xFFE91E63), // Deep Pink
  const Color(0xFFFF5722), // Deep Red-Orange
  const Color(0xFF00BCD4), // Deep Cyan
  const Color(0xFF9C27B0), // Deep Purple
  const Color(0xFFFBC02D), // Deep Amber
];

class _StickySearchDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final BuildContext context;

  _StickySearchDelegate({required this.child, required this.context});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  double get maxExtent => 72;

  @override
  double get minExtent => 72;

  @override
  bool shouldRebuild(_StickySearchDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}
