import 'package:flutter/material.dart';

class StatusBanner extends StatelessWidget {

  final String? message;
  final bool isSuccess;

  const StatusBanner({
    required this.message,
    this.isSuccess = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (message == null) return const SizedBox.shrink(); // Hide widget if no message

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: isSuccess ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
      child: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSuccess ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}