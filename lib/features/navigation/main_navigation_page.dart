import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/features/archive/pages/archive_page.dart';
import 'package:ezdu/features/feed/pages/feed_page.dart';
import 'package:ezdu/features/home/pages/home_page.dart';
import 'package:ezdu/features/leaderboard/pages/leaderboard_page.dart';
import 'package:ezdu/features/profile/pages/profile_page.dart';
import 'package:ezdu/features/quest/pages/quest_page.dart';
import 'package:ezdu/features/quiz/pages/quiz_tab_page.dart';
import 'package:flutter/material.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  int _extendedIndex = 0;

  void _onItemTapped(int index) async {
    _currentIndex = index;

    if (index == 4) {
      await _showMoreMenu(context);
      return;
    }

    setState(() {});
  }

  Future<void> _showMoreMenu(BuildContext context) async {
    final overlay = Overlay.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    late OverlayEntry entry;

    void handleSetExtendedIndex(int index) {
      setState(() {
        _extendedIndex = index;
      });
    }

    entry = OverlayEntry(
      builder: (context) => _MoreMenuOverlay(
        colorScheme: colorScheme,
        onDismiss: () => entry.remove(),
        onAction: handleSetExtendedIndex,
      ),
    );

    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Image.asset(
              'assets/icons/house.png',
              height: 24,
              width: 24,
            ),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.card_giftcard_outlined),
          //   activeIcon: Image.asset(
          //     'assets/icons/giftbox.png',
          //     height: 24,
          //     width: 24,
          //   ),
          //   label: 'Quest',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Image.asset(
              'assets/icons/award.png',
              height: 24,
              width: 24,
            ),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Image.asset(
              'assets/icons/reward.png',
              height: 24,
              width: 24,
            ),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed_outlined),
            activeIcon: Image.asset(
              'assets/icons/chat-balloons.png',
              height: 24,
              width: 24,
            ),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            activeIcon: Icon(Icons.more),
            label: 'More',
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    // switch (_currentIndex) {
    //   case 0:
    //     return HomePage(quizRepository: sl());
    //   case 1:
    //     return QuestPage(userQuestRepository: sl());
    //   case 2:
    //     return QuizTabPage();
    //   case 3:
    //     return LeaderboardPage(leaderboardRepository: sl());
    //   case 4:
    //     return FeedPage(feedRepository: sl());
    //   case 5:
    //     return _buildExtendedBody(context);
    //   default:
    //     return SizedBox.shrink();
    // }
    switch (_currentIndex) {
      case 0:
        return HomePage(quizRepository: sl());
      case 1:
        return LeaderboardPage(leaderboardRepository: sl());
      case 2:
        return QuizTabPage();
      case 3:
        return FeedPage(feedRepository: sl());
      case 4:
        return _buildExtendedBody(context);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildExtendedBody(BuildContext context) {
    switch (_extendedIndex) {
      case 0:
        return ProfilePage(userRepository: sl());
      case 1:
        return ArchivePage(subjectRepository: sl());
      case 2:
        return ArchivePage(subjectRepository: sl());
      default:
        return SizedBox.shrink();
    }
  }
}

typedef MenuActionCallback = void Function(int index);

class _MoreMenuOverlay extends StatefulWidget {
  const _MoreMenuOverlay({
    required this.colorScheme,
    required this.onDismiss,
    required this.onAction,
  });

  final ColorScheme colorScheme;
  final VoidCallback onDismiss;
  final MenuActionCallback onAction;

  @override
  State<_MoreMenuOverlay> createState() => _MoreMenuOverlayState();
}

class _MoreMenuOverlayState extends State<_MoreMenuOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _offsetAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOutCubic, // A modern, smooth curve
            reverseCurve: Curves.easeInCubic,
          ),
        );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  void _handleDismiss() async {
    await _controller.reverse();

    if (mounted) {
      widget.onDismiss();
    }
  }

  void _handleAction(int index) {
    _controller.reverse().then((_) {
      widget.onAction(index);
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.colorScheme;
    final outlineColor = colorScheme.outlineVariant;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: _handleDismiss,
            behavior: HitTestBehavior.translucent,
          ),
        ),

        // 2. Floating popup with animation wrappers
        Positioned(
          left: 0,
          right: 0,
          bottom: 80,

          child: SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: outlineColor),
                            top: BorderSide(color: outlineColor),
                          ),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.person_outline),
                          title: const Text('Profile'),
                          onTap: () => _handleAction(0),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: outlineColor),
                          ),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.history),
                          title: const Text('History'),
                          onTap: () => _handleAction(1),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: outlineColor),
                          ),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.archive_outlined),
                          title: const Text('Archive'),
                          onTap: () => _handleAction(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
