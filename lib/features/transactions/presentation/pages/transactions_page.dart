import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_event.dart';
import '../bloc/transaction_state.dart';
import '../../domain/entities/transaction.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionBloc>().add(const GetTransactionsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TransactionFailure) {
            return Center(child: Text(state.message));
          }
          if (state is TransactionLoaded) {
            if (state.transactions.isEmpty) {
              return const Center(child: Text('No transactions yet'));
            }
            return ListView.builder(
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final tx = state.transactions[index];
                return ListTile(
                  title: Text(tx.title),
                  subtitle: Text(tx.date.toLocal().toString().split(' ')[0]),
                  trailing: Text(
                    '${tx.type == TransactionType.income ? '+' : '-'} \$${tx.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: tx.type == TransactionType.income
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onLongPress: () => context.read<TransactionBloc>().add(
                    DeleteTransactionRequested(tx.id),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
