import 'package:flutter/material.dart';

class PinCodeKeyboard extends StatelessWidget {
  final Function(String) onNumberPressed;
  final VoidCallback? onDeletePressed;
  
  const PinCodeKeyboard({
    super.key,
    required this.onNumberPressed,
    this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 12),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 12),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 12),
        _buildRow(['', '0', 'delete']),
      ],
    );
  }

  Widget _buildRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        if (number.isEmpty) {
          return const SizedBox(width: 80, height: 80);
        }
        
        if (number == 'delete') {
          return _buildDeleteButton();
        }
        
        return _buildNumberButton(number);
      }).toList(),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      onTap: () => onNumberPressed(number),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue, width: 2),
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: onDeletePressed,
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.red.shade300, width: 2),
        ),
        child: Icon(
          Icons.backspace_outlined,
          color: Colors.red.shade400,
          size: 28,
        ),
      ),
    );
  }
}

