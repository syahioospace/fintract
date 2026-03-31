import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../transactions/domain/entities/transaction.dart';
import '../cubit/budget_cubit.dart';
import '../../domain/entities/budget.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  void initState() {
    super.initState();
    context.read<BudgetCubit>().loadBudgets();
  }

  void _showSetBudgetDialog(BuildContext context, Category category) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Set budget for ${category.name}'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Monthly limit'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = double.tryParse(controller.text.trim());
              if (value != null && value > 0) {
                context.read<BudgetCubit>().setBudget(category, value);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budgets')),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state is BudgetLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BudgetFailure) {
            return Center(child: Text(state.message));
          }
          if (state is BudgetLoaded) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: Category.values.map((category) {
                final budget = state.budgets
                    .where((b) => b.category == category)
                    .firstOrNull;
                return _BudgetTile(
                  category: category,
                  budget: budget,
                  onTap: () => _showSetBudgetDialog(context, category),
                  onDelete: budget != null
                      ? () => context.read<BudgetCubit>().deleteBudget(category)
                      : null,
                );
              }).toList(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _BudgetTile extends StatelessWidget {
  const _BudgetTile({
    required this.category,
    required this.budget,
    required this.onTap,
    this.onDelete,
  });

  final Category category;
  //final dynamic budget;
  final Budget? budget;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(category.name),
        subtitle: budget != null
            ? Text('Limit: \$${budget?.limit.toStringAsFixed(2)}')
            : const Text('No budget set'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onTap,
            ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onDelete,
              ),
          ]
        )
      ),
    );
  }
}
