import 'package:flutter/material.dart';

import 'cardEntryForm.dart';

class PaymentSelectionDialog extends StatefulWidget {
  final Function(String) onPaymentOptionSelected;

  const PaymentSelectionDialog({
    super.key,
    required this.onPaymentOptionSelected,
  });

  @override
  _PaymentSelectionDialogState createState() => _PaymentSelectionDialogState();
}

class _PaymentSelectionDialogState extends State<PaymentSelectionDialog> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Payment Option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('Pay Online'),
            value: 'Pay Online',
            groupValue: _selectedPaymentMethod,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentMethod = value;
              });

              if (value == 'Pay Online') {
                Navigator.of(context).pop(); // Close the payment option dialog
                // Open card entry form
                showDialog(
                  context: context,
                  builder: (context) => CardEntryForm(
                    onPaymentSubmitted: (cardNumber, expiryDate, cvv) {
                      // Handle card payment submission here
                      print('Card Number: $cardNumber');
                      print('Expiry Date: $expiryDate');
                      print('CVV: $cvv');
                    },
                  ),
                );
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Pay at Hospital'),
            value: 'Pay at Hospital',
            groupValue: _selectedPaymentMethod,
            onChanged: (String? value) {
              setState(() {
                _selectedPaymentMethod = value;
              });
              widget.onPaymentOptionSelected('Pay at Hospital');
              Navigator.of(context).pop(); // Close dialog
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
