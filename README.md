Step 5.8 — First Feature: Auth

  Here's what we'll build end to end:

  domain/
    entities/    → User entity
    repositories/ → AuthRepository interface
    usecases/    → LoginUseCase, RegisterUseCase

  data/
    models/      → UserModel (JSON serialization)
    datasources/ → AuthRemoteDataSource
    repositories/ → AuthRepositoryImpl

  presentation/
    bloc/        → AuthBloc + AuthState + AuthEvent
    pages/       → LoginPage, RegisterPage
    widgets/     → reusable form widgets

  We go domain first — the domain layer has zero dependencies on Flutter or any package. It's pure Dart.

=>  Now we move to the data layer. This is where the actual implementation lives — API calls, JSON parsing, and the repository
  implementation.

  First, we need freezed and json_serializable for model generation. Add to pubspec.yaml:

  dependencies:
    freezed_annotation: ^2.4.0
    json_annotation: ^4.9.0

  dev_dependencies:
    freezed: ^2.5.0
    json_serializable: ^6.8.0

  Then run:

  flutter pub get

  Why Freezed:
  freezed generates immutable model classes with copyWith, equality, and toString for free. Combined with json_serializable,
  you get full JSON serialization with minimal boilerplate.

=>  The entire data layer is now wired up. Now we move to the presentation layer — Bloc.

  We need to add the bloc package. Add to pubspec.yaml:

  dependencies:
    flutter_bloc: ^8.1.6

  Then run:

  flutter pub get

  Why flutter_bloc:
  flutter_bloc gives you Bloc and Cubit for state management. Bloc handles events → states (good for complex flows like
  auth). Cubit is simpler — just methods that emit states (good for UI-driven state like form visibility).

Step 5.9 — Transactions Feature

  Here's what we'll build:

  domain/
    entities/    → Transaction entity
    repositories/ → TransactionRepository interface
    usecases/    → GetTransactionsUseCase, AddTransactionUseCase, DeleteTransactionUseCase

  data/
    models/      → TransactionModel (freezed)
    datasources/ → TransactionRemoteDataSource
    repositories/ → TransactionRepositoryImpl

  presentation/
    bloc/        → TransactionBloc + State + Event
    pages/       → TransactionsPage, AddTransactionPage

