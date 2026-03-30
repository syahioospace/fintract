import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/budget.dart';
import '../repositories/budget_repository.dart';

@injectable
class GetBudgetsUseCase extends UseCase<List<Budget>, NoParams> {
  final BudgetRepository repository;
  GetBudgetsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Budget>>> call(NoParams params) {
    return repository.getBudgets();
  }
}
