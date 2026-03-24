import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
//import '../../../../core/network/network_info.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
//import '../datasources/transaction_remote_datasource.dart';
import '../datasources/transaction_local_datasource.dart';
import '../models/transaction_model.dart';

@Injectable(as: TransactionRepository)
class TransactionRepositoryImpl implements TransactionRepository {
  //final TransactionRemoteDataSource remoteDataSource;
  final TransactionLocalDataSource localDataSource;
  //final NetworkInfo networkInfo;

  TransactionRepositoryImpl({
    //required this.remoteDataSource,
    required this.localDataSource,
    //required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    //if (!await networkInfo.isConnected) {
    //  return const Left(NetworkFailure());
    //}
    try {
      //final models = await remoteDataSource.getTransactions();
      final models = await localDataSource.getTransactions();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Transaction>> addTransaction(
    Transaction transaction,
  ) async {
    //if (!await networkInfo.isConnected) {
    //  return const Left(NetworkFailure());
    //}
    try {
      //final model = await remoteDataSource.addTransaction({
      //final model = await localDataSource.addTransaction({
      //  'title': transaction.title,
      //  'amount': transaction.amount,
      //  'type': transaction.type.name,
      //  'date': transaction.date.toIso8601String(),
      //  'note': transaction.note,
      //});
      final model = await localDataSource.addTransaction(
        TransactionModel(
          id: transaction.id,
          title: transaction.title,
          amount: transaction.amount,
          type: transaction.type.name,
          date: transaction.date,
          note: transaction.note,
        ),
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String id) async {
    //if (!await networkInfo.isConnected) {
    //  return const Left(NetworkFailure());
    //}
    try {
      //await remoteDataSource.deleteTransaction(id);
      await localDataSource.deleteTransaction(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
