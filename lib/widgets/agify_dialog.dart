import 'package:flutter/material.dart';

class AgifyDialog extends StatelessWidget {
  final String title;
  final String body;

  const AgifyDialog._({
    required this.title,
    required this.body,
  });

  factory AgifyDialog.error() => const AgifyDialog._(
        title: 'Unexpected Error',
        body: 'There was an error evaluating the age. Please try again later.',
      );

  factory AgifyDialog.success({required int age}) => AgifyDialog._(
        title: 'You are $age years old',
        body: 'I hope this is correct for you!',
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
