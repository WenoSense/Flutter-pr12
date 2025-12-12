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
