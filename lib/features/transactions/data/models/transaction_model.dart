import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String id,
    required String title,
    required double amount,
    required String type,
    required DateTime date,
    String? note,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}

extension TransactionModelX on TransactionModel {
  Transaction toEntity() => Transaction(
    id: id,
    title: title,
    amount: amount,
    type: type == 'income' ? TransactionType.income : TransactionType.expense,
    date: date,
    note: note,
  );
}

//What this is:
//  - type is a String in the model (raw API value) but maps to TransactionType enum in
//  the entity
//  - toEntity() handles that conversion — the domain layer always works with the enum,
//  never raw strings
