// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:fintrack/core/database/app_database.dart' as _i449;
import 'package:fintrack/core/di/register_module.dart' as _i246;
import 'package:fintrack/core/network/network_info.dart' as _i90;
import 'package:fintrack/core/router/auth_guard.dart' as _i866;
import 'package:fintrack/core/theme/theme_cubit.dart' as _i830;
import 'package:fintrack/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i88;
import 'package:fintrack/features/auth/data/repositories/auth_repository_impl.dart'
    as _i127;
import 'package:fintrack/features/auth/domain/repositories/auth_repository.dart'
    as _i960;
import 'package:fintrack/features/auth/domain/usecases/login_usecase.dart'
    as _i1044;
import 'package:fintrack/features/auth/domain/usecases/register_usecase.dart'
    as _i305;
import 'package:fintrack/features/auth/presentation/bloc/auth_bloc.dart'
    as _i619;
import 'package:fintrack/features/transactions/data/datasources/transaction_local_datasource.dart'
    as _i259;
import 'package:fintrack/features/transactions/data/datasources/transaction_remote_datasource.dart'
    as _i621;
import 'package:fintrack/features/transactions/data/repositories/transaction_repository_impl.dart'
    as _i172;
import 'package:fintrack/features/transactions/domain/repositories/transaction_repository.dart'
    as _i471;
import 'package:fintrack/features/transactions/domain/usecases/add_transaction_usecase.dart'
    as _i674;
import 'package:fintrack/features/transactions/domain/usecases/delete_transaction_usecase.dart'
    as _i700;
import 'package:fintrack/features/transactions/domain/usecases/get_transactions_usecase.dart'
    as _i1048;
import 'package:fintrack/features/transactions/domain/usecases/update_transaction_usecase.dart'
    as _i963;
import 'package:fintrack/features/transactions/presentation/bloc/transaction_bloc.dart'
    as _i747;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i830.ThemeCubit>(() => _i830.ThemeCubit());
    gh.singleton<_i449.AppDatabase>(() => _i449.AppDatabase());
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i90.NetworkInfo>(() => registerModule.networkInfo);
    gh.singleton<_i866.AuthNotifier>(() => registerModule.authNotifier);
    gh.factory<_i621.TransactionRemoteDataSource>(
      () => _i621.TransactionRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i88.AuthRemoteDataSource>(
      () => _i88.AuthRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.singleton<_i259.TransactionLocalDataSource>(
      () => _i259.TransactionLocalDataSourceImpl(gh<_i449.AppDatabase>()),
    );
    gh.factory<_i960.AuthRepository>(
      () => _i127.AuthRepositoryImpl(
        remoteDataSource: gh<_i88.AuthRemoteDataSource>(),
        networkInfo: gh<_i90.NetworkInfo>(),
      ),
    );
    gh.factory<_i471.TransactionRepository>(
      () => _i172.TransactionRepositoryImpl(
        localDataSource: gh<_i259.TransactionLocalDataSource>(),
      ),
    );
    gh.factory<_i305.RegisterUseCase>(
      () => _i305.RegisterUseCase(gh<_i960.AuthRepository>()),
    );
    gh.factory<_i1044.LoginUseCase>(
      () => _i1044.LoginUseCase(gh<_i960.AuthRepository>()),
    );
    gh.factory<_i619.AuthBloc>(
      () => _i619.AuthBloc(
        loginUseCase: gh<_i1044.LoginUseCase>(),
        registerUseCase: gh<_i305.RegisterUseCase>(),
      ),
    );
    gh.factory<_i1048.GetTransactionsUseCase>(
      () => _i1048.GetTransactionsUseCase(gh<_i471.TransactionRepository>()),
    );
    gh.factory<_i674.AddTransactionUseCase>(
      () => _i674.AddTransactionUseCase(gh<_i471.TransactionRepository>()),
    );
    gh.factory<_i700.DeleteTransactionUseCase>(
      () => _i700.DeleteTransactionUseCase(gh<_i471.TransactionRepository>()),
    );
    gh.factory<_i963.UpdateTransactionUseCase>(
      () => _i963.UpdateTransactionUseCase(gh<_i471.TransactionRepository>()),
    );
    gh.factory<_i747.TransactionBloc>(
      () => _i747.TransactionBloc(
        getTransactionsUseCase: gh<_i1048.GetTransactionsUseCase>(),
        addTransactionUseCase: gh<_i674.AddTransactionUseCase>(),
        deleteTransactionUseCase: gh<_i700.DeleteTransactionUseCase>(),
        updateTransactionUseCase: gh<_i963.UpdateTransactionUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i246.RegisterModule {}
