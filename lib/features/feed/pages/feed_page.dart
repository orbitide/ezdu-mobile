import 'package:ezdu/core/constants/app_constants.dart';
import 'package:ezdu/data/models/feed_model.dart';
import 'package:ezdu/data/repositories/feed_repository.dart';
import 'package:ezdu/features/feed/widgets/feed_achievement_card.dart';
import 'package:ezdu/features/feed/widgets/feed_announcement_card.dart';
import 'package:ezdu/features/feed/widgets/feed_friend_suggestion_slider.dart';
import 'package:ezdu/features/feed/widgets/feed_notification_card.dart';
import 'package:ezdu/features/feed/widgets/feed_sentence_shared_card.dart';
import 'package:ezdu/features/feed/widgets/feed_single_recommended_friend.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key, required this.feedRepository});

  final FeedRepository feedRepository;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await feedRepository.getFeedList();
      },
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Feed',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Celebrate your friends' learning journey",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              FutureBuilder(
                future: feedRepository.getFeedList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SliverToBoxAdapter(
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text('Loading...'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasData && snapshot.data!.data != null) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = snapshot.data!.data!.items[index];

                        switch (item.type) {
                          case FeedType.Achievement:
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AchievementCard(
                                feedItem: item,
                                onLikeTap: () {},
                              ),
                            );
                          case FeedType.SentenceShare:
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SentenceShareCard(
                                feedItem: item,
                                onLikeTap: () {},
                              ),
                            );
                          case FeedType.FriendSuggestion:
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: FriendSuggestionsSlider(
                                // pageController: _pageController,
                                onPageChanged: (page) {
                                  // setState(() => _currentPage = page);
                                },
                                onRemoveItem: (itemId) {},
                              ),
                            );
                          case FeedType.SingleFriend:
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SingleRecommendedFriend(
                                feedItem: item,
                                onAddFriend: () {},
                              ),
                            );
                          case FeedType.Notification:
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: NotificationCard(
                                feedItem: item,
                                onDismiss: () {},
                              ),
                            );
                          case FeedType.Announcement:
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: AnnouncementCard(
                                feedItem: item,
                                onDismiss: () {},
                              ),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }, childCount: snapshot.data!.data!.totalCount),
                    );
                  }

                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'No more updates from the past week',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                  );
                },
              ),

              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              // Feed Items
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = feedItems[index];

                  switch (item.type) {
                    case FeedType.Achievement:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AchievementCard(
                          feedItem: item,
                          onLikeTap: () {},
                        ),
                      );
                    case FeedType.SentenceShare:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SentenceShareCard(
                          feedItem: item,
                          onLikeTap: () {},
                        ),
                      );
                    case FeedType.FriendSuggestion:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: FriendSuggestionsSlider(
                          // pageController: _pageController,
                          onPageChanged: (page) {
                            // setState(() => _currentPage = page);
                          },
                          onRemoveItem: (itemId) {},
                        ),
                      );
                    case FeedType.SingleFriend:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SingleRecommendedFriend(
                          feedItem: item,
                          onAddFriend: () {},
                        ),
                      );
                    case FeedType.Notification:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: NotificationCard(
                          feedItem: item,
                          onDismiss: () {},
                        ),
                      );
                    case FeedType.Announcement:
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: AnnouncementCard(
                          feedItem: item,
                          onDismiss: () {},
                        ),
                      );
                    default:
                      return const SizedBox.shrink();
                  }
                }, childCount: feedItems.length),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text(
                    'No more updates from the past week',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
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

final feedItems = [
  FeedItem(
    id: 1,
    type: FeedType.Achievement,
    name: 'Sarah Chen',
    userImageUrl: '👩‍🦰',
    message: 'reached a 30-day streak!',
    createdAt: '2025-11-23T15:24:50.123456Z',
    likeCount: 24,
    isRead: false,
    userId: 1,
    content: '',
    subjectId: 1,
    subject: "math",
    subjectImageUrl: '',
    topicId: 1,
    topic: '',
    title: '',
  ),
  FeedItem(
    id: 2,
    type: FeedType.SentenceShare,
    name: 'Alex Rodriguez',
    // Changed from userName
    userImageUrl: '👨‍💼',
    // Changed from avatar
    message:
        'shared a sentence: "El gato está durmiendo en el sofá" (The cat is sleeping on the sofa)',
    // Combined action, sentence, and translation
    createdAt: '2025-11-23T15:00:00.000000Z',
    // Changed from timestamp
    likeCount: 42,
    isRead: false,
    // Defaulted
    userId: 2,
    // Defaulted
    content: 'Language: French 🇫🇷',
    // Stored extra info here
    subjectId: 2,
    // Defaulted
    subjectImageUrl: '',
    topicId: 2,
    // Defaulted
    topic: 'French',
    // Defaulted
    title: '',
  ),
  FeedItem(
    id: 3,
    type: FeedType.FriendSuggestion,
    name: 'Suggestions',
    // Defaulted
    userImageUrl: '',
    message: 'Find new friends to connect with!',
    // Defaulted
    createdAt: '2025-11-23T10:25:00.000000Z',
    // Defaulted
    likeCount: 0,
    isRead: true,
    // Likely true for non-action items
    userId: 0,
    // Defaulted
    content: 'slider',
    // Stored type content
    subjectId: 0,
    // Defaulted
    subjectImageUrl: '',
    topicId: 0,
    // Defaulted
    topic: '',
    title: '',
  ),
  FeedItem(
    id: 4,
    type: FeedType.SingleFriend,
    name: 'Jordan Lee',
    // Changed from userName
    userImageUrl: '👩‍🎓',
    // Changed from avatar
    message: 'Connect with Jordan. You have 3 mutual friends.',
    // Combined action
    createdAt: '2025-11-22T13:25:00.000000Z',
    // Defaulted
    likeCount: 0,
    isRead: true,
    // Likely true
    userId: 4,
    // Defaulted
    content: 'Language: Japanese 🇯🇵',
    // Stored extra info
    subjectId: 4,
    // Defaulted
    subjectImageUrl: '',
    topicId: 4,
    // Defaulted
    topic: 'Japanese',
    // Defaulted
    title: '',
  ),
  FeedItem(
    id: 5,
    type: FeedType.Notification,
    name: 'System Alert',
    // Defaulted
    userImageUrl: '',
    message: "You haven't practiced today. Keep your streak alive!",
    // Changed from message
    createdAt: '2025-11-22T13:25:00.000000Z',
    // Changed from timestamp
    likeCount: 0,
    isRead: false,
    userId: 0,
    // Defaulted
    content: '',
    subjectId: 0,
    // Defaulted
    subjectImageUrl: '',
    topicId: 0,
    // Defaulted
    topic: '',
    title: 'Daily Practice Reminder',
  ),
  FeedItem(
    id: 6,
    type: FeedType.Achievement,
    name: 'Marcus Thompson',
    // Changed from userName
    userImageUrl: '👨‍🎯',
    // Changed from avatar
    message: 'is now in 2nd place in Gold League!',
    // Changed from action
    createdAt: '2025-11-16T15:25:00.000000Z',
    // Changed from timestamp
    likeCount: 56,
    isRead: false,
    userId: 6,
    // Defaulted
    content: 'Language: German 🇩🇪',
    // Stored extra info
    subjectId: 6,
    // Defaulted
    subjectImageUrl: '',
    topicId: 6,
    // Defaulted
    topic: 'German',
    // Defaulted
    title: 'League Update',
  ),
  FeedItem(
    id: 7,
    type: FeedType.Announcement,
    name: 'App News',
    // Defaulted
    userImageUrl: '',
    message: 'Try the new Monthly Challenge and earn special rewards!',
    // Changed from message
    createdAt: '2025-11-16T15:25:00.000000Z',
    // Changed from timestamp
    likeCount: 0,
    isRead: true,
    userId: 0,
    // Defaulted
    content: '',
    subjectId: 0,
    // Defaulted
    subjectImageUrl: '',
    topicId: 0,
    // Defaulted
    topic: '',
    title: '🎉 New Challenge Available',
  ),
  FeedItem(
    id: 8,
    type: FeedType.Achievement,
    // Keeping Type 6 for all 'achievement' types
    name: 'Emma Wilson',
    // Changed from userName
    userImageUrl: '👩‍🔬',
    // Changed from avatar
    message: 'completed 1,000 XP this week!',
    // Changed from action
    createdAt: '2025-11-16T15:25:00.000000Z',
    // Changed from timestamp
    likeCount: 38,
    isRead: false,
    userId: 8,
    // Defaulted
    content: 'Language: Italian 🇮🇹',
    // Stored extra info
    subjectId: 8,
    // Defaulted
    subjectImageUrl: '',
    topicId: 8,
    // Defaulted
    topic: 'Italian',
    // Defaulted
    title: 'XP Milestone', // Defaulted
  ),
];
