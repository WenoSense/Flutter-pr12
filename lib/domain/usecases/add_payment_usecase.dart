import '../interfaces/payment_datasource.dart';
import '../models/payment.dart';

class AddPaymentUseCase {
  final PaymentDataSource _dataSource;

  AddPaymentUseCase(this._dataSource);

  Future<void> execute(Payment payment) async {
    return await _dataSource.addPayment(payment);
  }
}

