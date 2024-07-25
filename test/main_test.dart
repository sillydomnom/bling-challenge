import 'package:bling_challenge/bling_challenge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('Bling Challenge App', () {
    testWidgets('should have correct outline', (tester) async {
      await tester.pumpWidget(const BlingChallengeApp());

      expect(find.byType(Provider<DiProvider>), findsOneWidget);
      expect(find.byType(BlingChallengeHomePage), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(AgifyFormWrapper), findsOneWidget);
      expect(find.byType(AgifyForm), findsOneWidget);
    });
  });
}
