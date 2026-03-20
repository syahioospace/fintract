import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/transaction_repository.dart';

class DeleteTransactionParams {
  final String id;
  const DeleteTransactionParams(this.id);
}

@injectable
class DeleteTransactionUseCase extends UseCase<void, DeleteTransactionParams> {
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTransactionParams params) {
    return repository.deleteTransaction(params.id);
  }
}
