import 'package:go_router/go_router.dart';
import 'ui/features/payments/screens/add_payment_screen.dart';
import 'ui/features/payments/screens/payments_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/payments',
    routes: [
      GoRoute(
        path: '/payments',
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
}

