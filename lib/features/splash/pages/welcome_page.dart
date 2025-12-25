import 'package:ezdu/app/di/injector.dart';
import 'package:ezdu/core/utils/route_helper.dart';
import 'package:ezdu/features/auth/pages/login_page.dart';
import 'package:ezdu/features/splash/pages/onboarding_page.dart';
import 'package:flutter/material.dart';

// get start page
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 120, color: colorScheme.primary),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.of(
                    //   context,
                    // ).pushNamed('/onboarding-flow');

                    Navigator.of(context).push(
                      SlideRightToLeftRoute(
                        page: OnboardingFlowPage(classRepository: sl()),
                      ),
                    );
                    return;
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                  child: const Text('GET STARTED'),
                ),
                const SizedBox(height: 24),

                OutlinedButton(
                  onPressed: () {
                    // Navigator.of(context).pushReplacementNamed('/login');
                    Navigator.of(
                      context,
                    ).push(SlideRightToLeftRoute(page: const LoginPage()));
                    return;
                  },
                  child: const Text('I ALREADY HAVE AN ACCOUNT'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
