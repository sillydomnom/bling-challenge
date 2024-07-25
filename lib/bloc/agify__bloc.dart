import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/agify_repository.dart';

part 'agify__event.dart';

part 'agify__state.dart';

class AgifyBloc extends Bloc<AgifyEvent, AgifyState> {
  final AgifyRepository _agifyRepository;

  AgifyBloc({
    required AgifyRepository agifyRepository,
  })  : _agifyRepository = agifyRepository,
        super(AgifyInitial()) {
    on<AgifyLoadNameStarted>((event, emit) async {
      emit(AgifyAgeRetrievalInProgress());

      try {
        final age = await _agifyRepository.getAgeForName(name: event.name);

        emit(AgifyAgeRetrieved(age: age));
      } catch (e) {
        log(e.toString());

        emit(AgifyAgeRetrievalFailure());
      }
    });
  }
}
