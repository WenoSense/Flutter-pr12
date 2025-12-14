import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'app_router.dart';
import 'data/datasources/payment_local_datasource.dart';
import 'data/datasources/filters_local_datasource.dart';
import 'domain/interfaces/payment_datasource.dart';
import 'domain/interfaces/filters_datasource.dart';
import 'domain/usecases/payment/delete_payment_usecase.dart';
import 'domain/usecases/payment/get_all_payments_usecase.dart';
import 'domain/usecases/payment/mark_payment_paid_usecase.dart';
import 'domain/usecases/filters/get_selected_category_usecase.dart';
import 'domain/usecases/filters/save_selected_category_usecase.dart';
import 'domain/usecases/filters/get_selected_sort_usecase.dart';
import 'domain/usecases/filters/save_selected_sort_usecase.dart';
import 'ui/features/payments/stores/payments_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  final paymentDataSource = PaymentLocalDataSource();
  GetIt.I.registerSingleton<PaymentDataSource>(paymentDataSource);

  final filtersDataSource = FiltersLocalDataSource();
  GetIt.I.registerSingleton<FiltersDataSource>(filtersDataSource);

  final getAllPaymentsUseCase = GetAllPaymentsUseCase(paymentDataSource);
  final markPaymentPaidUseCase = MarkPaymentPaidUseCase(paymentDataSource);
  final deletePaymentUseCase = DeletePaymentUseCase(paymentDataSource);
  
  final getSelectedCategoryUseCase = GetSelectedCategoryUseCase(filtersDataSource);
  final saveSelectedCategoryUseCase = SaveSelectedCategoryUseCase(filtersDataSource);
  final getSelectedSortUseCase = GetSelectedSortUseCase(filtersDataSource);
  final saveSelectedSortUseCase = SaveSelectedSortUseCase(filtersDataSource);
  
  final paymentsStore = PaymentsStore(
    getAllPaymentsUseCase,
    markPaymentPaidUseCase,
    deletePaymentUseCase,
    getSelectedCategoryUseCase,
    saveSelectedCategoryUseCase,
    getSelectedSortUseCase,
    saveSelectedSortUseCase,
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
      routerConfig: createRouter(),
    );
  }
}
