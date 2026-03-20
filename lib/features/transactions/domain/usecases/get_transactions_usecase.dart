import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

@injectable
class GetTransactionsUseCase extends UseCase<List<Transaction>, NoParams> {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) {
    return repository.getTransactions();
  }
}
