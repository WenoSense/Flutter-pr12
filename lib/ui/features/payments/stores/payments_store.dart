import 'package:mobx/mobx.dart';
import '../../../../domain/models/payment.dart';
import '../../../../domain/usecases/delete_payment_usecase.dart';
import '../../../../domain/usecases/get_all_payments_usecase.dart';
import '../../../../domain/usecases/mark_payment_paid_usecase.dart';

part 'payments_store.g.dart';

class PaymentsStore = _PaymentsStore with _$PaymentsStore;

abstract class _PaymentsStore with Store {
  final GetAllPaymentsUseCase _getAllPaymentsUseCase;
  final MarkPaymentPaidUseCase _markPaymentPaidUseCase;
  final DeletePaymentUseCase _deletePaymentUseCase;

  _PaymentsStore(
    this._getAllPaymentsUseCase,
    this._markPaymentPaidUseCase,
    this._deletePaymentUseCase,
  ) {
    loadPayments();
  }

  final List<String> _categories = [
    'Транспорт',
    'Связь',
    'Коммунальные услуги',
    'Спорт',
    'Страхование',
    'Питание',
  ];

  @observable
  ObservableList<Payment> payments = ObservableList<Payment>();

  @observable
  ObservableList<Payment> filteredPayments = ObservableList<Payment>();

  @observable
  bool isLoading = false;

  @observable
  String searchQuery = '';

  @observable
  String selectedCategory = 'Все';

  @observable
  SortType selectedSort = SortType.byDate;

  @action
  Future<void> loadPayments() async {
    isLoading = true;
    try {
      final loadedPayments = await _getAllPaymentsUseCase.execute();
      payments.clear();
      payments.addAll(loadedPayments);
      _applyFiltersAndSort();
    } finally {
      isLoading = false;
    }
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
    _applyFiltersAndSort();
  }

  @action
  void setCategory(String category) {
    selectedCategory = category;
    _applyFiltersAndSort();
  }

  @action
  void setSort(SortType sort) {
    selectedSort = sort;
    _applyFiltersAndSort();
  }

  @action
  Future<void> togglePaymentPaid(Payment payment) async {
    await _markPaymentPaidUseCase.execute(payment);
    await loadPayments();
  }

  @action
  Future<void> deletePayment(String id) async {
    await _deletePaymentUseCase.execute(id);
    await loadPayments();
  }

  @action
  void _applyFiltersAndSort() {
    var result = List<Payment>.from(payments);

    if (searchQuery.isNotEmpty) {
      result = result
          .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    if (selectedCategory != 'Все') {
      result = result.where((p) => p.category == selectedCategory).toList();
    }

    switch (selectedSort) {
      case SortType.byDate:
        result.sort((a, b) => a.nextPaymentDate.compareTo(b.nextPaymentDate));
        break;
      case SortType.byAmount:
        result.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case SortType.byName:
        result.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    filteredPayments.clear();
    filteredPayments.addAll(result);
  }

  @computed
  List<String> get availableCategories {
    return ['Все', ..._categories];
  }
}

enum SortType {
  byDate('По дате'),
  byAmount('По сумме'),
  byName('По названию');

  final String displayName;
  const SortType(this.displayName);
}
