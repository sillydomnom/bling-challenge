part of 'agify__bloc.dart';

sealed class AgifyState extends Equatable {
  const AgifyState();

  @override
  List<Object?> get props => [];
}

final class AgifyInitial extends AgifyState {}

final class AgifyAgeRetrieved extends AgifyState {
  final int age;

  const AgifyAgeRetrieved({
    required this.age,
  });

  @override
  List<Object?> get props => [age];
}

final class AgifyAgeRetrievalInProgress extends AgifyState {}

final class AgifyAgeRetrievalFailure extends AgifyState {}
