import 'package:injectable/injectable.dart';
import '../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> addTransaction(TransactionModel model);
  Future<void> deleteTransaction(String id);
}

@Injectable(as: TransactionLocalDataSource)
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final List<TransactionModel> _store = [
    TransactionModel(
      id: '1',
      title: 'Salary',
      amount: 5000,
      type: 'income',
      date: DateTime(2026, 3, 1),
    ),
    TransactionModel(
      id: '2',
      title: 'Rent',
      amount: 1200,
      type: 'expense',
      date: DateTime(2026, 3, 5),
    ),
    TransactionModel(
      id: '3',
      title: 'Groceries',
      amount: 300,
      type: 'expense',
      date: DateTime(2026, 3, 10),
    ),
  ];

  @override
  Future<List<TransactionModel>> getTransactions() async => List.from(_store);

  @override
  Future<TransactionModel> addTransaction(TransactionModel model) async {
    _store.add(model);
    return model;
  }

  @override
  Future<void> deleteTransaction(String id) async {
    _store.removeWhere((t) => t.id == id);
  }
}
