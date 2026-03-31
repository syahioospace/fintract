import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/router/auth_guard.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../../../transactions/presentation/bloc/transaction_bloc.dart';
import '../../../transactions/presentation/bloc/transaction_event.dart';
import '../../../transactions/presentation/bloc/transaction_state.dart';
import '../../../budget/presentation/cubit/budget_cubit.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/di/injection.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(const GetTransactionsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => context.read<ThemeCubit>().toggle(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => getIt<AuthNotifier>().logout(),
          ),
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () => context.push(AppRoutes.budget),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: () => context.push(AppRoutes.addTransaction),
        onPressed: () async {
          final bloc = context.read<TransactionBloc>();
          await context.push(AppRoutes.addTransaction);
          if (mounted) {
            bloc.add(const GetTransactionsRequested());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TransactionFailure) {
            return Center(child: Text(state.message));
          }
          if (state is TransactionLoaded) {
            return _DashboardContent(transactions: state.transactions);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _DashboardContent extends StatefulWidget {
  const _DashboardContent({required this.transactions});

  final List<Transaction> transactions;

  @override
  State<_DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<_DashboardContent> {
  @override
  void initState() {
    super.initState();
    context.read<BudgetCubit>().loadBudgets();
  }

  Category? _selectedCategory;

  double get _totalIncome => widget.transactions
      .where((t) => t.type == TransactionType.income)
      .fold(0, (sum, t) => sum + t.amount);

  double get _totalExpense => widget.transactions
      .where((t) => t.type == TransactionType.expense)
      .fold(0, (sum, t) => sum + t.amount);

  double get _balance => _totalIncome - _totalExpense;

  List<Transaction> get _filtered => _selectedCategory == null
      ? widget.transactions
      : widget.transactions
            .where((t) => t.category == _selectedCategory)
            .toList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _BalanceCard(balance: _balance),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _SummaryCard(
                label: 'Income',
                amount: _totalIncome,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _SummaryCard(
                label: 'Expenses',
                amount: _totalExpense,
                color: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Recent Transactions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: _selectedCategory == null,
                onSelected: (_) => setState(() => _selectedCategory = null),
              ),
              const SizedBox(width: 8),
              ...Category.values.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(c.name),
                    selected: _selectedCategory == c,
                    onSelected: (_) => setState(() => _selectedCategory = c),
                  ),
                ),
              ),
            ]
          )
        ),
        const SizedBox(height: 16),
        BlocBuilder<BudgetCubit, BudgetState>(
          builder: (context, budgetState) {
            if (budgetState is! BudgetLoaded) return const SizedBox.shrink();
            if (budgetState.budgets.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Budget progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ...budgetState.budgets.map((budget) {
                  final spent = widget.transactions.where((t) => t.category == budget.category && t.type == TransactionType.expense).fold(0.0, (sum, t) => sum + t.amount);
                  final progress = (spent / budget.limit).clamp(0.0, 1.0);
                  final isOver = spent > budget.limit;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(budget.category.name),
                            Text(
                              '\$${spent.toStringAsFixed(0)} /\$${budget.limit.toStringAsFixed(0)}',
                              style: TextStyle(color: isOver ? Colors.red: null),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: progress,
                          color: isOver ? Colors.red : Colors.green,
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ],
                    ),
                  );
                }),
              ],
            );
          },
        ),
        const SizedBox(height: 8),
        if (_filtered.isEmpty)
          const Center(child: Text('No transactions yet.'))
        else
          ..._filtered.map(
            (t) => Dismissible(
              key: Key(t.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                context.read<TransactionBloc>().add(
                  DeleteTransactionRequested(t.id),
                );
              },
              child: GestureDetector(
                onTap: () => context.push(AppRoutes.editTransaction, extra: t),
                child: _TransactionTile(transaction: t),
              ),
            ),
          ),
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.balance});

  final double balance;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Total Balance',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${balance.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isIncome ? Colors.green.shade100 : Colors.red.shade100,
        child: Icon(
          isIncome ? Icons.arrow_downward : Icons.arrow_upward,
          color: isIncome ? Colors.green : Colors.red,
        ),
      ),
      title: Text(transaction.title),
      //subtitle: Text(transaction.date.toLocal().toString().split(' ')[0]),
      subtitle: Text(
        '${transaction.date.toLocal().toString().split(' ')[0]} · ${transaction.category.name}',
      ),
      trailing: Text(
        '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
