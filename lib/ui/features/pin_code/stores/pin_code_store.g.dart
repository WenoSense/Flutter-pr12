// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_code_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PinCodeStore on _PinCodeStore, Store {
  late final _$isLoadingAtom = Atom(
    name: '_PinCodeStore.isLoading',
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

  late final _$errorMessageAtom = Atom(
    name: '_PinCodeStore.errorMessage',
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

  late final _$hasPinCodeAtom = Atom(
    name: '_PinCodeStore.hasPinCode',
    context: context,
  );

  @override
  bool get hasPinCode {
    _$hasPinCodeAtom.reportRead();
    return super.hasPinCode;
  }

  @override
  set hasPinCode(bool value) {
    _$hasPinCodeAtom.reportWrite(value, super.hasPinCode, () {
      super.hasPinCode = value;
    });
  }

  late final _$enteredPinAtom = Atom(
    name: '_PinCodeStore.enteredPin',
    context: context,
  );

  @override
  String get enteredPin {
    _$enteredPinAtom.reportRead();
    return super.enteredPin;
  }

  @override
  set enteredPin(String value) {
    _$enteredPinAtom.reportWrite(value, super.enteredPin, () {
      super.enteredPin = value;
    });
  }

  late final _$firstPinAtom = Atom(
    name: '_PinCodeStore.firstPin',
    context: context,
  );

  @override
  String get firstPin {
    _$firstPinAtom.reportRead();
    return super.firstPin;
  }

  @override
  set firstPin(String value) {
    _$firstPinAtom.reportWrite(value, super.firstPin, () {
      super.firstPin = value;
    });
  }

  late final _$isConfirmStepAtom = Atom(
    name: '_PinCodeStore.isConfirmStep',
    context: context,
  );

  @override
  bool get isConfirmStep {
    _$isConfirmStepAtom.reportRead();
    return super.isConfirmStep;
  }

  @override
  set isConfirmStep(bool value) {
    _$isConfirmStepAtom.reportWrite(value, super.isConfirmStep, () {
      super.isConfirmStep = value;
    });
  }

  late final _$checkPinCodeExistsAsyncAction = AsyncAction(
    '_PinCodeStore.checkPinCodeExists',
    context: context,
  );

  @override
  Future<void> checkPinCodeExists() {
    return _$checkPinCodeExistsAsyncAction.run(
      () => super.checkPinCodeExists(),
    );
  }

  late final _$savePinCodeAsyncAction = AsyncAction(
    '_PinCodeStore.savePinCode',
    context: context,
  );

  @override
  Future<bool> savePinCode(String pinCode) {
    return _$savePinCodeAsyncAction.run(() => super.savePinCode(pinCode));
  }

  late final _$verifyPinCodeAsyncAction = AsyncAction(
    '_PinCodeStore.verifyPinCode',
    context: context,
  );

  @override
  Future<bool> verifyPinCode(String pinCode) {
    return _$verifyPinCodeAsyncAction.run(() => super.verifyPinCode(pinCode));
  }

  late final _$deletePinCodeAsyncAction = AsyncAction(
    '_PinCodeStore.deletePinCode',
    context: context,
  );

  @override
  Future<void> deletePinCode() {
    return _$deletePinCodeAsyncAction.run(() => super.deletePinCode());
  }

  late final _$_PinCodeStoreActionController = ActionController(
    name: '_PinCodeStore',
    context: context,
  );

  @override
  void addDigit(String digit) {
    final _$actionInfo = _$_PinCodeStoreActionController.startAction(
      name: '_PinCodeStore.addDigit',
    );
    try {
      return super.addDigit(digit);
    } finally {
      _$_PinCodeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeLastDigit() {
    final _$actionInfo = _$_PinCodeStoreActionController.startAction(
      name: '_PinCodeStore.removeLastDigit',
    );
    try {
      return super.removeLastDigit();
    } finally {
      _$_PinCodeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearEnteredPin() {
    final _$actionInfo = _$_PinCodeStoreActionController.startAction(
      name: '_PinCodeStore.clearEnteredPin',
    );
    try {
      return super.clearEnteredPin();
    } finally {
      _$_PinCodeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirstPin(String pin) {
    final _$actionInfo = _$_PinCodeStoreActionController.startAction(
      name: '_PinCodeStore.setFirstPin',
    );
    try {
      return super.setFirstPin(pin);
    } finally {
      _$_PinCodeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetCreatePinFlow() {
    final _$actionInfo = _$_PinCodeStoreActionController.startAction(
      name: '_PinCodeStore.resetCreatePinFlow',
    );
    try {
      return super.resetCreatePinFlow();
    } finally {
      _$_PinCodeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initCreateMode() {
    final _$actionInfo = _$_PinCodeStoreActionController.startAction(
      name: '_PinCodeStore.initCreateMode',
    );
    try {
      return super.initCreateMode();
    } finally {
      _$_PinCodeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
hasPinCode: ${hasPinCode},
enteredPin: ${enteredPin},
firstPin: ${firstPin},
isConfirmStep: ${isConfirmStep}
    ''';
  }
}
