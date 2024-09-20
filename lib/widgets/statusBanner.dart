import 'dart:async';

import 'package:flutter/material.dart';

class StatusBanner extends StatefulWidget {

  final String? message;
  final bool isSuccess;

  const StatusBanner({
    required this.message,
    this.isSuccess = true,
    Key? key,
  }) : super(key: key);

  @override
  State<StatusBanner> createState() => _StatusBannerState();
}

class _StatusBannerState extends State<StatusBanner> {

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    // Start a timer that hides the banner after 3 seconds
    if (widget.message != null) {
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _isVisible = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (widget.message == null || !_isVisible) {
      return const SizedBox.shrink(); // Hide widget if no message
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: widget.isSuccess ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
      child: Row(
        children: [
          Icon(
            widget.isSuccess ? Icons.check_circle : Icons.error,
            color: widget.isSuccess ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.message!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.isSuccess ? Colors.green : Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}