import 'package:bling_challenge/bling_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

abstract class CallbackTester {
  void callback();
}

class MockCallbackTester extends Mock implements CallbackTester {}

void main() {
  late CallbackTester callbackTester;

  setUp(() {
    callbackTester = MockCallbackTester();
  });

  Future<void> pumpWidget(
    WidgetTester tester, {
    bool loading = false,
    String text = 'test',
  }) async {
    final editingController = TextEditingController(text: text);

    await tester.pumpWidget(
      MaterialApp(
        home: AgifyFormSubmit(
          loading: loading,
          onSubmit: callbackTester.callback,
          editingController: editingController,
        ),
      ),
    );
    await tester.pump();
  }

  Future<void> submitButton(WidgetTester tester) async {
    await tester.tap(find.text('Evaluate!'));
    await tester.pump();
  }

  group('Agify Form Submit', () {
    testWidgets('should be disabled when text field is empty', (tester) async {
      await pumpWidget(tester, text: '');

      await submitButton(tester);

      verifyNever(() => callbackTester.callback());
    });

    testWidgets('should be enabled when text field is not empty',
        (tester) async {
      await pumpWidget(tester);

      await submitButton(tester);

      verify(() => callbackTester.callback()).called(1);
    });

    testWidgets('should be loading when loading is true', (tester) async {
      await pumpWidget(tester, loading: true);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
