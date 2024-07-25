import 'package:bling_challenge/bling_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeRoute extends Fake implements Route<dynamic> {}

void main() {
  late NavigatorObserver navigatorObserver;

  setUp(() {
    navigatorObserver = MockNavigatorObserver();
  });

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  Future<void> pumpWidget(
    WidgetTester tester, {
    required bool success,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: success ? AgifyDialog.success(age: 12) : AgifyDialog.error(),
        navigatorObservers: [navigatorObserver],
      ),
    );
  }

  group('Agify Dialog', () {
    group('success', () {
      testWidgets('should have correct widget outline', (tester) async {
        await pumpWidget(tester, success: true);

        expect(find.text('You are 12 years old'), findsOneWidget);
        expect(find.text('I hope this is correct for you!'), findsOneWidget);
      });
    });

    group('error', () {
      testWidgets('should have correct widget outline', (tester) async {
        await pumpWidget(tester, success: false);

        expect(find.text('Unexpected Error'), findsOneWidget);
        expect(
            find.text(
                'There was an error evaluating the age. Please try again later.'),
            findsOneWidget);
      });
    });

    testWidgets('should pop when button is clicked', (tester) async {
      await pumpWidget(tester, success: false);

      await tester.tap(find.text('OK'));
      await tester.pump();

      verify(() => navigatorObserver.didPush(any(), any())).called(1);
    });
  });
}
