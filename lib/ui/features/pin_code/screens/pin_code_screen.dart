import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../stores/pin_code_store.dart';
import '../widgets/pin_code_dots.dart';
import '../widgets/pin_code_keyboard.dart';

enum PinCodeMode {
  create,
  verify,
}

class PinCodeScreen extends StatefulWidget {
  final PinCodeMode mode;

  const PinCodeScreen({
    super.key,
    required this.mode,
  });

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  late final PinCodeStore _store;

  @override
  void initState() {
    super.initState();
    _store = GetIt.I<PinCodeStore>();
    
    // Инициализация только для режима создания PIN
    if (_isCreateMode) {
      _store.initCreateMode();
    }
  }

  bool get _isCreateMode => widget.mode == PinCodeMode.create;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isCreateMode
          ? AppBar(
              title: const Text('Создание PIN-кода'),
              centerTitle: true,
            )
          : null,
      body: Observer(
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: _isCreateMode ? 40 : 80),
                      if (!_isCreateMode)
                        Icon(
                          Icons.lock_outline,
                          size: 80,
                          color: Theme.of(context).primaryColor,
                        ),
                      if (!_isCreateMode) const SizedBox(height: 40),
                      Text(
                        _getTitle(),
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      PinCodeDots(
                        pinLength: 4,
                        filledDots: _store.enteredPin.length,
                        hasError: _store.errorMessage != null,
                      ),
                      const SizedBox(height: 20),
                      if (_store.errorMessage != null)
                        Text(
                          _store.errorMessage!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      if (_store.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                  PinCodeKeyboard(
                    onNumberPressed: _onNumberPressed,
                    onDeletePressed: _onDeletePressed,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getTitle() {
    if (_isCreateMode) {
      return _store.isConfirmStep ? 'Повторите PIN-код' : 'Создайте PIN-код';
    }
    return 'Введите PIN-код';
  }

  void _onNumberPressed(String number) {
    if (_store.enteredPin.length < 4 && !_store.isLoading) {
      _store.addDigit(number);

      if (_store.enteredPin.length == 4) {
        _handlePinComplete();
      }
    }
  }

  void _onDeletePressed() {
    if (!_store.isLoading) {
      _store.removeLastDigit();
    }
  }

  Future<void> _handlePinComplete() async {
    if (_isCreateMode) {
      await _handleCreateMode();
    } else {
      await _handleVerifyMode();
    }
  }

  Future<void> _handleCreateMode() async {
    if (!_store.isConfirmStep) {
      // Первый ввод PIN-кода
      _store.setFirstPin(_store.enteredPin);
      _store.clearEnteredPin();
    } else {
      // Подтверждение PIN-кода
      final secondPin = _store.enteredPin;

      if (_store.firstPin == secondPin) {
        final success = await _store.savePinCode(_store.firstPin);
        if (success && mounted) {
          context.go('/payments');
        }
      } else {
        // PIN-коды не совпадают - начинаем заново
        _store.errorMessage = 'PIN-коды не совпадают';
        await Future.delayed(const Duration(seconds: 2));
        _store.resetCreatePinFlow();
      }
    }
  }

  Future<void> _handleVerifyMode() async {
    final isValid = await _store.verifyPinCode(_store.enteredPin);
    
    if (isValid && mounted) {
      context.go('/payments');
    } else {
      await Future.delayed(const Duration(milliseconds: 500));
      _store.clearEnteredPin();
    }
  }
}



