import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class UpdateTransactionParams {
  final Transaction transaction;
  const UpdateTransactionParams(this.transaction);
}

@injectable
class UpdateTransactionUseCase
    extends UseCase<Transaction, UpdateTransactionParams> {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(UpdateTransactionParams params) {
    return repository.updateTransaction(params.transaction);
  }
}
