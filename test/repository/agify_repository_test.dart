import 'package:bling_challenge/bling_challenge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAgifyApiClient extends Mock implements AgifyApiClient {}

void main() {
  late AgifyApiClient apiClient;
  
  setUp(() {
    apiClient = MockAgifyApiClient();
  });

  AgifyRepository createRepository() {
    return AgifyRepository(apiClient: apiClient);
  }
  
  group('Agify Repository', () {
    test('should return age when api request was successful', () async {
      when(() => apiClient.retrieveAgeForName('test')).thenAnswer((_) async => const AgifyDTO(name: 'test', age: 12, count: 1));
      final repository = createRepository();

      final age = await repository.getAgeForName(name: 'test');
      expect(age, 12);
    });

    test('should rethrow error when api request was unsuccessful', () async {
      when(() => apiClient.retrieveAgeForName('test')).thenAnswer((_) async => throw Error());
      final repository = createRepository();

      expect(() async => await repository.getAgeForName(name: 'test'), throwsA(isA<Error>()));
    });
  });
}