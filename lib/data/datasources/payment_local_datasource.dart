import '../../domain/interfaces/payment_datasource.dart';
import '../../domain/models/payment.dart';
import '../dto/payment_dto.dart';

class PaymentLocalDataSource implements PaymentDataSource {
  final List<PaymentDTO> _payments = [];

  @override
  Future<List<Payment>> getAllPayments() async {
    return _payments.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<void> addPayment(Payment payment) async {
    _payments.add(PaymentDTO.fromDomain(payment));
  }

  @override
  Future<void> updatePayment(Payment payment) async {
    final index = _payments.indexWhere((p) => p.id == payment.id);
    if (index != -1) {
      _payments[index] = PaymentDTO.fromDomain(payment);
    }
  }

  @override
  Future<void> deletePayment(String id) async {
    _payments.removeWhere((p) => p.id == id);
  }
}
