import 'package:ezdu/app/routes/app_routes.dart';
import 'package:ezdu/app/theme/app_themes.dart';
import 'package:ezdu/providers/auth_provider.dart';
import 'package:ezdu/providers/notification_provider.dart';
import 'package:ezdu/providers/onboarding_provider.dart';
import 'package:ezdu/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [authInitProvider, onboardingInitProvider],
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(authInitProvider);
          ref.watch(onboardingInitProvider);

          final authState = ref.watch(authProvider);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final notifier = ref.read(notificationProvider.notifier);
            final userNotifier = ref.read(userProvider.notifier);

            await notifier.initialize();
            if (authState.isLoggedIn) {
              await notifier.syncToken();
              await userNotifier.init();
            }
          });

          return MaterialApp(
            title: 'ezdu',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: '/',
          );
        },
      ),
    );
  }
}
