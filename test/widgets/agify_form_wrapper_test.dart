import 'dart:async';

import 'package:bling_challenge/bling_challenge.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockDiProvider extends Mock implements DiProvider {}

class MockAgifyBloc extends MockBloc<AgifyEvent, AgifyState>
    implements AgifyBloc {}

void main() {
  late DiProvider diProvider;
  late AgifyBloc agifyBloc;
  late StreamController<AgifyState> streamController;

  setUp(() {
    diProvider = MockDiProvider();
    agifyBloc = MockAgifyBloc();
    streamController = StreamController();

    when(() => diProvider.get<AgifyBloc>()).thenReturn(agifyBloc);
    when(() => agifyBloc.state).thenReturn(AgifyInitial());
    whenListen(agifyBloc, streamController.stream, initialState: AgifyInitial());
  });

  Future<void> pumpWidget(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Provider.value(
          value: diProvider,
          child: const AgifyFormWrapper(
            child: SizedBox.shrink(),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  group('Agify Form Wrapper', () {
    testWidgets(
      'should open Error dialog when there is an error',
      (tester) async {
        await pumpWidget(tester);

        streamController.add(AgifyAgeRetrievalFailure());
        await tester.pumpAndSettle();

        expect(find.byType(AgifyDialog), findsOneWidget);
        expect(find.text('Unexpected Error'), findsOneWidget);
      },
    );

    testWidgets(
      'should open success dialog when there is an age retrieved',
      (tester) async {
        await pumpWidget(tester);

        streamController.add(const AgifyAgeRetrieved(age: 12));
        await tester.pumpAndSettle();

        expect(find.byType(AgifyDialog), findsOneWidget);
        expect(find.text('You are 12 years old'), findsOneWidget);
      },
    );
  });
}
