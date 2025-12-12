class Payment {
  final String id;
  final String name;
  final String category;
  final double amount;
  final DateTime nextPaymentDate;
  final PaymentPeriodicity periodicity;
  final bool isPaid;

  Payment({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.nextPaymentDate,
    required this.periodicity,
    this.isPaid = false,
  });

  Payment copyWith({
    String? id,
    String? name,
    String? category,
    double? amount,
    DateTime? nextPaymentDate,
    PaymentPeriodicity? periodicity,
    bool? isPaid,
  }) {
    return Payment(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      nextPaymentDate: nextPaymentDate ?? this.nextPaymentDate,
      periodicity: periodicity ?? this.periodicity,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  DateTime getNextPaymentDate() {
    switch (periodicity) {
      case PaymentPeriodicity.weekly:
        return nextPaymentDate.add(const Duration(days: 7));
      case PaymentPeriodicity.monthly:
        return DateTime(
          nextPaymentDate.year,
          nextPaymentDate.month + 1,
          nextPaymentDate.day,
        );
      case PaymentPeriodicity.yearly:
        return DateTime(
          nextPaymentDate.year + 1,
          nextPaymentDate.month,
          nextPaymentDate.day,
        );
    }
  }

  @override
  String toString() {
    return 'Payment(id: $id, name: $name, category: $category, amount: $amount, nextPaymentDate: $nextPaymentDate, periodicity: $periodicity, isPaid: $isPaid)';
  }
}

enum PaymentPeriodicity {
  weekly('Еженедельно'),
  monthly('Ежемесячно'),
  yearly('Ежегодно');

  final String displayName;
  const PaymentPeriodicity(this.displayName);
}

