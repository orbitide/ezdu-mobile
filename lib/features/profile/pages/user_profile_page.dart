// all other user profile page
import 'package:ezdu/core/models/api_response.dart';
import 'package:ezdu/data/models/user_model.dart';
import 'package:ezdu/data/repositories/user_repository.dart';
import 'package:ezdu/features/profile/widgets/profile_details.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({
    super.key,
    required this.userId,
    required this.userRepository,
  });

  final int userId;
  final UserRepository userRepository;

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePage();
}

class _UserProfilePage extends ConsumerState<UserProfilePage> {
  late Future<ApiResponse<UserDetailsModel>> _userFuture;
  late String profileName = '';

  @override
  void initState() {
    super.initState();
    _userFuture = widget.userRepository.getUserDetails(widget.userId);

    _userFuture.then((response) {
      if (response.data != null) {
        setState(() {
          profileName = response.data!.name;
        });
      }
    });
  }

  Future<void> _refreshProfile() async {
    setState(() {
      _userFuture = widget.userRepository.getUserDetails(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider).data;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(profileName, style: TextStyle(fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showProfileOptions(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<ApiResponse<UserDetailsModel>>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshProfile,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data?.data == null) {
            return const Center(child: Text('No user data found'));
          }

          final user = snapshot.data!.data!;

          // setState(() {
          //   isFollowing = user.isFollowing;
          //   followers = user.followers;
          //   following = user.following;
          // });

          return RefreshIndicator(
            onRefresh: _refreshProfile,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildProfileHeader(user),
                  UserDetailsWidget(
                    user: user,
                    isMyself: authState?.id == user.id,
                    lastQuizzes: user.quizzes,
                    onFollowPressed: () => _handleFollowPressed(user),
                    onFriendPressed: () => _handleFriendPressed(user),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(UserDetailsModel user) {
    return Stack(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withValues(alpha: 0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatars/1.png'),
                    backgroundColor: Colors.grey[300],
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showProfileOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(context);
                _blockUser();
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Report User'),
              onTap: () {
                Navigator.pop(context);
                _reportUser();
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Profile'),
              onTap: () {
                Navigator.pop(context);
                _shareProfile();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleFollowPressed(UserDetailsModel user) async {
    bool wantToFollow = !user.isFollowing;

    var result;

    if (user.isFollowing) {
      result = await widget.userRepository.unFollowUser(user.id);
    } else {
      result = await widget.userRepository.followUser(user.id);
    }

    if (result.success) {
      setState(() {
        user.isFollowing = wantToFollow;

        if (wantToFollow) {
          user.followers = (user.followers ?? 0) + 1;
        } else {
          user.followers = (user.followers ?? 0) - 1;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Action failed. Please try again.')),
      );
    }
  }

  void _handleFriendPressed(UserDetailsModel user) {
    // TODO: Implement friend request logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(false ? 'Friend removed' : 'Friend request sent')),
    );
  }

  void _blockUser() {
    // TODO: Implement block user logic
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('User blocked')));
  }

  void _reportUser() {
    // TODO: Implement report user logic
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Report submitted')));
  }

  void _shareProfile() {
    // TODO: Implement share profile logic
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile shared')));
  }
}
