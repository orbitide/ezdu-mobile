import 'package:ezdu/data/models/lesson_model.dart';
import 'package:ezdu/data/models/subject_model.dart';
import 'package:ezdu/data/models/topic_model.dart';
import 'package:ezdu/features/forum/models/forum_model.dart';
import 'package:ezdu/features/forum/pages/create_page.dart';
import 'package:ezdu/features/forum/pages/forum_detail_page.dart';
import 'package:ezdu/features/forum/widgets/filter_chip.dart';
import 'package:ezdu/features/forum/widgets/forum_post_card.dart';
import 'package:flutter/material.dart';

class ForumHomeScreen extends StatefulWidget {
  const ForumHomeScreen({super.key});

  @override
  State<ForumHomeScreen> createState() => _ForumHomeScreenState();
}


class _ForumHomeScreenState extends State<ForumHomeScreen> {


  int? selectedSubject;
  int? selectedLesson;
  int? selectedTopic;
  String searchQuery = '';
  // String sortBy = 'recent';

  List<ForumPost> get filteredPosts {
    List<ForumPost> filtered = posts;

    if (selectedSubject != null) {
      filtered = filtered.where((p) => p.subjectId == selectedSubject).toList();
    }

    if (selectedLesson != null) {
      filtered = filtered.where((p) => p.lessonId == selectedLesson).toList();
    }

    if (selectedTopic != null) {
      filtered = filtered.where((p) => p.topicId == selectedTopic).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((p) =>
      p.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
          p.content.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }



    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Forum',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFF1F5F9)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Create Post Button
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => CreatePostScreen(
              //             subjects: subjects,
              //             lessons: lessons,
              //             topics: topics,
              //             onPostCreated: (newPost) {
              //               setState(() {
              //                 posts.insert(0, newPost);
              //               });
              //             },
              //           ),
              //         ),
              //       );
              //     },
              //     child: Container(
              //       padding: const EdgeInsets.all(16),
              //       decoration: BoxDecoration(
              //         gradient: const LinearGradient(
              //           colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
              //         ),
              //         borderRadius: BorderRadius.circular(16),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.blue.withOpacity(0.3),
              //             blurRadius: 12,
              //             offset: const Offset(0, 4),
              //           ),
              //         ],
              //       ),
              //       child: Row(
              //         children: [
              //           const CircleAvatar(
              //             radius: 24,
              //             backgroundColor: Colors.white24,
              //             child: Text('👤', style: TextStyle(fontSize: 20)),
              //           ),
              //           const SizedBox(width: 12),
              //           Expanded(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 const Text(
              //                   'Create a post',
              //                   style: TextStyle(
              //                     color: Colors.white70,
              //                     fontSize: 12,
              //                   ),
              //                 ),
              //                 const SizedBox(height: 4),
              //                 const Text(
              //                   'Share your question or knowledge...',
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 14,
              //                     fontWeight: FontWeight.w600,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const Icon(
              //             Icons.add_circle,
              //             color: Colors.white,
              //             size: 28,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),

              // Filters
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Subject Filter
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FilterForumChip(
                            label: 'All',
                            isSelected: selectedSubject == null,
                            onTap: () {
                              setState(() {
                                selectedSubject = null;
                                selectedLesson = null;
                                selectedTopic = null;
                              });
                            },
                          ),
                          ...subjects.map((subject) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterForumChip(
                                label: '${subject.name}',
                                isSelected: selectedSubject == subject.id,
                                onTap: () {
                                  setState(() {
                                    selectedSubject = subject.id;
                                    selectedLesson = null;
                                    selectedTopic = null;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Lesson Filter
                    if (selectedSubject != null)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterForumChip(
                              label: 'All Lessons',
                              isSelected: selectedLesson == null,
                              onTap: () {
                                setState(() {
                                  selectedLesson = null;
                                  selectedTopic = null;
                                });
                              },
                            ),
                            ...lessons[selectedSubject]?.map((lesson) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterForumChip(
                                  label: lesson.name,
                                  isSelected: selectedLesson == lesson.id,
                                  onTap: () {
                                    setState(() {
                                      selectedLesson = lesson.id;
                                      selectedTopic = null;
                                    });
                                  },
                                ),
                              );
                            }).toList() ??
                                [],
                          ],
                        ),
                      ),
                    const SizedBox(height: 12),

                    // Topic Filter
                    if (selectedLesson != null)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterForumChip(
                              label: 'All Topics',
                              isSelected: selectedTopic == null,
                              onTap: () {
                                setState(() => selectedTopic = null);
                              },
                            ),
                            ...topics[selectedLesson]?.map((topic) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: FilterForumChip(
                                  label: topic.name,
                                  isSelected: selectedTopic == topic.id,
                                  onTap: () {
                                    setState(
                                            () => selectedTopic = topic.id);
                                  },
                                ),
                              );
                            }).toList() ??
                                [],
                          ],
                        ),
                      ),

                  ],
                ),
              ),

              // Posts List
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: filteredPosts.isEmpty
                      ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          const Text(
                            '📭',
                            style: TextStyle(fontSize: 48),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'No posts found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                      : filteredPosts
                      .map((post) => ForumPostCard(
                    post: post,
                    onUpvote: () {
                      setState(() {
                        if (post.isUpvoted!) {
                          post.upvotes--!;
                          post.isUpvoted = false;
                        } else {
                          post.upvotes++;
                          post.isUpvoted = true;
                          if (post.isDownvoted) {
                            post.downvotes--;
                            post.isDownvoted = false;
                          }
                        }
                      });
                    },
                    onDownvote: () {
                      setState(() {
                        if (post.isDownvoted) {
                          post.downvotes--;
                          post.isDownvoted = false;
                        } else {
                          post.downvotes++;
                          post.isDownvoted = true;
                          if (post.isUpvoted) {
                            post.upvotes--;
                            post.isUpvoted = false;
                          }
                        }
                      });
                    },
                    onBookmark: () {
                      setState(() {
                        post.isBookmarked = !post.isBookmarked;
                      });
                    },
                    onComment: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PostDetailScreen(post: post),
                        ),
                      );
                    },
                  ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _SortDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const _SortDropdown({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
          ),
        ],
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(value: 'recent', child: Text('🕐 Recent')),
          DropdownMenuItem(value: 'trending', child: Text('📈 Trending')),
          DropdownMenuItem(value: 'comments', child: Text('💬 Most Discussed')),
        ],
        onChanged: (newValue) {
          if (newValue != null) onChanged(newValue);
        },
      ),
    );
  }
}




List<ForumPost> posts = [
  ForumPost(
    id: 1,
    userId: 'user1',
    userName: 'Alex Kumar',
    userAvatar: '👨‍💼',
    title: 'How to solve quadratic equations quickly?',
    content: 'Can someone explain the fastest method to solve quadratic equations? I am struggling with the discriminant method.',
    images: [],
    subjectId: 1,
    lessonId: 1,
    topicId: 2,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    upvotes: 15,
    commentCount: 5,
  ),
  ForumPost(
    id: 2,
    userId: 'user2',
    userName: 'Priya Singh',
    userAvatar: '👩‍🎓',
    title: 'English Grammar Tips for SSC',
    content: 'Just passed the grammar section with 48/50. Here are my tips and tricks!',
    images: ['image1.jpg'],
    subjectId: 2,
    lessonId: 4,
    topicId: 7,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    upvotes: 42,
    downvotes: 2,
    commentCount: 12,
  ),
];


final List<SubjectModel> subjects = [
  SubjectModel(id: 1, name: 'Mathematics', activeQuizCount: 0, code: "110"),
  SubjectModel(id: 2, name: 'English', activeQuizCount: 0, code: "110"),
  SubjectModel(id: 3, name: 'Physics', activeQuizCount: 0, code: "110"),
  SubjectModel(id: 4, name: 'Chemistry', activeQuizCount: 0, code: "110"),
];

final Map<int, List<LessonModel>> lessons = {
  1: [
    LessonModel(id: 1, name: 'Algebra', subjectId: 1),
    LessonModel(id: 2, name: 'Geometry', subjectId: 1),
    LessonModel(id: 3, name: 'Calculus', subjectId: 1),
  ],
  2: [
    LessonModel(id: 4, name: 'Grammar', subjectId: 2),
    LessonModel(id: 5, name: 'Literature', subjectId: 2),
  ],
  3: [
    LessonModel(id: 6, name: 'Mechanics', subjectId: 3),
    LessonModel(id: 7, name: 'Thermodynamics', subjectId: 3),
  ],
  4: [
    LessonModel(id: 8, name: 'Organic Chemistry', subjectId: 4),
    LessonModel(id: 9, name: 'Inorganic Chemistry', subjectId: 4),
  ],
};

final Map<int, List<TopicModel>> topics = {
  1: [
    TopicModel(id: 1, name: 'Linear Equations', lessonId: 1),
    TopicModel(id: 2, name: 'Quadratic Equations', lessonId: 1),
  ],
  2: [
    TopicModel(id: 3, name: 'Triangles', lessonId: 2),
    TopicModel(id: 4, name: 'Circles', lessonId: 2),
  ],
  3: [
    TopicModel(id: 5, name: 'Derivatives', lessonId: 3),
    TopicModel(id: 6, name: 'Integrals', lessonId: 3),
  ],
  4: [
    TopicModel(id: 7, name: 'Tenses', lessonId: 4),
    TopicModel(id: 8, name: 'Articles', lessonId: 4),
  ],
  5: [
    TopicModel(id: 9, name: 'Shakespeare', lessonId: 5),
    TopicModel(id: 10, name: 'Modern Poetry', lessonId: 5),
  ],
  6: [
    TopicModel(id: 11, name: 'Motion Laws', lessonId: 6),
    TopicModel(id: 12, name: 'Energy', lessonId: 6),
  ],
  7: [
    TopicModel(id: 13, name: 'Heat Transfer', lessonId: 7),
    TopicModel(id: 14, name: 'Temperature', lessonId: 7),
  ],
  8: [
    TopicModel(id: 15, name: 'Reaction Mechanism', lessonId: 8),
    TopicModel(id: 16, name: 'Synthesis', lessonId: 8),
  ],
  9: [
    TopicModel(id: 17, name: 'Periodic Table', lessonId: 9),
    TopicModel(id: 18, name: 'Bonding', lessonId: 9),
  ],
};