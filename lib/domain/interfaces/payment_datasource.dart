import '../models/payment.dart';

abstract class PaymentDataSource {
  Future<List<Payment>> getAllPayments();

  Future<void> addPayment(Payment payment);

  Future<void> updatePayment(Payment payment);

  Future<void> deletePayment(String id);
}
