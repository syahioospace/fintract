import '../../domain/entities/transaction.dart';

abstract class TransactionEvent {
  const TransactionEvent();
}

class GetTransactionsRequested extends TransactionEvent {
  const GetTransactionsRequested();
}

class AddTransactionRequested extends TransactionEvent {
  final Transaction transaction;
  const AddTransactionRequested(this.transaction);
}

class UpdateTransactionRequested extends TransactionEvent {
  final Transaction transaction;
  const UpdateTransactionRequested(this.transaction);
}

class DeleteTransactionRequested extends TransactionEvent {
  final String id;
  const DeleteTransactionRequested(this.id);
}
