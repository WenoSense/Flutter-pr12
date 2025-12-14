import 'package:mobx/mobx.dart';
import '../../../../domain/models/payment.dart';
import '../../../../domain/usecases/payment/delete_payment_usecase.dart';
import '../../../../domain/usecases/payment/get_all_payments_usecase.dart';
import '../../../../domain/usecases/payment/mark_payment_paid_usecase.dart';
import '../../../../domain/usecases/filters/get_selected_category_usecase.dart';
import '../../../../domain/usecases/filters/save_selected_category_usecase.dart';
import '../../../../domain/usecases/filters/get_selected_sort_usecase.dart';
import '../../../../domain/usecases/filters/save_selected_sort_usecase.dart';

part 'payments_store.g.dart';

class PaymentsStore = _PaymentsStore with _$PaymentsStore;

abstract class _PaymentsStore with Store {
  final GetAllPaymentsUseCase _getAllPaymentsUseCase;
  final MarkPaymentPaidUseCase _markPaymentPaidUseCase;
  final DeletePaymentUseCase _deletePaymentUseCase;
  final GetSelectedCategoryUseCase _getSelectedCategoryUseCase;
  final SaveSelectedCategoryUseCase _saveSelectedCategoryUseCase;
  final GetSelectedSortUseCase _getSelectedSortUseCase;
  final SaveSelectedSortUseCase _saveSelectedSortUseCase;

  _PaymentsStore(
    this._getAllPaymentsUseCase,
    this._markPaymentPaidUseCase,
    this._deletePaymentUseCase,
    this._getSelectedCategoryUseCase,
    this._saveSelectedCategoryUseCase,
    this._getSelectedSortUseCase,
    this._saveSelectedSortUseCase,
  ) {
    _initializePreferences();
    loadPayments();
  }

  Future<void> _initializePreferences() async {
    final savedCategory = await _getSelectedCategoryUseCase.execute();
    final savedSortString = await _getSelectedSortUseCase.execute();
    
    selectedCategory = savedCategory;
    selectedSort = _sortTypeFromString(savedSortString);
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
  Future<void> setCategory(String category) async {
    selectedCategory = category;
    await _saveSelectedCategoryUseCase.execute(category);
    _applyFiltersAndSort();
  }

  @action
  Future<void> setSort(SortType sort) async {
    selectedSort = sort;
    await _saveSelectedSortUseCase.execute(_sortTypeToString(sort));
    _applyFiltersAndSort();
  }

  String _sortTypeToString(SortType sortType) {
    return sortType.name;
  }

  SortType _sortTypeFromString(String sortString) {
    return SortType.values.firstWhere(
      (e) => e.name == sortString,
      orElse: () => SortType.byDate,
    );
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
