import 'package:go_router/go_router.dart';
import 'ui/features/payments/screens/add_payment_screen.dart';
import 'ui/features/payments/screens/payments_screen.dart';
import 'ui/features/pin_code/screens/pin_code_screen.dart';

GoRouter createRouter(bool hasPinCode) {
  return GoRouter(
    initialLocation: hasPinCode ? '/pin-verify' : '/pin-create',
    routes: [
      GoRoute(
        path: '/pin-create',
        name: 'pin-create',
        builder: (context, state) => const PinCodeScreen(
          mode: PinCodeMode.create,
        ),
      ),
      GoRoute(
        path: '/pin-verify',
        name: 'pin-verify',
        builder: (context, state) => const PinCodeScreen(
          mode: PinCodeMode.verify,
        ),
      ),
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

