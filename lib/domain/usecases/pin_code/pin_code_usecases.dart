import '../../interfaces/pin_code_datasource.dart';

class PinCodeUseCases {
  final PinCodeDataSource _dataSource;

  PinCodeUseCases(this._dataSource);

  Future<bool> checkPinExists() async {
    final pinCode = await _dataSource.getPinCode();
    return pinCode != null && pinCode.isNotEmpty;
  }

  Future<void> savePinCode(String pinCode) async {
    if (pinCode.length < 4) {
      throw ArgumentError('PIN-код должен содержать минимум 4 цифры');
    }

    await _dataSource.savePinCode(pinCode);
  }

  Future<bool> verifyPinCode(String pinCode) async {
    final storedPinCode = await _dataSource.getPinCode();
    
    if (storedPinCode == null || storedPinCode.isEmpty) {
      return false;
    }

    return storedPinCode == pinCode;
  }

  Future<void> deletePinCode() async {
    await _dataSource.deletePinCode();
  }
}
