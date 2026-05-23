enum TransactionType {
  income,
  expense,
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final String category;
  final TransactionType type;
  final DateTime date;
  final String? notes;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category,
      'type': type.index,
      'date': date.toIso8601String(),
      'notes': notes,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      amount: (map['amount'] as num).toDouble(),
      category: map['category'] ?? 'Other',
      type: TransactionType.values[map['type'] ?? 1],
      date: DateTime.parse(map['date']),
      notes: map['notes'],
    );
  }
}
