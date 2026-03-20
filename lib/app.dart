import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/router/auth_guard.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FinTrack',
      debugShowCheckedModeBanner: false,
      routerConfig: createRouter(getIt<AuthNotifier>()),
    );
  }
}

// - MaterialApp → MaterialApp.router — this variant delegates navigation entirely to GoRouter
//  - routerConfig: appRouter — hands our router to Flutter's navigation system
//  - No more home: property — GoRouter's initialLocation handles that now
