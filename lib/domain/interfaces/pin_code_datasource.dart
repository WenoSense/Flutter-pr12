abstract class PinCodeDataSource {
  Future<String?> getPinCode();

  Future<void> savePinCode(String pinCode);

  Future<void> deletePinCode();
}

