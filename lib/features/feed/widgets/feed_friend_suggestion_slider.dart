import 'package:flutter/material.dart';

class FriendSuggestionsSlider extends StatefulWidget {
  // final PageController pageController;
  final Function(int) onPageChanged;
  final Function(String) onRemoveItem;

  const FriendSuggestionsSlider({
    Key? key,
    // required this.pageController,
    required this.onPageChanged,
    required this.onRemoveItem,
  }) : super(key: key);

  @override
  State<FriendSuggestionsSlider> createState() =>
      _FriendSuggestionsSliderState();
}

class _FriendSuggestionsSliderState extends State<FriendSuggestionsSlider> {
  final List<Map<String, dynamic>> suggestedFriends = [
    {
      'name': 'Jordan Lee',
      'avatar': '👩‍🎓',
      'friends': 3,
      'language': '🇯🇵 Japanese',
    },
    {
      'name': 'David Kim',
      'avatar': '👨‍💻',
      'friends': 5,
      'language': '🇰🇷 Korean',
    },
    {
      'name': 'Sofia Martinez',
      'avatar': '👩‍🎨',
      'friends': 4,
      'language': '🇪🇸 Spanish',
    },
    {
      'name': 'Lucas Chen',
      'avatar': '👨‍🏫',
      'friends': 2,
      'language': '🇨🇳 Mandarin',
    },
    {
      'name': 'Anna Mueller',
      'avatar': '👩‍⚕️',
      'friends': 6,
      'language': '🇩🇪 German',
    },
  ];
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended Friends',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() => _currentPage = page);
                  widget.onPageChanged(page);
                },
                itemCount: suggestedFriends.length,
                itemBuilder: (context, index) {
                  return _buildFriendCard(suggestedFriends[index]);
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                suggestedFriends.length,
                (index) => GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    height: 8,
                    width: _currentPage == index ? 24 : 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.green[600]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendCard(Map<String, dynamic> friend) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(
              context,
            ).colorScheme.surfaceContainer.withValues(alpha: .1),
            Theme.of(
              context,
            ).colorScheme.surfaceContainer.withValues(alpha: .8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(friend['avatar'], style: const TextStyle(fontSize: 40)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      friend['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${friend['friends']} mutual friends',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            friend['language'],
            style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added ${friend['name']} as friend!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add Friend'),
            ),
          ),
        ],
      ),
    );
  }
}
