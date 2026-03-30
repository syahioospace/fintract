import '../../../transactions/domain/entities/transaction.dart';

class Budget {
  final Category category;
  final double limit;

  const Budget({required this.category, required this.limit});
}
