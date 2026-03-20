import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class AddTransactionParams {
  final Transaction transaction;
  const AddTransactionParams(this.transaction);
}

@injectable
class AddTransactionUseCase extends UseCase<Transaction, AddTransactionParams> {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, Transaction>> call(AddTransactionParams params) {
    return repository.addTransaction(params.transaction);
  }
}
