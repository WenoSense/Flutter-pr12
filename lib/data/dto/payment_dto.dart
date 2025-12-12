import '../../domain/models/payment.dart';

class PaymentDTO {
  final String id;
  final String name;
  final String category;
  final double amount;
  final DateTime nextPaymentDate;
  final PaymentPeriodicity periodicity;
  final bool isPaid;

  PaymentDTO({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.nextPaymentDate,
    required this.periodicity,
    this.isPaid = false,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'amount': amount,
      'nextPaymentDate': nextPaymentDate.millisecondsSinceEpoch,
      'periodicity': periodicity.name,
      'isPaid': isPaid ? 1 : 0,
    };
  }

  factory PaymentDTO.fromMap(Map<String, dynamic> map) {
    return PaymentDTO(
      id: map['id'] as String,
      name: map['name'] as String,
      category: map['category'] as String,
      amount: map['amount'] as double,
      nextPaymentDate: DateTime.fromMillisecondsSinceEpoch(map['nextPaymentDate'] as int),
      periodicity: PaymentPeriodicity.values.firstWhere(
            (e) => e.name == map['periodicity'],
      ),
      isPaid: map['isPaid'] == 1,
    );
  }

  Payment toDomain() {
    return Payment(
      id: id,
      name: name,
      category: category,
      amount: amount,
      nextPaymentDate: nextPaymentDate,
      periodicity: periodicity,
      isPaid: isPaid,
    );
  }

  factory PaymentDTO.fromDomain(Payment payment) {
    return PaymentDTO(
      id: payment.id,
      name: payment.name,
      category: payment.category,
      amount: payment.amount,
      nextPaymentDate: payment.nextPaymentDate,
      periodicity: payment.periodicity,
      isPaid: payment.isPaid,
    );
  }

}
