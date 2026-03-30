import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/budget_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';

class SetBudgetParams {
  final Category category;
  final double limit;
  const SetBudgetParams(this.category, this.limit);
}

@injectable
class SetBudgetUseCase extends UseCase<void, SetBudgetParams> {
  final BudgetRepository repository;
  SetBudgetUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(SetBudgetParams params) {
    return repository.setBudget(params.category, params.limit);
  }
}
