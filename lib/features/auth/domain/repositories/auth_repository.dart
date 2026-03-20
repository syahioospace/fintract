import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();
}

//What this is:
//This is just an interface — no implementation yet. The domain layer defines what auth can do, not how. The data layer will
//implement this later.

//This is the key to Clean Architecture: the domain doesn't know about Dio, databases, or APIs. It only knows about User and
//Failure.
