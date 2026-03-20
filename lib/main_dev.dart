import 'package:flutter/material.dart';
import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.initialize(
    const AppConfig(
      environment: AppEnvironment.dev,
      apiBaseUrl: 'https://dev.api.fintrack.com',
      appName: 'FinTrack Dev',
      enableLoging: true,
    ),
  );

  await configureDependencies();
  runApp(const App());
}


//What changed:
//  - async + await configureDependencies() — DI setup happens before the app starts
//  - WidgetsFlutterBinding.ensureInitialized() — required whenever you do async work before runApp

