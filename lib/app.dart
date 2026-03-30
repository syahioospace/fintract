import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/router/auth_guard.dart';
import 'core/theme/theme_cubit.dart';
import 'features/transactions/presentation/bloc/transaction_bloc.dart';
import 'features/budget/presentation/cubit/budget_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<TransactionBloc>()),
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<BudgetCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'FinTrack',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            routerConfig: createRouter(getIt<AuthNotifier>()),
          );
        },
      ),
    );
  }
}

// - MaterialApp → MaterialApp.router — this variant delegates navigation entirely to GoRouter
//  - routerConfig: appRouter — hands our router to Flutter's navigation system
//  - No more home: property — GoRouter's initialLocation handles that now
