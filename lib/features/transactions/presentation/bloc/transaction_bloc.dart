import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_transactions_usecase.dart';
import '../../domain/usecases/add_transaction_usecase.dart';
import '../../domain/usecases/delete_transaction_usecase.dart';
import '../../../../core/usecases/usecase.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

@injectable
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUseCase getTransactionsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionBloc({
    required this.getTransactionsUseCase,
    required this.addTransactionUseCase,
    required this.deleteTransactionUseCase,
  }) : super(const TransactionInitial()) {
    on<GetTransactionsRequested>(_onGetTransactions);
    on<AddTransactionRequested>(_onAddTransaction);
    on<DeleteTransactionRequested>(_onDeleteTransaction);
  }

  Future<void> _onGetTransactions(
    GetTransactionsRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());
    final result = await getTransactionsUseCase(const NoParams());
    result.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (transactions) => emit(TransactionLoaded(transactions)),
    );
  }

  Future<void> _onAddTransaction(
    AddTransactionRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());
    final result = await addTransactionUseCase(
      AddTransactionParams(event.transaction),
    );
    result.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (_) => add(const GetTransactionsRequested()),
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionRequested event,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionLoading());
    final result = await deleteTransactionUseCase(
      DeleteTransactionParams(event.id),
    );
    result.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (_) => add(const GetTransactionsRequested()),
    );
  }
}
