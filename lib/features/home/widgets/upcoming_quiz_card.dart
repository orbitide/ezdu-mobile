import 'package:ezdu/core/utils/helpers.dart';
import 'package:ezdu/data/models/quiz_model.dart';
import 'package:ezdu/features/auth/pages/login_page.dart';
import 'package:ezdu/features/quiz/pages/quiz_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class UpcomingQuizCard extends StatelessWidget {
  const UpcomingQuizCard({
    super.key,
    required this.isLoggedIn,
    required this.quiz,
  });

  final bool isLoggedIn;
  final QuizModel quiz;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final targetLocal = TimeHelper.utcToLocalDateTime(quiz.startTime);
    final endTime = targetLocal.millisecondsSinceEpoch;

    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          border: Border.all(
            color: colorScheme.onPrimaryContainer.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          splashColor: colorScheme.onSurface.withValues(alpha: .1),

          leading: SizedBox(
            width: 32,
            height: 32,
            child: Image.asset(
              'assets/icons/gifs/clock_animation.gif',
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            'Next Quiz: ${quiz.name}',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          subtitle: CountdownTimer(
            endTime: endTime,
            widgetBuilder: (_, CurrentRemainingTime? time) {
              if (time == null) {
                return Text('Quiz is Live!');
              }
              int totalDays = time.days ?? 0;
              int months = totalDays ~/ 30;
              int remainingDays = totalDays % 30;

              String monthString = months > 0 ? '${months}mo ' : '';
              String dayString = remainingDays > 0 ? '${remainingDays}d ' : '';

              String hours = time.hours != null ? '${time.hours}h ' : '';
              String min = time.min != null ? '${time.min}m ' : '';
              String sec = time.sec != null ? '${time.sec}s' : '';

              String finalDayString = (months > 0)
                  ? dayString
                  : (time.days != null ? '${time.days}d ' : '');

              return Text(
                'Starts in: $monthString$finalDayString$hours$min$sec',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: colorScheme.secondary,
            size: 20,
          ),
          onTap: () {
            final navigator = Navigator.of(context);

            if (isLoggedIn) {
              navigator.push(
                MaterialPageRoute(builder: (context) => const QuizTabPage()),
              );
            } else {
              navigator.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
                (route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
