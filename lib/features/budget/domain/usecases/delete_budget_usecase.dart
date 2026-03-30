import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/budget_repository.dart';
import '../../../transactions/domain/entities/transaction.dart';

class DeleteBudgetParams {
  final Category category;
  const DeleteBudgetParams(this.category);
}

@injectable
class DeleteBudgetUseCase extends UseCase<void, DeleteBudgetParams> {
  final BudgetRepository repository;
  DeleteBudgetUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteBudgetParams params) {
    return repository.deleteBudget(params.category);
  }
}
