import 'package:ezdu/features/forum/models/forum_model.dart';
import 'package:flutter/material.dart';

class ForumPostCard extends StatelessWidget {
  final ForumPost post;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;
  final VoidCallback onBookmark;
  final VoidCallback onComment;

  const ForumPostCard({
    required this.post,
    required this.onUpvote,
    required this.onDownvote,
    required this.onBookmark,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    final timeAgo = _getTimeAgo(post.createdAt);

    return GestureDetector(
      onTap: onComment,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue.withOpacity(0.2),
                  child: Text(post.userAvatar, style: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Question',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 8),

            // Content
            Text(
              post.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF475569),
                height: 1.5,
              ),
            ),

            // Images
            if (post.images.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: post.images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                        ),
                        width: 120,
                        child: const Center(
                          child: Icon(Icons.image, color: Color(0xFFCBD5E1)),
                        ),
                      );
                    },
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // Stats Row
            Row(
              children: [
                Chip(
                  label: Text('📘 Mathematics'),
                  backgroundColor: const Color(0xFFEFF6FF),
                  labelStyle: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text('${post.commentCount} 💬'),
                  backgroundColor: const Color(0xFFF3F4F6),
                  labelStyle: const TextStyle(fontSize: 12),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // _ActionButton(
                //   icon: post.isUpvoted! ? Icons.thumb_up : Icons.thumb_up_outlined,
                //   label: '${post.upvotes}',
                //   isActive: post.isUpvoted!,
                //   onTap: onUpvote,
                // ),
                // _ActionButton(
                //   icon:
                //   post.isDownvoted! ? Icons.thumb_down : Icons.thumb_down_outlined,
                //   label: '${post.downvotes}',
                //   isActive: post.isDownvoted!,
                //   onTap: onDownvote,
                // ),

                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comment',
                  isActive: false,
                  onTap: onComment,
                ),
                _ActionButton(
                  icon: post.isBookmarked! ? Icons.bookmark : Icons.bookmark_outline,
                  label: 'Save',
                  isActive: post.isBookmarked!,
                  onTap: onBookmark,
                ),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  isActive: false,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
      return 'na';
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color:
              isActive ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}