import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../../../data/datasources/payment_local_datasource.dart';
import '../../../../domain/models/payment.dart';
import '../../../../domain/usecases/add_payment_usecase.dart';
import '../stores/add_payment_store.dart';

class AddPaymentScreen extends StatelessWidget {
  const AddPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = GetIt.I<PaymentLocalDataSource>();
    
    final addUseCase = AddPaymentUseCase(dataSource);
    
    final store = AddPaymentStore(addUseCase);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Добавить платеж',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Observer(
                builder: (_) => _buildTextField(
                  label: 'Название',
                  hint: 'Например: Метро',
                  value: store.name,
                  onChanged: store.setName,
                ),
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (_) => _buildCategoryField(
                  label: 'Категория',
                  value: store.category,
                  categories: store.availableCategories,
                  onChanged: store.setCategory,
                ),
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (_) => _buildTextField(
                  label: 'Сумма (₽)',
                  hint: '0.00',
                  value: store.amount,
                  onChanged: store.setAmount,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (_) => _buildTextField(
                  label: 'Следующий платеж',
                  hint: 'ДД.ММ.ГГГГ',
                  value: store.nextPaymentDate,
                  onChanged: store.setNextPaymentDate,
                  keyboardType: TextInputType.datetime,
                ),
              ),
              const SizedBox(height: 16),
              Observer(
                builder: (_) => _buildPeriodicityField(
                  label: 'Периодичность',
                  value: store.periodicity,
                  onChanged: store.setPeriodicity,
                ),
              ),
              const SizedBox(height: 24),
              Observer(
                builder: (_) {
                  if (store.errorMessage != null) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        store.errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Observer(
                builder: (_) => ElevatedButton(
                  onPressed: store.isSaving
                      ? null
                      : () async {
                          final success = await store.savePayment();
                          if (success && context.mounted) {
                            context.go('/');
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: store.isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          'Добавить',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required String value,
    required Function(String) onChanged,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryField({
    required String label,
    required String value,
    required List<String> categories,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: value.isEmpty ? null : value,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            hint: const Text('Выберите категорию'),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            items: categories
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPeriodicityField({
    required String label,
    required PaymentPeriodicity value,
    required Function(PaymentPeriodicity) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<PaymentPeriodicity>(
            value: value,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            onChanged: (newValue) {
              if (newValue != null) {
                onChanged(newValue);
              }
            },
            items: PaymentPeriodicity.values
                .map((periodicity) => DropdownMenuItem(
                      value: periodicity,
                      child: Text(periodicity.displayName),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
