import 'package:flutter/material.dart';

class CardEntryForm extends StatelessWidget {
  final Function(String cardNumber, String expiryDate, String cvv) onPaymentSubmitted;

  const CardEntryForm({super.key, required this.onPaymentSubmitted});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _cardNumberController = TextEditingController();
    final TextEditingController _expiryDateController = TextEditingController();
    final TextEditingController _cvvController = TextEditingController();

    return AlertDialog(
      title: const Text('Enter Card Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _cardNumberController,
            decoration: const InputDecoration(labelText: 'Card Number'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _expiryDateController,
            decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _cvvController,
            decoration: const InputDecoration(labelText: 'CVV'),
            keyboardType: TextInputType.number,
            obscureText: true,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Pass the entered card details to the callback function
            onPaymentSubmitted(
              _cardNumberController.text,
              _expiryDateController.text,
              _cvvController.text,
            );
          },
          child: const Text('Submit Payment'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
