import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/budget.dart';
import '../../domain/repositories/budget_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../datasources/budget_local_datasource.dart';

@Injectable(as: BudgetRepository)
class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetLocalDataSource localDataSource;

  BudgetRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Budget>>> getBudgets() async {
    try {
      final models = await localDataSource.getBudgets();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> setBudget(
    Category category,
    double limit,
  ) async {
    try {
      await localDataSource.setBudget(category.name, limit);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBudget(Category category) async {
    try {
      await localDataSource.deleteBudget(category.name);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
