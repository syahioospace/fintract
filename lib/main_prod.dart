import 'package:flutter/material.dart';
import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.initialize(
    const AppConfig(
      environment: AppEnvironment.prod,
      apiBaseUrl: 'https://api.fintrack.com',
      appName: 'FinTrack Staging',
      enableLoging: true,
    ),
  );

  await configureDependencies();
  runApp(const App());
}
