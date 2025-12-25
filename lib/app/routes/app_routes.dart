import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/features/archive/pages/archive_page.dart';
import 'package:ezdu/features/auth/pages/login_page.dart';
import 'package:ezdu/features/auth/pages/register_page.dart';
import 'package:ezdu/features/forum/pages/forum_page.dart';
import 'package:ezdu/features/leaderboard/pages/leaderboard_page.dart';
import 'package:ezdu/features/navigation/main_navigation_page.dart';
import 'package:ezdu/features/profile/pages/profile_page.dart';
import 'package:ezdu/features/quiz/pages/quiz_tab_page.dart';
import 'package:ezdu/features/shop/presentation/shop_page.dart';
import 'package:ezdu/features/splash/pages/onboarding_page.dart';
import 'package:ezdu/features/splash/pages/splash_page.dart';
import 'package:ezdu/features/splash/pages/welcome_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case '/welcome':
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case '/onboarding-flow':
        return MaterialPageRoute(
          builder: (_) => OnboardingFlowPage(classRepository: sl()),
        );

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case '/register':
        return MaterialPageRoute(
          builder: (_) => RegisterPage(authRepository: sl()),
        );

      case '/home':
        return MaterialPageRoute(builder: (_) => const MainNavigationPage());

      case '/archive':
        return MaterialPageRoute(
          builder: (_) => ArchivePage(subjectRepository: sl()),
        );

      case '/shop':
        return MaterialPageRoute(builder: (_) => const ShopPage());

      case '/quiz':
        return MaterialPageRoute(builder: (_) => const QuizTabPage());

      case '/forum':
        return MaterialPageRoute(builder: (_) => const ForumHomeScreen());

      case '/leaderboard':
        return MaterialPageRoute(
          builder: (_) => LeaderboardPage(leaderboardRepository: sl()),
        );

      case '/profile':
        return MaterialPageRoute(
          builder: (_) => ProfilePage(userRepository: sl()),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
