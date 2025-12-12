import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../stores/payments_store.dart';
import '../widgets/payment_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_row.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GetIt.I<PaymentsStore>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Регулярные платежи',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SearchBarWidget(
                onChanged: (query) => store.setSearchQuery(query),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Observer(
                builder: (_) => FilterRow(
                  selectedCategory: store.selectedCategory,
                  selectedSort: store.selectedSort,
                  categories: store.availableCategories,
                  onCategoryChanged: (category) => store.setCategory(category),
                  onSortChanged: (sort) => store.setSort(sort),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (store.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (store.filteredPayments.isEmpty) {
                    return Center(
                      child: Text(
                        'Платежи не найдены',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    );
                  }
                  return RefreshIndicator(
                    onRefresh: () => store.loadPayments(),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      itemCount: store.filteredPayments.length,
                      itemBuilder: (context, index) {
                        final payment = store.filteredPayments[index];
                        return PaymentCard(
                          payment: payment,
                          onCheckboxTap: () => store.togglePaymentPaid(payment),
                          onDelete: () => store.deletePayment(payment.id),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-payment');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
