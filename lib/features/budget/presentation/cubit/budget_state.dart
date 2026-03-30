part of 'budget_cubit.dart';

abstract class BudgetState {
  const BudgetState();
}

class BudgetInitial extends BudgetState {
  const BudgetInitial();
}

class BudgetLoading extends BudgetState {
  const BudgetLoading();
}

class BudgetLoaded extends BudgetState {
  final List<Budget> budgets;
  const BudgetLoaded(this.budgets);
}

class BudgetFailure extends BudgetState {
  final String message;
  const BudgetFailure(this.message);
}
