import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'app_router.dart';
import 'data/datasources/payment_local_datasource.dart';
import 'domain/usecases/delete_payment_usecase.dart';
import 'domain/usecases/get_all_payments_usecase.dart';
import 'domain/usecases/mark_payment_paid_usecase.dart';
import 'ui/features/payments/stores/payments_store.dart';

void main() {
  final dataSource = PaymentLocalDataSource();
  
  GetIt.I.registerSingleton<PaymentLocalDataSource>(dataSource);
  
  final paymentsStore = PaymentsStore(
    GetAllPaymentsUseCase(dataSource),
    MarkPaymentPaidUseCase(dataSource),
    DeletePaymentUseCase(dataSource),
  );
  GetIt.I.registerSingleton<PaymentsStore>(paymentsStore);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Регулярные платежи',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
