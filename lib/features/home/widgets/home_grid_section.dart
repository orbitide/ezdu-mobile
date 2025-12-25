import 'package:flutter/material.dart';

class HomeGridSection extends StatelessWidget {
  const HomeGridSection({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final gridItems = [
      HomeGridItem(
        icon: Image.asset(
          'assets/icons/paper.png',
          height: 32,
          width: 32,
        ),
        title: 'Archive',
        route: isLoggedIn ? '/archive' : '/login',
        color: Colors.purpleAccent,
      ),
      HomeGridItem(
        icon: Image.asset(
          'assets/icons/puzzle.png',
          height: 32,
          width: 32,
        ),
        title: 'Quick Challenge',
        route: isLoggedIn ? '/quiz' : '/login',
        color: Colors.orangeAccent,
      ),
      HomeGridItem(
        icon: Image.asset(
          'assets/icons/quiz.png',
          height: 32,
          width: 32,
        ),
        title: 'Quiz',
        route: isLoggedIn ? '/quiz' : '/login',
        color: Colors.greenAccent,
      ),
      HomeGridItem(
        icon: Image.asset(
          'assets/icons/chat.png',
          height: 32,
          width: 32,
        ),
        title: 'Forum',
        route: isLoggedIn ? '/forum' : '/login',
        color: Colors.cyanAccent,
      ),
      HomeGridItem(
        icon: Image.asset(
          'assets/icons/podium.png',
          height: 32,
          width: 32,
        ),
        title: 'Leaderboard',
        route: isLoggedIn ? '/leaderboard' : '/login',
        color: Colors.amberAccent,
      ),
      HomeGridItem(
        icon: Image.asset(
          'assets/icons/seller.png',
          height: 32,
          width: 32,
        ),
        title: 'Shop',
        route: isLoggedIn ? '/shop' : '/login',
        color: Colors.pinkAccent,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: gridItems.length,
      // padding: const EdgeInsets.only(top: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final item = gridItems[index];
        return _buildHomeButton(context, item);
      },
    );
  }

  Widget _buildHomeButton(BuildContext context, HomeGridItem item) {
    final cardBackground = Theme.of(context).brightness == Brightness.dark
        ? item.color.withOpacity(0.2)
        : item.color.withOpacity(0.15);

    return InkWell(
      onTap: () => Navigator.pushNamed(context, item.route),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            item.icon, // now can be Icon or Image
            const SizedBox(height: 8),
            Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}


class HomeGridItem {
  final Widget icon;
  final String title;
  final String route;
  final Color color;

  HomeGridItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.color,
  });
}
