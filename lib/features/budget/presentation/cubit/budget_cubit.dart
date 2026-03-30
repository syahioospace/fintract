import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/budget.dart';
import '../../domain/usecases/get_budgets_usecase.dart';
import '../../domain/usecases/set_budget_usecase.dart';
import '../../domain/usecases/delete_budget_usecase.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../../core/usecases/usecase.dart';

part 'budget_state.dart';

@injectable
class BudgetCubit extends Cubit<BudgetState> {
  final GetBudgetsUseCase getBudgetsUseCase;
  final SetBudgetUseCase setBudgetUseCase;
  final DeleteBudgetUseCase deleteBudgetUseCase;

  BudgetCubit({
    required this.getBudgetsUseCase,
    required this.setBudgetUseCase,
    required this.deleteBudgetUseCase,
  }) : super(const BudgetInitial());

  Future<void> loadBudgets() async {
    emit(const BudgetLoading());
    final result = await getBudgetsUseCase(const NoParams());
    result.fold(
      (failure) => emit(BudgetFailure(failure.message)),
      (budgets) => emit(BudgetLoaded(budgets)),
    );
  }

  Future<void> setBudget(Category category, double limit) async {
    await setBudgetUseCase(SetBudgetParams(category, limit));
    await loadBudgets();
  }

  Future<void> deleteBudget(Category category) async {
    await deleteBudgetUseCase(DeleteBudgetParams(category));
    await loadBudgets();
  }
}
