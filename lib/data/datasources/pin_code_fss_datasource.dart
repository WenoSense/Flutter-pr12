import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/interfaces/pin_code_datasource.dart';

class PinCodeFSSDataSource implements PinCodeDataSource {
  static const String _pinCodeKey = 'user_pin_code';
  
  final FlutterSecureStorage _secureStorage;

  PinCodeFSSDataSource({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? _createSecureStorage();

  static FlutterSecureStorage _createSecureStorage() {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      wOptions: WindowsOptions(
        useBackwardCompatibility: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
  }

  @override
  Future<String?> getPinCode() async {
    return await _secureStorage.read(key: _pinCodeKey);
  }

  @override
  Future<void> savePinCode(String pinCode) async {
    await _secureStorage.write(key: _pinCodeKey, value: pinCode);
  }

  @override
  Future<void> deletePinCode() async {
    await _secureStorage.delete(key: _pinCodeKey);
  }
}

