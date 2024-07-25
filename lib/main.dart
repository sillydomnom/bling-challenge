import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/di_provider.dart';
import 'widgets/agify_form.dart';
import 'widgets/agify_form_wrapper.dart';

void main() {
  runApp(const BlingChallengeApp());
}

class BlingChallengeApp extends StatelessWidget {
  const BlingChallengeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
        useMaterial3: true,
      ),
      home: Provider<DiProvider>(
        create: (context) => DiProvider(),
        child: const BlingChallengeHomePage(),
      ),
    );
  }
}

class BlingChallengeHomePage extends StatelessWidget {
  const BlingChallengeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Bling Challenge'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: AgifyFormWrapper(
          child: AgifyForm(),
        ),
      ),
    );
  }
}
