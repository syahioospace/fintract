import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/database/app_database.dart';
import '../../../../../core/error/exceptions.dart';
import '../models/budget_model.dart';

abstract class BudgetLocalDataSource {
  Future<List<BudgetModel>> getBudgets();
  Future<void> setBudget(String category, double limit);
  Future<void> deleteBudget(String category);
}

@Singleton(as: BudgetLocalDataSource)
class BudgetLocalDataSourceImpl implements BudgetLocalDataSource {
  final AppDatabase db;

  BudgetLocalDataSourceImpl(this.db);

  @override
  Future<List<BudgetModel>> getBudgets() async {
    try {
      final rows = await db.select(db.budgetItems).get();
      return rows
          .map((r) => BudgetModel(category: r.category, limit: r.limitAmount))
          .toList();
    } catch (e) {
      throw const ServerException();
    }
  }

  @override
  Future<void> setBudget(String category, double limit) async {
    await db
        .into(db.budgetItems)
        .insertOnConflictUpdate(
          BudgetItemsCompanion(
            category: Value(category),
            limitAmount: Value(limit),
          ),
        );
  }

  @override
  Future<void> deleteBudget(String category) async {
    await (db.delete(
      db.budgetItems,
    )..where((t) => t.category.equals(category))).go();
  }
}
