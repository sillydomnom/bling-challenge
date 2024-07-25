import 'package:bling_challenge/bling_challenge.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockDiProvider extends Mock implements DiProvider {}

class MockAgifyBloc extends MockBloc<AgifyEvent, AgifyState> implements AgifyBloc {}

void main() {
  late DiProvider diProvider;
  late AgifyBloc agifyBloc;

  setUp(() {
    diProvider = MockDiProvider();
    agifyBloc = MockAgifyBloc();

    when(() => diProvider.get<AgifyBloc>()).thenReturn(agifyBloc);
    when(() => agifyBloc.state).thenReturn(AgifyInitial());
  });

  Future<void> pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Provider.value(
            value: diProvider,
            child: const AgifyForm(),
          ),
        ),
      ),
    );
  }

  group('Agify Form', () {
    testWidgets('should have correct outline', (tester) async {
      await pumpWidget(tester);

      expect(find.text("Evaluate your Age by your name!"), findsOneWidget);
      expect(
          find.text(
              "Please enter your name to get evaluated by high-tech AI Models:"),
          findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.byType(AgifyFormSubmit), findsOneWidget);
    });

    testWidgets('should add event to [AgifyBloc] when form is submitted', (tester) async {
      await pumpWidget(tester);

      await tester.enterText(find.byType(TextFormField), 'test');
      await tester.pump();

      await tester.tap(find.byType(AgifyFormSubmit));
      await tester.pump();

      verify(() => agifyBloc.add(const AgifyLoadNameStarted(name: 'test'))).called(1);
    });
  });
}
