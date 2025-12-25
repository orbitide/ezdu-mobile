import 'package:ezdu/core/utils/helpers.dart';
import 'package:ezdu/data/models/feed_model.dart';
import 'package:flutter/material.dart';

class SentenceShareCard extends StatelessWidget {
  final FeedItem feedItem;
  final VoidCallback onLikeTap;

  const SentenceShareCard({
    Key? key,
    required this.feedItem,
    required this.onLikeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  feedItem.userImageUrl ?? '',
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            feedItem.name ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            TimeHelper.formatRelativeTime(feedItem.createdAt),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feedItem.message ?? '',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        feedItem.subject ?? '',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.surfaceContainer,
            padding: const EdgeInsets.all(16),
            child: Text(
              '"${feedItem.content ?? ''}"',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
              ),
            ),
          ),
          // Container(
          //   color: Theme.of(context).secondaryHeaderColor,
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //   child: Row(
          //     children: [
          //       Icon(Icons.favorite, size: 16, color: Colors.red),
          //       const SizedBox(width: 4),
          //       Text(
          //         '${feedItem.likeCount} likes',
          //         style: TextStyle(
          //           fontSize: 12,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
