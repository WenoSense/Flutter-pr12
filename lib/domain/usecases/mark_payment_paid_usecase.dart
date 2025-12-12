import '../interfaces/payment_datasource.dart';
import '../models/payment.dart';

class MarkPaymentPaidUseCase {
  final PaymentDataSource _dataSource;

  MarkPaymentPaidUseCase(this._dataSource);

  Future<void> execute(Payment payment) async {
    final nextDate = payment.getNextPaymentDate();
    
    final updatedPayment = payment.copyWith(
      nextPaymentDate: nextDate,
      isPaid: false,
    );
    
    return await _dataSource.updatePayment(updatedPayment);
  }
}

