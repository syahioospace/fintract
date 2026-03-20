import '../../../../features/auth/domain/entities/user.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

//What this is:
//  States are the outputs of the Bloc — what the UI reacts to:
//  - AuthInitial — app just started, unknown auth status
//  - AuthLoading — waiting for API response
//  - AuthAuthenticated — login succeeded, holds the User
//  - AuthUnauthenticated — logged out or login failed
//  - AuthFailure — something went wrong, holds the error message

//  The UI rebuilds whenever the state changes.