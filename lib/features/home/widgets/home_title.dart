import 'package:ezdu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTitle extends ConsumerWidget{
  const HomeTitle({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/fire.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 4),
            Text(
              isLoggedIn ? userState.streak.toString() : '1',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),

        Row(
          children: [
            // Icon(Icons.star_outline, size: 24),
            Image.asset(
              'assets/icons/storm.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 4),
            Text(
              isLoggedIn ? userState.weekXp.toString() : '10',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/icons/diamond.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 4),
            Text(
              isLoggedIn ? userState.coin.toString() : '50',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),

        Row(
          children: [
            Image.asset(
              'assets/icons/medal.png',
              height: 24,
              width: 24,
            ),
            SizedBox(width: 4),
            Text('Pro', style: TextStyle(fontSize: 14)),
          ],
        ),
      ],
    );
  }

}