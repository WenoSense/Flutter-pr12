// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaymentsStore on _PaymentsStore, Store {
  Computed<List<String>>? _$availableCategoriesComputed;

  @override
  List<String> get availableCategories =>
      (_$availableCategoriesComputed ??= Computed<List<String>>(
        () => super.availableCategories,
        name: '_PaymentsStore.availableCategories',
      )).value;

  late final _$paymentsAtom = Atom(
    name: '_PaymentsStore.payments',
    context: context,
  );

  @override
  ObservableList<Payment> get payments {
    _$paymentsAtom.reportRead();
    return super.payments;
  }

  @override
  set payments(ObservableList<Payment> value) {
    _$paymentsAtom.reportWrite(value, super.payments, () {
      super.payments = value;
    });
  }

  late final _$filteredPaymentsAtom = Atom(
    name: '_PaymentsStore.filteredPayments',
    context: context,
  );

  @override
  ObservableList<Payment> get filteredPayments {
    _$filteredPaymentsAtom.reportRead();
    return super.filteredPayments;
  }

  @override
  set filteredPayments(ObservableList<Payment> value) {
    _$filteredPaymentsAtom.reportWrite(value, super.filteredPayments, () {
      super.filteredPayments = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PaymentsStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_PaymentsStore.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$selectedCategoryAtom = Atom(
    name: '_PaymentsStore.selectedCategory',
    context: context,
  );

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$selectedSortAtom = Atom(
    name: '_PaymentsStore.selectedSort',
    context: context,
  );

  @override
  SortType get selectedSort {
    _$selectedSortAtom.reportRead();
    return super.selectedSort;
  }

  @override
  set selectedSort(SortType value) {
    _$selectedSortAtom.reportWrite(value, super.selectedSort, () {
      super.selectedSort = value;
    });
  }

  late final _$loadPaymentsAsyncAction = AsyncAction(
    '_PaymentsStore.loadPayments',
    context: context,
  );

  @override
  Future<void> loadPayments() {
    return _$loadPaymentsAsyncAction.run(() => super.loadPayments());
  }

  late final _$togglePaymentPaidAsyncAction = AsyncAction(
    '_PaymentsStore.togglePaymentPaid',
    context: context,
  );

  @override
  Future<void> togglePaymentPaid(Payment payment) {
    return _$togglePaymentPaidAsyncAction.run(
      () => super.togglePaymentPaid(payment),
    );
  }

  late final _$deletePaymentAsyncAction = AsyncAction(
    '_PaymentsStore.deletePayment',
    context: context,
  );

  @override
  Future<void> deletePayment(String id) {
    return _$deletePaymentAsyncAction.run(() => super.deletePayment(id));
  }

  late final _$_PaymentsStoreActionController = ActionController(
    name: '_PaymentsStore',
    context: context,
  );

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_PaymentsStoreActionController.startAction(
      name: '_PaymentsStore.setSearchQuery',
    );
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_PaymentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(String category) {
    final _$actionInfo = _$_PaymentsStoreActionController.startAction(
      name: '_PaymentsStore.setCategory',
    );
    try {
      return super.setCategory(category);
    } finally {
      _$_PaymentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSort(SortType sort) {
    final _$actionInfo = _$_PaymentsStoreActionController.startAction(
      name: '_PaymentsStore.setSort',
    );
    try {
      return super.setSort(sort);
    } finally {
      _$_PaymentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _applyFiltersAndSort() {
    final _$actionInfo = _$_PaymentsStoreActionController.startAction(
      name: '_PaymentsStore._applyFiltersAndSort',
    );
    try {
      return super._applyFiltersAndSort();
    } finally {
      _$_PaymentsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
payments: ${payments},
filteredPayments: ${filteredPayments},
isLoading: ${isLoading},
searchQuery: ${searchQuery},
selectedCategory: ${selectedCategory},
selectedSort: ${selectedSort},
availableCategories: ${availableCategories}
    ''';
  }
}
