import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/transactions/presentation/bloc/transaction_bloc.dart';

import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/transactions/presentation/pages/add_transaction_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

import '../../features/auth/presentation/bloc/auth_state.dart';
import '../di/injection.dart';
import 'auth_guard.dart';

part 'app_routes.dart';

GoRouter createRouter(AuthNotifier authNotifier) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final isAuthenticated = authNotifier.isAuthenticated;
      final isOnLogin = state.matchedLocation == AppRoutes.login;

      if (!isAuthenticated && !isOnLogin) return AppRoutes.login;
      if (isAuthenticated && isOnLogin) return AppRoutes.dashboard;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, authState) {
              if (authState is AuthAuthenticated) {
                getIt<AuthNotifier>().setAuthenticated(true);
              }
            },
            child: const LoginPage(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home'))),
      ),
      GoRoute(
        path: AppRoutes.transactions,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<TransactionBloc>(),
          child: const TransactionsPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.addTransaction,
        //builder: (context, state) => BlocProvider(
        //  create: (_) => getIt<TransactionBloc>(),
        //  child: const AddTransactionPage(),
        //)
        builder: (context, state) => const AddTransactionPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        //builder: (context, state) => BlocProvider(
        //  create: (_) => getIt<TransactionBloc>(),
        //  child: const DashboardPage(),
        //)
        builder: (context, state) => const DashboardPage(),
      )
    ],
  );
}

// What this is:
//  - appRouter is your single router instance for the whole app
//  - initialLocation — where the app starts
//  - debugLogDiagnostics — logs navigation events in debug mode
//  - part 'app_routes.dart' — route path constants will live in a separate file, linked via part/part of

//What changed:
//  - initialLocation → AppRoutes.login so the app starts on the login screen
//  - BlocProvider wraps LoginPage — it creates AuthBloc from getIt and provides it down the widget tree
//  - This is how Bloc instances are scoped to routes

//What changed:
//  - appRouter → createRouter(AuthNotifier authNotifier) — router is now a function
//  that takes the notifier
//  - refreshListenable: authNotifier — GoRouter re-evaluates redirects when
//  AuthNotifier notifies
//  - redirect callback — unauthenticated users go to login, authenticated users on
//  login go to transactions
