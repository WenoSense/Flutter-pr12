import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app_router.dart';
import 'data/datasources/payment_local_datasource.dart';
import 'data/datasources/pin_code_fss_datasource.dart';
import 'domain/interfaces/pin_code_datasource.dart';
import 'domain/usecases/pin_code/pin_code_usecases.dart';
import 'domain/usecases/payment/delete_payment_usecase.dart';
import 'domain/usecases/payment/get_all_payments_usecase.dart';
import 'domain/usecases/payment/mark_payment_paid_usecase.dart';
import 'ui/features/payments/stores/payments_store.dart';
import 'ui/features/pin_code/stores/pin_code_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  final pinCodeDataSource = PinCodeFSSDataSource();
  GetIt.I.registerSingleton<PinCodeDataSource>(pinCodeDataSource);

  final paymentDataSource = PaymentLocalDataSource();
  GetIt.I.registerSingleton<PaymentLocalDataSource>(paymentDataSource);

  final pinCodeUseCases = PinCodeUseCases(pinCodeDataSource);

  final getAllPaymentsUseCase = GetAllPaymentsUseCase(paymentDataSource);
  final markPaymentPaidUseCase = MarkPaymentPaidUseCase(paymentDataSource);
  final deletePaymentUseCase = DeletePaymentUseCase(paymentDataSource);

  final pinCodeStore = PinCodeStore(pinCodeUseCases);
  GetIt.I.registerSingleton<PinCodeStore>(pinCodeStore);
  
  final paymentsStore = PaymentsStore(
    getAllPaymentsUseCase,
    markPaymentPaidUseCase,
    deletePaymentUseCase,
  );
  GetIt.I.registerSingleton<PaymentsStore>(paymentsStore);

  await pinCodeStore.checkPinCodeExists();

  runApp(MyApp(hasPinCode: pinCodeStore.hasPinCode));
}

class MyApp extends StatelessWidget {
  final bool hasPinCode;

  const MyApp({super.key, required this.hasPinCode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Регулярные платежи',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: createRouter(hasPinCode),
    );
  }
}
