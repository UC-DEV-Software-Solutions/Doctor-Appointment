import 'package:flutter/material.dart';

class PaymentSelectionDialog extends StatelessWidget {
  final Function(String) onPaymentOptionSelected; // Callback to handle selected option

  const PaymentSelectionDialog({super.key, required this.onPaymentOptionSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Payment Option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Pay Online'),
            leading: Radio<String>(
              value: 'Pay Online',
              groupValue: null, // Can be used to manage state if needed
              onChanged: (String? value) {
                Navigator.of(context).pop(); // Close the dialog
                onPaymentOptionSelected('Pay Online'); // Callback to pass the selection
              },
            ),
          ),
          ListTile(
            title: const Text('Pay at Medical Center'),
            leading: Radio<String>(
              value: 'Pay at Medical Center',
              groupValue: null,
              onChanged: (String? value) {
                Navigator.of(context).pop(); // Close the dialog
                onPaymentOptionSelected('Pay at Hospital'); // Callback to pass the selection
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Close the dialog without selection
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
