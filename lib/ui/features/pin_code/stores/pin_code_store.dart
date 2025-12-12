import 'package:mobx/mobx.dart';
import '../../../../domain/usecases/pin_code/pin_code_usecases.dart';

part 'pin_code_store.g.dart';

class PinCodeStore = _PinCodeStore with _$PinCodeStore;

abstract class _PinCodeStore with Store {
  final PinCodeUseCases _pinCodeUseCases;

  _PinCodeStore(this._pinCodeUseCases);

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  bool hasPinCode = false;

  @observable
  String enteredPin = '';

  @observable
  String firstPin = '';

  @observable
  bool isConfirmStep = false;

  @action
  void addDigit(String digit) {
    if (enteredPin.length < 4) {
      enteredPin += digit;
      errorMessage = null;
    }
  }

  @action
  void removeLastDigit() {
    if (enteredPin.isNotEmpty) {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      errorMessage = null;
    }
  }

  @action
  void clearEnteredPin() {
    enteredPin = '';
    errorMessage = null;
  }

  @action
  void setFirstPin(String pin) {
    firstPin = pin;
    isConfirmStep = true;
  }

  @action
  void resetCreatePinFlow() {
    enteredPin = '';
    firstPin = '';
    isConfirmStep = false;
    errorMessage = null;
  }

  @action
  void initCreateMode() {
    resetCreatePinFlow();
  }

  @action
  Future<void> checkPinCodeExists() async {
    isLoading = true;
    try {
      hasPinCode = await _pinCodeUseCases.checkPinExists();
    } catch (e) {
      errorMessage = 'Ошибка при проверке PIN-кода: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> savePinCode(String pinCode) async {
    isLoading = true;
    errorMessage = null;

    try {
      await _pinCodeUseCases.savePinCode(pinCode);
      hasPinCode = true;
      resetCreatePinFlow();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Invalid argument(s): ', '');
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<bool> verifyPinCode(String pinCode) async {
    isLoading = true;
    errorMessage = null;

    try {
      final isValid = await _pinCodeUseCases.verifyPinCode(pinCode);
      if (!isValid) {
        errorMessage = 'Неверный PIN-код';
        clearEnteredPin();
      }
      return isValid;
    } catch (e) {
      errorMessage = 'Ошибка при проверке PIN-кода: $e';
      return false;
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deletePinCode() async {
    isLoading = true;
    errorMessage = null;

    try {
      await _pinCodeUseCases.deletePinCode();
      hasPinCode = false;
      clearEnteredPin();
    } catch (e) {
      errorMessage = 'Ошибка при удалении PIN-кода: $e';
    } finally {
      isLoading = false;
    }
  }
}

