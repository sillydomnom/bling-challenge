part of 'agify__bloc.dart';

sealed class AgifyEvent extends Equatable {
  const AgifyEvent();
}

final class AgifyLoadNameStarted extends AgifyEvent {
  final String name;

  const AgifyLoadNameStarted({
    required this.name,
  });

  @override
  List<Object?> get props => [
        name,
      ];
}
