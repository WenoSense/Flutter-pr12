import '../interfaces/payment_datasource.dart';
import '../models/payment.dart';

class GetAllPaymentsUseCase {
  final PaymentDataSource _dataSource;

  GetAllPaymentsUseCase(this._dataSource);

  Future<List<Payment>> execute() async {
    return await _dataSource.getAllPayments();
  }
}

