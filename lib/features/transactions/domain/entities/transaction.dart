enum TransactionType { income, expense }

enum Category { food, transport, salary, entertainment, health, other }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final Category category;
  final String? note;

  const Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
    this.note,
  });
}

//What this is:
//  The core business object. TransactionType separates income from expense — we'll use this for balance
//  calculations later. note is optional, hence nullable.
