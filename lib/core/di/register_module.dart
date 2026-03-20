import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../router/auth_guard.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio get dio => createDio();

  @singleton
  NetworkInfo get networkInfo => NetworkInfoImpl(dio);

  @singleton
  AuthNotifier get authNotifier => AuthNotifier();
}

// What this is:
//  @module is how injectable handles third-party classes it can't annotate directly — like Dio, which comes from an external package.
//   You create an abstract class with getters, annotate each one, and injectable treats them as registrations.

//  - @singleton — only one instance created for the app's lifetime
//  - dio getter — registers our configured Dio instance
//  - networkInfo getter — registers NetworkInfoImpl, injecting Dio automatically
