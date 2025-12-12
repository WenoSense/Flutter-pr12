import 'package:go_router/go_router.dart';
import 'ui/features/payments/screens/add_payment_screen.dart';
import 'ui/features/payments/screens/payments_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'payments',
      builder: (context, state) => const PaymentsScreen(),
    ),
    GoRoute(
      path: '/add-payment',
      name: 'add-payment',
      builder: (context, state) => const AddPaymentScreen(),
    ),
  ],
);
