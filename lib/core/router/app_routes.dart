part of 'app_router.dart';

abstract class AppRoutes {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const transactions = '/transactions';
  static const addTransaction = '/add-transaction';
  static const settings = '/settings';
}

//What this is:
//  - part of 'app_router.dart' — this file is a fragment of app_router.dart, so it shares the same scope. That's why appRouter can
//  reference AppRoutes.home without any import.
//  - All route path strings live here as constants. No magic strings scattered across the codebase — you always use AppRoutes.login
//  instead of '/login'.
