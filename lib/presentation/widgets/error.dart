import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.message,
    super.key,
    this.onPressed,
    this.label,
  });
  final String message;

  final void Function()? onPressed;
  final String? label;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            if (label != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: onPressed,
                    child: Text(label!),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
