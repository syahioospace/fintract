import '../../domain/entities/budget.dart';
import '../../../transactions/domain/entities/transaction.dart';

class BudgetModel {
  final String category;
  final double limit;

  const BudgetModel({required this.category, required this.limit});

  Budget toEntity() => Budget(
    category: Category.values.firstWhere(
      (c) => c.name == category,
      orElse: () => Category.other,
    ),
    limit: limit,
  );
}
