part of 'person_search_bloc.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();

  @override
  List<Object> get props => [];
}

class PersonEmpty extends PersonSearchState { }

class PersonSearchLoading extends PersonSearchState {}

class PersonSearchLoaded extends PersonSearchState {
  const PersonSearchLoaded({required this.persons});

  final List<PersonEntity> persons;

  @override
  List<Object> get props => [persons];
}

class PersonSearchError extends PersonSearchState{
  const PersonSearchError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}