// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_payment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddPaymentStore on _AddPaymentStore, Store {
  late final _$nameAtom = Atom(name: '_AddPaymentStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$categoryAtom = Atom(
    name: '_AddPaymentStore.category',
    context: context,
  );

  @override
  String get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(String value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$amountAtom = Atom(
    name: '_AddPaymentStore.amount',
    context: context,
  );

  @override
  String get amount {
    _$amountAtom.reportRead();
    return super.amount;
  }

  @override
  set amount(String value) {
    _$amountAtom.reportWrite(value, super.amount, () {
      super.amount = value;
    });
  }

  late final _$nextPaymentDateAtom = Atom(
    name: '_AddPaymentStore.nextPaymentDate',
    context: context,
  );

  @override
  String get nextPaymentDate {
    _$nextPaymentDateAtom.reportRead();
    return super.nextPaymentDate;
  }

  @override
  set nextPaymentDate(String value) {
    _$nextPaymentDateAtom.reportWrite(value, super.nextPaymentDate, () {
      super.nextPaymentDate = value;
    });
  }

  late final _$periodicityAtom = Atom(
    name: '_AddPaymentStore.periodicity',
    context: context,
  );

  @override
  PaymentPeriodicity get periodicity {
    _$periodicityAtom.reportRead();
    return super.periodicity;
  }

  @override
  set periodicity(PaymentPeriodicity value) {
    _$periodicityAtom.reportWrite(value, super.periodicity, () {
      super.periodicity = value;
    });
  }

  late final _$isSavingAtom = Atom(
    name: '_AddPaymentStore.isSaving',
    context: context,
  );

  @override
  bool get isSaving {
    _$isSavingAtom.reportRead();
    return super.isSaving;
  }

  @override
  set isSaving(bool value) {
    _$isSavingAtom.reportWrite(value, super.isSaving, () {
      super.isSaving = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_AddPaymentStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$savePaymentAsyncAction = AsyncAction(
    '_AddPaymentStore.savePayment',
    context: context,
  );

  @override
  Future<bool> savePayment() {
    return _$savePaymentAsyncAction.run(() => super.savePayment());
  }

  late final _$_AddPaymentStoreActionController = ActionController(
    name: '_AddPaymentStore',
    context: context,
  );

  @override
  void setName(String value) {
    final _$actionInfo = _$_AddPaymentStoreActionController.startAction(
      name: '_AddPaymentStore.setName',
    );
    try {
      return super.setName(value);
    } finally {
      _$_AddPaymentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategory(String value) {
    final _$actionInfo = _$_AddPaymentStoreActionController.startAction(
      name: '_AddPaymentStore.setCategory',
    );
    try {
      return super.setCategory(value);
    } finally {
      _$_AddPaymentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmount(String value) {
    final _$actionInfo = _$_AddPaymentStoreActionController.startAction(
      name: '_AddPaymentStore.setAmount',
    );
    try {
      return super.setAmount(value);
    } finally {
      _$_AddPaymentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNextPaymentDate(String value) {
    final _$actionInfo = _$_AddPaymentStoreActionController.startAction(
      name: '_AddPaymentStore.setNextPaymentDate',
    );
    try {
      return super.setNextPaymentDate(value);
    } finally {
      _$_AddPaymentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPeriodicity(PaymentPeriodicity value) {
    final _$actionInfo = _$_AddPaymentStoreActionController.startAction(
      name: '_AddPaymentStore.setPeriodicity',
    );
    try {
      return super.setPeriodicity(value);
    } finally {
      _$_AddPaymentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _reset() {
    final _$actionInfo = _$_AddPaymentStoreActionController.startAction(
      name: '_AddPaymentStore._reset',
    );
    try {
      return super._reset();
    } finally {
      _$_AddPaymentStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
category: ${category},
amount: ${amount},
nextPaymentDate: ${nextPaymentDate},
periodicity: ${periodicity},
isSaving: ${isSaving},
errorMessage: ${errorMessage}
    ''';
  }
}
