import 'package:ezdu/features/forum/models/forum_comment_model.dart';
import 'package:ezdu/features/forum/models/forum_model.dart';
import 'package:flutter/material.dart';

class PostDetailScreen extends StatefulWidget {
  final ForumPost post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late List<ForumComment> comments;
  final TextEditingController _commentController = TextEditingController();
  bool isLoadingComments = false;
  int? replyingToCommentId;

  @override
  void initState() {
    super.initState();
    comments = [
      ForumComment(
        id: 1,
        postId: widget.post.id,
        userId: 'user3',
        userName: 'Ravi Patel',
        userAvatar: '👨‍🏫',
        content:
        'Great question! The quadratic formula is the most reliable method. You can use the discriminant to determine the nature of roots.',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        upvotes: 8,
      ),
      ForumComment(
        id: 2,
        postId: widget.post.id,
        userId: 'user4',
        userName: 'Neha Das',
        userAvatar: '👩‍🎓',
        content:
        'I prefer factorization method when the equation is simple. It\'s faster than other methods.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
        upvotes: 5,
      ),
      ForumComment(
        id: 3,
        postId: widget.post.id,
        userId: 'user5',
        userName: 'Arjun Singh',
        userAvatar: '👨‍💻',
        content:
        'Check out this video tutorial: [link]. It explains all three methods in detail.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        upvotes: 12,
      ),
    ];
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text
        .trim()
        .isEmpty) return;

    final newComment = ForumComment(
      id: comments.length + 1,
      postId: widget.post.id,
      userId: 'current_user',
      userName: 'You',
      userAvatar: '👤',
      content: _commentController.text,
      createdAt: DateTime.now(),
    );

    setState(() {
      comments.add(newComment);
      widget.post.commentCount++;
      _commentController.clear();
      replyingToCommentId = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Comment posted successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _upvoteComment(ForumComment comment) {
    setState(() {
      if (comment.isUpvoted) {
        comment.upvotes--;
        comment.isUpvoted = false;
      } else {
        comment.upvotes++;
        comment.isUpvoted = true;
      }
    });
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      // return DateFormat('dd MMM').format(time);
      return 'date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeAgo = _getTimeAgo(widget.post.createdAt);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFF1E293B),
          ),
        ),
        title: const Text(
          'Discussion',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1E293B)),
            onPressed: () {
              _showMoreOptions(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Post Details
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        // Header
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.blue.withOpacity(
                                        0.2),
                                    child: Text(widget.post.userAvatar,
                                        style: const TextStyle(fontSize: 18)),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.post.userName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                        Text(
                                          timeAgo,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF94A3B8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEFF6FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      '❓ Question',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF3B82F6),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Title
                              Text(
                                widget.post.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Content
                              Text(
                                widget.post.content,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF475569),
                                  height: 1.6,
                                ),
                              ),
                              // Images
                              if (widget.post.images.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.post.images.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                              right: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            color: Colors.grey[200],
                                          ),
                                          width: 150,
                                          child: const Center(
                                            child: Icon(
                                              Icons.image,
                                              color: Color(0xFFCBD5E1),
                                              size: 32,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        // Tags/Categories
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Wrap(
                            spacing: 8,
                            children: [
                              _TagChip(label: '📘 Mathematics'),
                              _TagChip(label: '🧮 Algebra'),
                              _TagChip(label: '📐 Equations'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Comments Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.post.commentCount} Comments',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...comments
                            .asMap()
                            .entries
                            .map((entry) {
                          final index = entry.key;
                          final comment = entry.value;
                          return _CommentTile(
                            comment: comment,
                            isLast: index == comments.length - 1,
                            onUpvote: () => _upvoteComment(comment),
                            onReply: () {
                              setState(() {
                                replyingToCommentId = comment.id;
                                _commentController.text =
                                '@${comment.userName} ';
                              });
                              FocusScope.of(context).requestFocus(
                                FocusNode(),
                              );
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Comment Input Box
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom + 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (replyingToCommentId != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Replying to comment',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              replyingToCommentId = null;
                              _commentController.clear();
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 18,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.blue.withOpacity(0.2),
                      child: const Text('👤', style: TextStyle(fontSize: 14)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _commentController,
                                minLines: 1,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Add a comment...',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 10,
                                  ),
                                  hintStyle:
                                  const TextStyle(color: Color(0xFFAEB0BC)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _addComment,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
                          ),
                        ),
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
void _showMoreOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MoreOptionTile(
            icon: Icons.flag_outlined,
            label: 'Report',
            color: Colors.red,
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post reported')),
              );
            },
          ),
          _MoreOptionTile(
            icon: Icons.info_outlined,
            label: 'Details',
            color: Colors.blue,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          _MoreOptionTile(
            icon: Icons.block,
            label: 'Block User',
            color: Colors.orange,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
  );
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3B82F6),
        ),
      ),
    );
  }
}

class _MoreOptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _MoreOptionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String icon;
  final String label;
  final String sublabel;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.sublabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        Text(
          sublabel,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }
}

class _PostActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _PostActionButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isActive ? const Color(0xFF3B82F6) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isActive ? const Color(0xFFEFF6FF) : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color:
                isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final ForumComment comment;
  final bool isLast;
  final VoidCallback onUpvote;
  final VoidCallback onReply;

  const _CommentTile({
    required this.comment,
    required this.isLast,
    required this.onUpvote,
    required this.onReply,
  });

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      // return DateFormat('dd MMM').format(time);
      return 'date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.green.withOpacity(0.2),
              child: Text(comment.userAvatar, style: const TextStyle(fontSize: 14)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.userName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          comment.content,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF475569),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        _getTimeAgo(comment.createdAt),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: onUpvote,
                        child: Row(
                          children: [
                            Icon(
                              comment.isUpvoted
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_outlined,
                              size: 16,
                              color: comment.isUpvoted
                                  ? const Color(0xFF3B82F6)
                                  : const Color(0xFF94A3B8),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${comment.upvotes}',
                              style: TextStyle(
                                fontSize: 12,
                                color: comment.isUpvoted
                                    ? const Color(0xFF3B82F6)
                                    : const Color(0xFF94A3B8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: onReply,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.reply,
                              size: 16,
                              color: Color(0xFF94A3B8),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Reply',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (!isLast) const SizedBox(height: 16),
      ],
    );
  }
}