import '../interfaces/payment_datasource.dart';

class DeletePaymentUseCase {
  final PaymentDataSource _dataSource;

  DeletePaymentUseCase(this._dataSource);

  Future<void> execute(String id) async {
    return await _dataSource.deletePayment(id);
  }
}

