import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/budget.dart';
import '../../../transactions/domain/entities/transaction.dart';

abstract class BudgetRepository {
  Future<Either<Failure, List<Budget>>> getBudgets();
  Future<Either<Failure, void>> setBudget(Category category, double limit);
  Future<Either<Failure, void>> deleteBudget(Category category);
}
