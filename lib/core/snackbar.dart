import 'package:flutter/material.dart';

class AppSnackbar {
  static Color _getBackgroundColor(Status status) {
    switch (status) {
      case Status.error:
        return Colors.redAccent;
      case Status.success:
        return Colors.green;
      case Status.info:
        return Colors.blueAccent;
    }
  }

  static IconData? _getIcon(Status status) {
    switch (status) {
      case Status.error:
        return Icons.error_outline;
      case Status.success:
        return Icons.check_circle_outline;
      case Status.info:
        return Icons.info_outline;
    }
  }

  static void show(
    BuildContext context, {
    required String msg,
    Status status = Status.info,
  }) {
    // Define the background color based on the type
    final backgroundColor = _getBackgroundColor(status);
    final icon = _getIcon(status);

    ScaffoldMessenger.of(context).clearSnackBars(); // Clear existing SnackBars
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

enum Status { error, success, info }
