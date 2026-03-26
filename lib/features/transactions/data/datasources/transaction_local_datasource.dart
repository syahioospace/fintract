import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/app_database.dart';
import '../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> addTransaction(TransactionModel model);
  Future<TransactionModel> updateTransaction(TransactionModel model);
  Future<void> deleteTransaction(String id);
}

//@Injectable(as: TransactionLocalDataSource)
@Singleton(as: TransactionLocalDataSource)
class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  final AppDatabase db;

  TransactionLocalDataSourceImpl(this.db);

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final rows = await db.select(db.transactionItems).get();
    return rows
        .map(
          (row) => TransactionModel(
            id: row.id,
            title: row.title,
            amount: row.amount,
            type: row.type,
            date: row.date,
            note: row.note,
          ),
        )
        .toList();
  }

  @override
  Future<TransactionModel> addTransaction(TransactionModel model) async {
    await db
        .into(db.transactionItems)
        .insert(
          TransactionItemsCompanion(
            id: Value(model.id),
            title: Value(model.title),
            amount: Value(model.amount),
            type: Value(model.type),
            date: Value(model.date),
            note: Value(model.note),
          ),
        );
    return model;
  }

  @override
  Future<TransactionModel> updateTransaction(TransactionModel model) async {
    await (db.update(
      db.transactionItems,
    )..where((t) => t.id.equals(model.id))).write(
      TransactionItemsCompanion(
        title: Value(model.title),
        amount: Value(model.amount),
        type: Value(model.type),
        date: Value(model.date),
        note: Value(model.note),
      ),
    );
    return model;
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await (db.delete(db.transactionItems)..where((t) => t.id.equals(id))).go();
  }
}
