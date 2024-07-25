import 'dart:convert';

import 'package:bling_challenge/bling_challenge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  late Client httpClient;
  late Map<String, dynamic> mockResponse;

  setUp(() {
    httpClient = MockClient();

    mockResponse = {
      'name': 'test',
      'age': 12,
      'count': 1,
    };
  });

  AgifyApiClient createApiClient() {
    return AgifyApiClient(httpClient: httpClient);
  }

  group('Agify Api Client', () {
    test('should return AgifyDTO when http request was successful', () async {
      when(() => httpClient.get(Uri.parse('https://api.agify.io?name=test'))).thenAnswer((_) async => Response(jsonEncode(mockResponse), 200));
      final apiClient = createApiClient();

      final agifyDTO = await apiClient.retrieveAgeForName('test');
      expect(agifyDTO, const AgifyDTO(name: 'test', age: 12, count: 1));
    });

    test('should throw Error when http request was unsuccessful', () async {
      when(() => httpClient.get(Uri.parse('https://api.agify.io?name=test'))).thenAnswer((_) async => throw Error());
      final apiClient = createApiClient();

      expect(() async => await apiClient.retrieveAgeForName('test'), throwsA(isA<Error>()));
    });
  });
}