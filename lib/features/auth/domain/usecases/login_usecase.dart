import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}

@injectable
class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}

// What this is:
//- LoginParams — bundles the inputs for this use case
//- LoginUseCase extends UseCase<User, LoginParams> — returns Either<Failure, User>
//- It only calls the repository — no business logic here yet, but this is where you'd add it (e.g. validate email format before
//hitting the API)
//- @injectable — tells injectable to register this class in get_it automatically