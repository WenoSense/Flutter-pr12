import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import '../../../../domain/models/payment.dart';
import '../../../../domain/usecases/add_payment_usecase.dart';
import 'payments_store.dart';

part 'add_payment_store.g.dart';

class AddPaymentStore = _AddPaymentStore with _$AddPaymentStore;

abstract class _AddPaymentStore with Store {
  final AddPaymentUseCase _addPaymentUseCase;

  _AddPaymentStore(this._addPaymentUseCase) {
    category = availableCategories.first;
  }

  final List<String> availableCategories = [
    'Транспорт',
    'Связь',
    'Коммунальные услуги',
    'Спорт',
    'Страхование',
    'Питание',
  ];

  @observable
  String name = '';

  @observable
  String category = '';

  @observable
  String amount = '';

  @observable
  String nextPaymentDate = '';

  @observable
  PaymentPeriodicity periodicity = PaymentPeriodicity.monthly;

  @observable
  bool isSaving = false;

  @observable
  String? errorMessage;

  @action
  void setName(String value) {
    name = value;
    errorMessage = null;
  }

  @action
  void setCategory(String value) {
    category = value;
    errorMessage = null;
  }

  @action
  void setAmount(String value) {
    amount = value;
    errorMessage = null;
  }

  @action
  void setNextPaymentDate(String value) {
    nextPaymentDate = value;
    errorMessage = null;
  }

  @action
  void setPeriodicity(PaymentPeriodicity value) {
    periodicity = value;
  }

  @action
  Future<bool> savePayment() async {
    if (!_validate()) {
      return false;
    }

    isSaving = true;
    errorMessage = null;

    try {
      final dateParts = nextPaymentDate.split('.');
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);
      final parsedDate = DateTime(year, month, day);

      final payment = Payment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        category: category,
        amount: double.parse(amount),
        nextPaymentDate: parsedDate,
        periodicity: periodicity,
      );

      await _addPaymentUseCase.execute(payment);
      
      GetIt.I<PaymentsStore>().loadPayments();
      
      _reset();
      return true;
    } catch (e) {
      errorMessage = 'Ошибка при сохранении: $e';
      return false;
    } finally {
      isSaving = false;
    }
  }

  bool _validate() {
    if (name.isEmpty) {
      errorMessage = 'Введите название платежа';
      return false;
    }

    if (category.isEmpty) {
      errorMessage = 'Выберите категорию';
      return false;
    }

    if (amount.isEmpty) {
      errorMessage = 'Введите сумму';
      return false;
    }

    final parsedAmount = double.tryParse(amount);
    if (parsedAmount == null || parsedAmount <= 0) {
      errorMessage = 'Введите корректную сумму';
      return false;
    }

    if (nextPaymentDate.isEmpty) {
      errorMessage = 'Введите дату платежа';
      return false;
    }

    final dateRegex = RegExp(r'^\d{2}\.\d{2}\.\d{4}$');
    if (!dateRegex.hasMatch(nextPaymentDate)) {
      errorMessage = 'Введите дату в формате ДД.ММ.ГГГГ';
      return false;
    }

    try {
      final dateParts = nextPaymentDate.split('.');
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      if (month < 1 || month > 12) {
        errorMessage = 'Некорректный месяц';
        return false;
      }

      if (day < 1 || day > 31) {
        errorMessage = 'Некорректный день';
        return false;
      }

      if (year < 2000 || year > 2100) {
        errorMessage = 'Некорректный год';
        return false;
      }

      DateTime(year, month, day);
    } catch (e) {
      errorMessage = 'Некорректная дата';
      return false;
    }

    return true;
  }

  @action
  void _reset() {
    name = '';
    category = availableCategories.first;
    amount = '';
    nextPaymentDate = '';
    periodicity = PaymentPeriodicity.monthly;
    errorMessage = null;
  }
}
