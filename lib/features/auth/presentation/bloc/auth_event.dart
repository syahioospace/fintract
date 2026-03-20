abstract class AuthEvent {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

//What this is:
//  Events are inputs to the Bloc — things that happen in the UI. The user taps "Login" → LoginRequested is added to the Bloc.
//  The Bloc reacts and emits a new state.

//  Think of it as: Events = user intentions, States = app reactions.
