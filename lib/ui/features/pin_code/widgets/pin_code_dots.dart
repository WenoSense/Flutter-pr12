import 'package:flutter/material.dart';

class PinCodeDots extends StatelessWidget {
  final int pinLength;
  final int filledDots;
  final bool hasError;

  const PinCodeDots({
    super.key,
    required this.pinLength,
    required this.filledDots,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) {
        final isFilled = index < filledDots;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled
                  ? (hasError ? Colors.red : Colors.blue)
                  : Colors.transparent,
              border: Border.all(
                color: hasError ? Colors.red : Colors.blue,
                width: 2,
              ),
            ),
          ),
        );
      }),
    );
  }
}

