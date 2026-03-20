import '../../domain/entities/transaction.dart';

abstract class TransactionState {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionLoading extends TransactionState {
  const TransactionLoading();
}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  const TransactionLoaded(this.transactions);
}

class TransactionFailure extends TransactionState {
  final String message;
  const TransactionFailure(this.message);
}
