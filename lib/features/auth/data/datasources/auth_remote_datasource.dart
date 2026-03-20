//What this is:
//  - The data source makes the actual API calls using Dio
//  - It throws Exceptions (not Failures) — the repository will catch and convert them
//  - @Injectable(as: AuthRemoteDataSource) — registers the impl but binds it to the abstract interface, so when something asks for
//  AuthRemoteDataSource, it gets AuthRemoteDataSourceImpl
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data);
    } on DioException {
      throw const ServerException();
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data);
    } on DioException {
      throw const ServerException();
    }
  }
}
