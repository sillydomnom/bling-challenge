import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bling_challenge/bling_challenge.dart';
import 'package:mocktail/mocktail.dart';

class MockAgifyRepository extends Mock implements AgifyRepository {}

void main() {
  late AgifyRepository agifyRepository;

  setUp(() {
    agifyRepository = MockAgifyRepository();
  });

  group('AgifyBloc', () {
    blocTest<AgifyBloc, AgifyState>( 
      'should emit [LoadInProgress, LoadSuccess] when age could be retrieved',
      setUp: () => when(() => agifyRepository.getAgeForName(name: 'test')).thenAnswer((_) async => 12),
      build: () => AgifyBloc(agifyRepository: agifyRepository),
      act: (bloc) => bloc.add(const AgifyLoadNameStarted(name: 'test')),
      expect: () => [
        AgifyAgeRetrievalInProgress(),
        const AgifyAgeRetrieved(age: 12),
      ],
    );

    blocTest<AgifyBloc, AgifyState>(
      'should emit [LoadInProgress, LoadFailure] when age could not be retrieved',
      setUp: () => when(() => agifyRepository.getAgeForName(name: 'test')).thenAnswer((_) async => throw Error()),
      build: () => AgifyBloc(agifyRepository: agifyRepository),
      act: (bloc) => bloc.add(const AgifyLoadNameStarted(name: 'test')),
      expect: () => [
        AgifyAgeRetrievalInProgress(),
        AgifyAgeRetrievalFailure(),
      ],
    );
  });
}
