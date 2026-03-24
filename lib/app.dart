import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/router/auth_guard.dart';
import 'features/transactions/presentation/bloc/transaction_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TransactionBloc>(),
      child: MaterialApp.router(
        title: 'FinTrack',
        debugShowCheckedModeBanner: false,
        routerConfig: createRouter(getIt<AuthNotifier>()),
      ),
    );
  }
}

// - MaterialApp → MaterialApp.router — this variant delegates navigation entirely to GoRouter
//  - routerConfig: appRouter — hands our router to Flutter's navigation system
//  - No more home: property — GoRouter's initialLocation handles that now
